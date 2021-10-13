%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);

extern int num, op, paren, eq;


%}
/* %token means tokens dont have precedence */
%left LEFT_PAREN RIGHT_PAREN 
%left PLUS
%left MINUS
%left MULT
%left DIVIDE
/* %left means tokens have assign left associativity */
%right EQUAL
/* %right means tokens have assign right associativity */
%token DIGIT
/* %union specifies entire collection of possible data types */
%start expr 
%%

expr: LEFT_PAREN expr RIGHT_PAREN expr 
	|DIGIT expr
	|PLUS expr
	|MINUS expr
	|MULT expr
	|DIVIDE expr
	|EQUAL expr
	|
;

%%

int main() { 
  yyin = stdin;

  do {
    printf("Parse.\n");
    yyparse();
  } while(!feof(yyin));
  printf("# of integers: %d\n", num);
  printf("# of operations: %d\n", op);
  printf("# of parenthesis: %d\n", paren);
  printf("# of equals: %d\n", eq);
  printf("Parenthesis are balanced!\n");
  return 0;
}

void yyerror(const char* s) {
  fprintf(stderr, "Parse error: %s. Parenthesis are not balanced!\n", s);
  exit(1);
}

