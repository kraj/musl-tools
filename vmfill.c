#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>

#ifndef PAGE_SIZE
	#define PAGE_SIZE sysconf(_SC_PAGE_SIZE)
#endif

static void printvm() {
	int fd = open("/proc/self/smaps", O_RDONLY);
	char buf[4096];
	int n;

	printf("/proc/self/smaps:\n");
	fflush(stdout);
	while ((n = read(fd, buf, sizeof buf)) > 0)
		write(1, buf, n);
	close(fd);
}

static size_t mmapmax(int fd, void **p) {
	size_t i,j,n=0;

	for (i=j=SIZE_MAX/2+1; i>=PAGE_SIZE; i/=2) {
		if ((*p=mmap(NULL, j, PROT_NONE, MAP_PRIVATE, fd, 0)) == MAP_FAILED)
			j -= i/2;
		else {
			n = j;
			munmap(*p, n);
			j += i/2;
		}
	}
	if (n && (*p=mmap(NULL, n, PROT_NONE, MAP_PRIVATE, fd, 0)) == MAP_FAILED) {
		fprintf(stderr, "failed to mmap the same amount again.\n");
		exit(1);
	}
	return n;
}

int main(int argc, char *argv[]) {
	const int fd = open("/dev/zero", O_RDWR);
	void *p[100];
	size_t n[100];
	size_t sum = 0;
	int i;
	int vmmaps = 0;

	if (argc == 2 && argv[1][0]=='-' && argv[1][1]=='v')
		vmmaps = 1;

	for (i=0; i<sizeof p/sizeof *p; i++) {
		n[i] = mmapmax(fd, p+i);
		if (!n[i])
			break;
		sum += n[i];
		printf("%d %16zu B %012zx-%012zx\n", i, n[i], (size_t)p[i], (size_t)p[i]+n[i]);
	}
	printf("mmaped %zu B in %d blocks.\n", sum, i);

	printf("try malloc:");
	for(i=0; i < 1000 && malloc(PAGE_SIZE) != NULL; i++)
		printf(".");
	printf(" %zu B\n", i*(size_t)PAGE_SIZE);

	if (vmmaps)
		printvm();
	return 0;
}
