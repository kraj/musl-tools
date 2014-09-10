MUSL=../musl

all: tables sizeof abi

clean:
	rm -f sizeof*.o sizeof-glibc sizeof-musl sizeof.diff tab_*.html

tables:
	MUSL=$(MUSL) ./update.sh

sizeof: sizeof-glibc sizeof-musl
	./sizeof-glibc >data/sizeof.ARCH.glibc
	./sizeof-musl >data/sizeof.ARCH.musl
	diff -U1 data/sizeof.ARCH.glibc data/sizeof.ARCH.musl >data/sizeof.ARCH.diff || true

LIBGCC=`gcc -print-file-name=libgcc.a |sed 's,/libgcc.a$$,,'`
# when compiling with pcc
#PCC=`pcc -v foobar.o 2>&1 |sed -n 's,.* \([^ ]*\)/lib/crtbegin.o.*,\1,p'`

sizeof.c:
	./sizeof.sh

sizeof-glibc: sizeof.c
	gcc -std=gnu99 -o $@ $<
sizeof-musl: sizeof.c
	gcc -std=gnu99 -nostdinc -fno-stack-protector -isystem $(MUSL)/include -isystem $(LIBGCC) -isystem /usr/include -c -o $@.o $<
	ld -o $@ $@.o -X -d -e _start -Bstatic $(MUSL)/lib/crti.o $(MUSL)/lib/crt1.o $(MUSL)/lib/crtn.o -L$(MUSL)/lib -lc -L$(LIBGCC) -lgcc -nostdlib
#	ld -o $@ $@.o $(MUSL)/lib/crti.o $(MUSL)/lib/crt1.o $(MUSL)/lib/crtn.o -L$(MUSL)/lib -lc -dynamic-linker $(MUSL)/lib/libc.so -L$(LIBGCC) -lgcc -nostdlib
#	pcc -nostdinc -isystem $(MUSL)/include -isystem $(PCC)/include -c -o $@.o $<
#	ld -X -d -e _start -Bstatic -o $@ $@.o $(MUSL)/lib/crti.o $(MUSL)/lib/crt1.o $(PCC)/lib/crtbegin.o $(PCC)/lib/crtend.o -L$(MUSL)/lib -lc -L$(PCC)/lib -lpcc -nostdlib

sizeof-g++: sizeof.c
	g++ -std=gnu99 -nostdinc -fno-stack-protector -isystem $(MUSL)/include -isystem $(LIBGCC) -isystem /usr/include -c -o $@.o $<
	ld -o $@ $@.o -X -d -e _start -Bstatic $(MUSL)/lib/crti.o $(MUSL)/lib/crt1.o $(MUSL)/lib/crtn.o -L$(MUSL)/lib -lc -L$(LIBGCC) -lgcc -nostdlib

abi: abi.ARCH.diff
	cp abi.ARCH.* data/

abi.cc:
	./abi.sh
abi.ARCH.glibc: abi.cc
	g++ -c -o $@.o $<
	nm $@.o |sed -n 's/^[[:xdigit:]]* T //p' |c++filt >$@
abi.ARCH.musl: abi.cc
	g++ -nostdinc -fno-stack-protector -isystem $(MUSL)/include -isystem $(LIBGCC) -isystem /usr/include -c -o $@.o $<
	nm $@.o |sed -n 's/^[[:xdigit:]]* T //p' |c++filt >$@
abi.ARCH.diff:  abi.ARCH.glibc abi.ARCH.musl
	diff -U0 $^ >$@ || true
