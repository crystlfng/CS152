%{

#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *msg);
extern int yylex();
extern int yyparse();
extern FILE* yyin;

extern int line;
extern int pos;

%}

/* %union specifies entire collection of possible data types */
%union{
 int num;
 char* ident;
}
/* %token means tokens dont have precedence */
/* %left means tokens have assign left associativity */
/* %right means tokens have assign right associativity */
%token L_PAREN R_PAREN 
%token ADD SUB MULT DIV EQ
%token <num> NUMBER
%token <ident> IDENT
%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS 
%token BEGIN_BODY END_BODY ARRAY OF IF THEN ENDIF ELSE
%token WHILE DO BEGINLOOP ENDLOOP CONTINUE READ WRITE AND OR
%token NOT TRUE FALSE RETURN MOD NEQ LT GT LTE GTE
%token INTEGER SEMICOLON COLON COMMA 
%token L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN
%start prog_start
/* RULES: loops are denoted with an s ex.) vars, statemets, declarations, etc*/ 
%%

prog_start:	functions {printf("prog_start -> functions\n");}
		| {printf("prog_start -> epsilon\n");}
;

function: 	FUNCTION IDENT SEMICOLON 
		BEGIN_PARAMS declarations END_PARAMS
		BEGIN_LOCALS declarations END_LOCALS
		BEGIN_BODY statements END_BODY
		{printf("function-> FUNCTION IDENT SEMICOLON BEGIN_PARAMS decalarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statement END_BODY\n");}
;

functions:	function functions {printf("functions -> function functions\n");}
		|{printf("functions -> epsilon"\n);}
;

identifier: 	IDENT {printf("identifier -> IDENT %s\n",$1);}
;

identifiers: 	identifier COMMA identifiers 
		{printf("identifiers -> identifier COMMA indentifiers\n");}
		| identifier {printf("identifiers -> identifier\n");}
;

declaration:	identifiers COLON INTEGER 
		{printf("declaration -> identifiers COLON INTEGER\n");}
		| identifiers COLON 
		  ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER
		{printf("declaration -> identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n");}
;

declarations:	declaration SEMICOLON declarations
		{printf("declarations -> declaration SEMICOLON declarations\n");}
		|{printf("declarations -> epsilon\n");}
;

statement:	var ASSIGN expression {printf("statement -> var ASSIGN expression\n");}
		| IF boolexpr THEN statements ENDIF
		{printf("statement -> IF boolexpr THEN statements ENDIF\n");}
		| IF boolexpr THEN statements ELSE statements ENDIF
		{printf("statement -> IF boolexpr THEN statements ELSE statements ENDIF\n");}
		| WHILE boolexpr BEGINLOOP statements ENDLOOP
		{printf("statement -> WHILE boolexpr BEGIN_LOOP statements END_LOOP\n");}
		| DO BEGINLOOP statements ENDLOOP WHILE boolexpr
		{printf("statement -> DO BEGIN_LOOP statements ENDLOOP WHILE boolexpr\n");}
		| READ vars {printf("statement -> READ vars\n");}
		| WRITE vars {printf("statement -> WRITE vars\n");}
		| CONTINUE {printf("statement -> CONTINUE\n");}
		| RETURN expression {printf("statement -> RETURN expression\n");}
;

statements:	statement SEMICOLON statements 
		{printf("statements ->statement SEMICOLON statements\n");}
		|{printf("statements -> epsilon\n");}
;

boolexpr:	relationandexpr OR relationandexpr 
		{printf("boolexpr -> relationandexpr OR relationandexpr\n");}
		| relationandexpr {printf("boolexpr -> relationandexpr\n");}
;

relationandexpr:	relationandexpr AND relationexpr
			{printf("relationandexpr -> relationexpr AND relationexpr\n");}
			|relationexpr {printf("relationandexpr -> relationexpr\n");}
;

relationexpr:	expression comp expression
		{printf("relationexpr -> expression comp expression\n");}
		| NOT expression comp expression
		{printf("relationexpr -> NOT expression comp expression\n");}
		| TRUE {printf("relationexpr -> TRUE\n");}
		| NOT TRUE {printf("relationexpr -> NOT TRUE\n");}
		| FALSE {printf("relationexpr -> FALSE\n");}
		| NOT FALSE {printf("relationexpr -> NOT FALSE\n");}
		| L_PAREN boolexpr R_PAREN 
		{printf("relationexpr -> L_PAREN boolexpr R_PAREN\n");}
;

comp:	EQ {printf("comp -> EQ\n");}
	| NEQ {printf("comp -> NEQ\n");}
	| LT {printf("comp -> LT\n");}
	| GT {printf("comp -> GT\n");}
	| LTE {printf("comp -> LTE\n");}
	| GTE {printf("comp -> GTE\n");}
;

expression:	expression ADD multiplicativeexpr
		{printf("expression -> multiplicativeexpr PLUS multiplicativeexpr\n");}
		| expression SUB multiplicativeexpr
		{printf("expression -> multiplicativeexpr SUB multiplicativeexpr\n");}
		| multiplicativeexpr
		{printf("expression -> multiplicativeexpr\n");}
;

multiplicativeexpr:	term MOD term {printf("multiplicativeexpr -> term MOD term\n");}
			| term DIV term {printf("multiplicativeexpr -> term DIV term\n");}
			| term MULT term {printf("multiplicative -> term MULT term\n");}
			| term {printf("multiplicativeexpr -> term\n");}
;

term:	var {printf("term -> var \n");}
	| NUMBER {printf("term -> NUMBER\n");}
	| L_PAREN expression R_PAREN {printf("term -> L_PAREN expression R_PAREN\n");}
	| SUB var {printf("term -> SUB var\n");}
	| SUB NUMBER {printf("term -> SUB NUMBER\n");}
	| SUB L_PAREN expression R_PAREN 
	{printf("term -> SUB L_PAREN expression R_PAREN\n");}
	| IDENT L_PAREN expressions R_PAREN
	{printf("term -> IDENT L_PAREN expressions R_PAREN\n");}
;

expressions:	expression {printf("expressions -> expression\n");}
		| expression COMMA expressions 
		{printf("expressions -> expression COMMA expressions\n");}
		| {printf("expressions -> epsilon\n");}
;

var:	IDENT {printf("var -> IDENT\n");}
	| IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET
	{printf("var -> IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET\n");}
;

vars: 	var {printf("vars -> var\n");}
	| var COMMA vars {printf("vars -> var COMMA vars\n");}
;

%%

int main(int argc, char ** argv) {
   yyin = stdin;

  do {
    yyparse();
  } while(!feof(yyin));
   return 0;
}

void yyerror(const char *msg) {
    printf("SOMETHING UNEXPECTED HAPPENED: Line %d, position %d: %s \n", line, pos, msg);
}	
