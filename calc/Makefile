all: calc

calc: calc.yy.c calc.tab.c
	gcc -g3 -o $@ $^

%.yy.c: %.l
	flex -o $@ $<

%.tab.c: %.y
	bison -d $<

.PHONY: clean
clean:
	rm -vf *.yy.c *.tab.c *.tab.h calc
