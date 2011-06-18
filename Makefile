MUSL=../musl

all: tables sizeof

clean:
	rm -f sizeof*.o sizeof-glibc sizeof-musl sizeof.diff tab_*.html

tables: tags syms
	MUSL=$(MUSL) ./tab_c99.sh
	MUSL=$(MUSL) ./tab_posix.sh

tags:
	MUSL=$(MUSL) ./maketags.sh

syms:
	MUSL=$(MUSL) ./makesyms.sh

sizeof: sizeof-glibc sizeof-musl
	./sizeof-glibc >data/glibc.sizeof
	./sizeof-musl >data/musl.sizeof
	diff -u data/glibc.sizeof data/musl.sizeof >sizeof.diff || true

LIBGCC=`gcc -print-file-name=libgcc.a |sed 's,/libgcc.a$$,,'`
# when compiling with pcc
#PCC=`pcc -v foobar.o 2>&1 |sed -n 's,.* \([^ ]*\)/lib/crtbegin.o.*,\1,p'`

sizeof-glibc: sizeof.c
	gcc -o $@ $<
sizeof-musl: sizeof.c
	gcc -std=gnu99 -nostdinc -fno-stack-protector -isystem $(MUSL)/include -isystem $(LIBGCC) -c -o $@.o $<
	ld -o $@ $@.o $(MUSL)/lib/crti.o $(MUSL)/lib/crt1.o $(MUSL)/lib/crtn.o -L$(MUSL)/lib -lc -L$(LIBGCC) -lgcc -nostdlib
#	pcc -nostdinc -isystem $(MUSL)/include -isystem $(PCC)/include -c -o $@.o $<
#	ld -X -d -e _start -Bstatic -o $@ $@.o $(MUSL)/lib/crti.o $(MUSL)/lib/crt1.o $(PCC)/lib/crtbegin.o $(PCC)/lib/crtend.o -L$(MUSL)/lib -lc -L$(PCC)/lib -lpcc -nostdlib
