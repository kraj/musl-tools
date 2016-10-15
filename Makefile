all: tables abi

clean:
	rm -f sizeof*.o sizeof-glibc sizeof-musl sizeof.diff tab_*.html

tables:
	MUSL=$(MUSL) ./update.sh
abi: data/abi_type.x86_64.musl data/abi_func.x86_64.musl

abi_type.x86_64.cc abi_func.cc: tables

data/abi_type.x86_64.musl: abi_type.x86_64.cc
	CXX=g++ ./abi_type_data.sh >$@
data/abi_func.x86_64.musl: abi_func.cc
	CXX=g++ ./abi_func_data.sh >$@


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

#abi: abi.ARCH.diff
#	cp abi.ARCH.* data/

#abi_type.cc:
#	./abi_type.sh
abi.ARCH.glibc: abi_type.cc
	g++ -std=c++11 $(GLIBC_FLAGS) -c -o $@.o $<
	nm -C $@.o |sed -n 's/^[[:xdigit:]]* T //p' |sort >$@
abi.ARCH.musl: abi_type.cc
	g++ -std=c++11 -nostdinc -fno-stack-protector -isystem $(MUSL)/include -isystem $(LIBGCC) -isystem /usr/include -c -o $@.o $<
	nm -C $@.o |sed -n 's/^[[:xdigit:]]* T //p' |sort >$@
abi.ARCH.diff:  abi.ARCH.glibc abi.ARCH.musl
	diff -U0 $^ >$@ || true
