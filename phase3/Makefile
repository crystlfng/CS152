all:your_compiler 
mini_l.tab.c mini_l.tab.h:	mini_l.y
	bison -t -v -d mini_l.y
lex.yy.c: mini_l.lex mini_l.tab.h
	flex mini_l.lex 
your_compiler: lex.yy.c mini_l.tab.c mini_l.tab.h
	g++ -std=c++11 -o your_compiler mini_l.tab.c lex.yy.c -lfl
clean:
	rm mini_l.tab.c lex.yy.c mini_l.tab.h mini_l.output
