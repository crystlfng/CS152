/*
identifier can only start with letter
canend with a digit or letter
*/
%option noyywrap

digit			[0-9]
letter			[a-zA-Z]
identifier		({letter}({digit}|{letter}|"_")*({digit}|{letter}))|{letter}*
invalid_end		{identifier}"_"
invalid_begin		{digit}({digit}|{letter}|"_")*
comment			##.*\n
whitespace		" "
%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "y.tab.h"
#include <math.h>
int line = 1;
int pos = 1;
%}

%%
		
function	pos+=yyleng; return FUNCTION;
beginparams	pos+=yyleng; return BEGIN_PARAMS;
endparams	pos+=yyleng; return END_PARAMS;
beginlocals	pos+=yyleng; return BEGIN_LOCALS;
endlocals	pos+=yyleng; return END_LOCALS;
beginbody	pos+=yyleng; return BEGIN_BODY;
endbody		pos+=yyleng; return END_BODY;
integer		pos+=yyleng; return INTEGER;
array		pos+=yyleng; return ARRAY;
of		pos+=yyleng; return OF;
if		pos+=yyleng; return IF;
then		pos+=yyleng; return THEN;
endif		pos+=yyleng; return ENDIF;
else		pos+=yyleng; return ELSE;
while		pos+=yyleng; return WHILE;
do		pos+=yyleng; return DO;
beginloop	pos+=yyleng; return BEGINLOOP;
endloop		pos+=yyleng; return ENDLOOP;
continue	pos+=yyleng; return CONTINUE;
read		pos+=yyleng; return READ;
write		pos+=yyleng; return WRITE;
and		pos+=yyleng; return AND;
or		pos+=yyleng; return OR;
not		pos+=yyleng; return NOT;
true		pos+=yyleng; return TRUE;
false		pos+=yyleng; return FALSE;
return		pos+=yyleng; return RETURN;

"+"	pos+=yyleng; return ADD;
"-"	pos+=yyleng; return SUB;
"*"	pos+=yyleng; return MULT;
"/"	pos+=yyleng; return DIV;
"%"	pos+=yyleng; return MOD;

"=="	pos+=yyleng; return EQ;
"<>"	pos+=yyleng; return NEQ;
"<"	pos+=yyleng; return LT;
">"	pos+=yyleng; return GT;
"<="	pos+=yyleng; return LTE;
">="	pos+=yyleng; return GTE;

{identifier}	pos+=yyleng; yylval.ident = yytext; return IDENT;
{digit}+ 	pos+=yyleng; yylval.num = atoi(yytext); return NUMBER;

":"	pos+=yyleng; return COLON;
";"	pos+=yyleng; return SEMICOLON;
","	pos+=yyleng; return COMMA;
"("	pos+=yyleng; return L_PAREN;
")"	pos+=yyleng; return R_PAREN;
"["	pos+=yyleng; return L_SQUARE_BRACKET;
"]"	pos+=yyleng; return R_SQUARE_BRACKET;
":="	pos+=yyleng; return ASSIGN;

{invalid_end}		printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n",line,pos,yytext);pos+=yyleng;
{invalid_begin}		printf("Error at line %d, column %d: identifier \"%s\" cannot begin with letter\n",line,pos,yytext);pos+=yyleng;

\n              line++;pos=1; 
[ \t]+		pos+=yyleng;
{comment}	

.       printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n",line,pos,yytext);pos+=yyleng;
%%
