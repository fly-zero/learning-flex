all: wc

wc: wc.yy.c
	gcc -g -o $@ $<

%.yy.c: %.l
	flex -o $@ $<

.PHONY: clean
clean:
	rm -vf *.yy.c wc
