/*
identifier can only start with letter
canend with a digit or letter
*/

digit			[0-9]
letter			[a-zA-Z]
identifier		({letter}({digit}|{letter}|"_")*({digit}|{letter}))|{letter}*
invalid_end		{identifier}"_"
invalid_begin		{digit}({digit}|{letter}|"_")*
comment			##.*\n
whitespace		" "
%{
#include <math.h>
int line = 1;
int pos = 1;
%}

%%
		
function	printf("FUNCTION\n");pos+=yyleng;
beginparams	printf("BEGIN_PARAMS\n");pos+=yyleng;
endparams	printf("END_PARAMS\n");pos+=yyleng;
beginlocals	printf("BEGIN_LOCALS\n");pos+=yyleng;
endlocals	printf("END_LOCALS\n");pos+=yyleng;
beginbody	printf("BEGIN_BODY\n");pos+=yyleng;
endbody		printf("END_BODY\n");pos+=yyleng;
integer		printf("INTEGER\n");pos+=yyleng;
array		printf("ARRAY\n");pos+=yyleng;
of		printf("OF\n");pos+=yyleng;
if		printf("IF\n");pos+=yyleng;
then		printf("THEN\n");pos+=yyleng;
endif		printf("ENDIF\n");pos+=yyleng;
else		printf("ELSE\n");pos+=yyleng;
while		printf("WHILE\n");pos+=yyleng;
do		printf("DO\n");pos+=yyleng;
beginloop	printf("BEGINLOOP\n");pos+=yyleng;
endloop		printf("ENDLOOP\n");pos+=yyleng;
continue	printf("CONTINUE\n");pos+=yyleng;
read		printf("READ\n");pos+=yyleng;
write		printf("WRITE\n");pos+=yyleng;
and		printf("AND\n");pos+=yyleng;
or		printf("OR\n");pos+=yyleng;
not		printf("NOT\n");pos+=yyleng;
true		printf("TRUE\n");pos+=yyleng;
false		printf("RETURN\n");pos+=yyleng;
return		printf("RETURN\n");pos+=yyleng;

"+"	printf("ADD\n");pos+=yyleng;
"-"	printf("SUB\n");pos+=yyleng;
"*"	printf("MULT\n");pos+=yyleng;
"/"	printf("DIV\n");pos+=yyleng;
"%"	printf("MOD\n");pos+=yyleng;

"=="	printf("EQ\n");pos+=yyleng;
"<>"	printf("NEQ\n");pos+=yyleng;
"<"	printf("LT\n");pos+=yyleng;
">"	printf("GT\n");pos+=yyleng;
"<="	printf("LTE\n");pos+=yyleng;
">="	printf("GTE\n");pos+=yyleng;

{identifier}	printf("IDENT %s\n", yytext);pos+=yyleng;
{digit}+		printf("NUMBER %s\n", yytext);pos+=yyleng;

":"	printf("COLON\n");pos+=yyleng;
";"	printf("SEMICOLON\n");pos+=yyleng;
","	printf("COMMA\n");pos+=yyleng;
"("	printf("L_PAREN\n");pos+=yyleng;
")"	printf("R_PAREN\n");pos+=yyleng;
"["	printf("L_SQUARE_BRACKET\n");pos+=yyleng;
"]"	printf("R_SQUARE_BRACKET\n");pos+=yyleng;
":="	printf("ASSIGN\n");pos+=yyleng;

{invalid_end}		printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n",line,pos,yytext);pos+=yyleng;
{invalid_begin}		printf("Error at line %d, column %d: identifier \"%s\" cannot begin with letter\n",line,pos,yytext);pos+=yyleng;

\n              line++;pos=1; 
[ \t]+		pos+=yyleng;
{comment}	

.       printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n",line,pos,yytext);pos+=yyleng;
%%

main(){
 yylex();
}
