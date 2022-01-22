SRCDIR = src
BUILDDIR = target

$(BUILDDIR)/%.o: $(SRCDIR)/%.asm
	nasm -felf64 -o $@ $<

.PHONY: hello
hello: $(BUILDDIR)/hello.o
	ld -o $(BUILDDIR)/$@ $<

.PHONY: clean
clean:
	rm -rf $(BUILDDIR)
	mkdir $(BUILDDIR)
