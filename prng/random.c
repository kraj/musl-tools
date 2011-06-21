#include <stdlib.h>

/*
32bit unsigned is asssumed

original bsd lagged fibonacci generator params:
	32byte: 7,3
	64byte: 15,1
	128byte: 31,3 (default)
	256byte: 63,1
only the default 128byte version is implemented here
in case of a smaller state buffer an lcg is used
lcg params and initializer are different from the bsd code

implementing other variants is easy with the current code
only the n,i,j should be set up apropriately in initstate and srandom

but a quick google codesearch shows that noone uses this api so why bother
http://www.google.com/codesearch#search/&q=initstate\+*\%28+case:yes

there are better large period generators eg. well512
this one fails on some dieharder tests
(by comparison the top 32bit of a 64bit lcg passes all tests
so it might make sense to just forget about the larger period
and use a 64bit lcg here)
*/

static unsigned init[] = {
0x00000000,0x00000001,0x3c88596c,0x5e8885db,
0x8116017e,0xb4733ac5,0x0cf06d60,0x5e98c13f,
0xc656dd92,0x8e625fc9,0x0438e694,0xa3a5a0e3,
0x401d90e6,0x6c20f30d,0x97377908,0xd64148c7,
0x3c2def7a,0xfb18b891,0xdc6318bc,0x53ae1ceb,
0xaebf0d4e,0x880db455,0x3747f9b0,0x1ac2c14f,
0x120f3e62,0x51a22a59,0x213b8fe4,0xb50e19f3,
0x953816b6,0x611a9e9d,0x43508f58,0xc03b4ad7};

static int n = 31;
static int i = 3;
static int j = 0;
static unsigned *x = init+1;

static unsigned lcg(unsigned x) {
	return 1664525*x + 1013904223;
}

static void *savestate() {
	x[-1] = ((unsigned)n<<16)|(i<<8)|j;
	return x-1;
}

static void loadstate(unsigned *state) {
	x = state+1;
	n = x[-1]>>16;
	i = (x[-1]>>8)&0xff;
	j = x[-1]&0xff;
}

void srandom(unsigned seed) {
	int k;

	i = 3;
	j = 0;
	x[0] = seed;
	for (k = 1; k < n; k++)
		x[k] = lcg(x[k-1]);
}

char *initstate(unsigned seed, char *state, size_t size) {
	void *old = savestate();
	if (size < 8)
		return 0;
	x = (unsigned*)state + 1;
	n = size < 128 ? 0 : 31;
	srandom(seed);
	return old;
}

char *setstate(char *state) {
	void *old = savestate();
	loadstate((unsigned*)state);
	return old;
}

long random(void) {
	unsigned k;

	if (n == 0) {
		x[0] = lcg(x[0]);
		return x[0]>>1;
	}
	x[i] += x[j];
	k = x[i]>>1;
	if (++i == n)
		i = 0;
	if (++j == n)
		j = 0;
	return k;
}
