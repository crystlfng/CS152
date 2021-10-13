%option noyywrap

digit [0-9]+

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "calc.tab.h"

int num=0, op=0, paren=0, eq=0;
%}

%%
[ \t]	; // ignore all whitespace
"("		{paren++; return LEFT_PAREN;}
")"		{paren++; return RIGHT_PAREN;}
"+"		op++; return PLUS;
"-"		op++; return MINUS;
"*"		op++; return MULT;
"/"		op++; return DIVIDE;
"="		eq++; return EQUAL;

{digit} 	num++; return DIGIT;
%%
