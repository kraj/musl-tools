#include <stdio.h>

void srandom(unsigned seed);
char *initstate(unsigned seed, char *state, size_t size);
char *setstate(char *state);
long random(void);

int chk(long *x) {
	int d[10] = {0};
	int i;

	for (i = 0; i < 100; i++)
		d[x[i]%10]++;
	for (i = 0; i < 10; i++)
		if (d[i] < 2)
			return 1;
	return 0;
}

int main() {
	long x[100];
	long y,z;
	int i,j;
	char state[128];
	char *p;
	char *q;

	for (i = 0; i < 100; i++)
		x[i] = random();
	if (chk(x))
		printf("fail rand\n");
	p = initstate(1, state, sizeof state);
	for (i = 0; i < 100; i++)
		if (x[i] != (y = random()))
			printf("fail init %d %ld %ld\n", i, x[i], y);
	for (i = 0; i < 100; i++) {
		z = random();
		q = setstate(p);
		if (z != (y = random()))
			printf("fail set %d %ld %ld\n", i, z, y);
		p = setstate(q);
	}
	srandom(1);
	for (i = 0; i < 100; i++)
		if (x[i] != (y = random()))
			printf("fail srand1 %d %ld %ld\n", i, x[i], y);
	for (j = 0; j < 1000; j++) {
		srandom(j);
		for (i = 0; i < 100; i++) {
			y = random();
			if (x[i] == y)
				printf("fail srand %d %d %ld %ld\n", j, i, x[i], y);
			x[i] = y;
		}
		if (chk(x))
			printf("weak seed %d\n", j);
	}
	return 0;
}
