SRCDIR = src
BUILDDIR = target

CC = gcc
LD = ld
ASM = nasm -felf64

$(BUILDDIR)/%.o: $(SRCDIR)/%.asm
	$(ASM) -o $@ $<

.PHONY: hello
hello: $(BUILDDIR)/hello.o
	$(LD) -o $(BUILDDIR)/$@ $<

.PHONY: stars
stars: $(BUILDDIR)/stars.o
	$(LD) -o $(BUILDDIR)/$@ $<

.PHONY: hello_c
hello_c: $(BUILDDIR)/hello_c.o
	$(CC) -o $(BUILDDIR)/$@ $<

.PHONY: fib
fib: $(BUILDDIR)/fib.o
	$(CC) -o $(BUILDDIR)/$@ $<

.PHONY: maxofthree
maxofthree: $(BUILDDIR)/maxofthree.o $(SRCDIR)/callmaxofthree.c
	$(CC) -o $(BUILDDIR)/$@ $^

.PHONY: echo
echo: $(BUILDDIR)/echo.o
	$(CC) -o $(BUILDDIR)/$@ $<

.PHONY: power
power: $(BUILDDIR)/power.o
	$(CC) -o $(BUILDDIR)/$@ $<

.PHONY: sum
sum: $(BUILDDIR)/sum.o $(SRCDIR)/callsum.c
	$(CC) -o $(BUILDDIR)/$@ $^

.PHONY: average
average: $(BUILDDIR)/average.o
	$(CC) -o $(BUILDDIR)/$@ $<

.PHONY: factorial
factorial: $(BUILDDIR)/factorial.o $(SRCDIR)/callfactorial.c
	$(CC) -o $(BUILDDIR)/$@ $^

.PHONY: add_four_floats
add_four_floats: $(BUILDDIR)/add_four_floats.o $(SRCDIR)/test_add_four_floats.c
	$(CC) -o $(BUILDDIR)/$@ $^

.PHONY: satexample
satexample: $(BUILDDIR)/satexample.o
	$(CC) -o $(BUILDDIR)/$@ $<

.PHONY: clean
clean:
	rm -rf $(BUILDDIR)
	mkdir $(BUILDDIR)
