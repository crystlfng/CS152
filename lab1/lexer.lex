
digit	[0-9]

%{
#include <math.h>
int num = 0;
int op = 0;
int paren = 0;
int equal = 0;
%}

%%
{digit}+	printf("NUMBER %s\n", yytext, atoi(yytext));num++;
"+"	printf("PLUS\n");op++;
"-"	printf("MINUS\n");op++;
"*"	printf("MULT\n");op++;
"/"	printf("DIV\n");op++;
"("	printf("L_PAREN\n");paren++;
")"	printf("R_PAREN\n");paren++;
"="	printf("EQUAL\n");equal++;
.	printf("ERROR invalid input\n");exit(0);
%%

main(){
 printf("Give me your input:\n");
 yylex();
 printf("INTEGER COUNT: %d\nOPERATION COUNT: %d\nPARENTHESES COUNT: %d\nEQUAL: %d\n",num,op,paren,equal);
}
