%{
   #include <iostream>
   #include<stdio.h>
   #include<string>
   #include<vector>
   using namespace std;
   extern int yylex();
        extern int yyparse();
        extern FILE * yyin;
   void yyerror(const char *msg);
   extern int currLine;
   int myError = 0;
   int otherError = 0;
   char *identToken;
   int numberToken;
   int productionID = 0;
   int temp_count = 0;
   struct symbol{
	char* name;
	int val;
	char* type;
	symbol(char* n, int v, char* t){
		name = n;
		val = v;
		type = t;	
	}	
	symbol(){};
   };
   vector<symbol> symbolTable;
   bool find(vector<symbol>, symbol);
%}

%union {
  struct attribute{
	char* name;
	int index;
	char* type;
	int value;
	int size;
  }attribute;
  char *op_val;
  int numberval;
}

%start prog_start
%token BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY
%token FUNCTION RETURN MAIN
%token L_SQUARE_BRACKET
%token R_SQUARE_BRACKET
%token INTEGER ARRAY OF
%token IF THEN ENDIF ELSE
%token WHILE DO BEGINLOOP ENDLOOP  CONTINUE
%token READ WRITE
%token AND OR NOT TRUE FALSE
%token SUB ADD MULT DIV MOD
%token EQ NEQ LT GT LTE GTE
%token SEMICOLON COLON COMMA L_PAREN R_PAREN ASSIGN
%token <numberval>NUMBER 
%token <op_val>IDENT
%type <attribute> prog_start
%type <attribute> function 
%type <attribute> function_ident
%type <attribute> declaration
%type <attribute> ident
%define parse.error verbose

%%

prog_start: 
	functions
		{};

functions: 
	/* epsilon */
		{}
	| function functions
		{};

function: function_ident
	SEMICOLON
	BEGIN_PARAMS declarations END_PARAMS
	BEGIN_LOCALS declarations END_LOCALS
	BEGIN_BODY statements end_body 
{

};

ident: 	IDENT
	{
	$$.name = $1;
	}
;

end_body: END_BODY {
}
;

function_ident: FUNCTION ident{
	symbol temp($2.name,0,"function");
	if(!find(symbolTable, temp)) {
    		symbolTable.push_back(temp);
		printf("func %s\n", $2.name);
	} else {
    		printf("error: function %s already exists", $2.name);
	}
}
;

declarations: 
	/* epsilon */
		{}
	| declaration SEMICOLON declarations
		{};

declaration: 
	IDENT COLON INTEGER
{
	symbol temp;
	temp.name = $1;
	temp.type = "integer";
	if(!find(symbolTable, temp)) {
                symbolTable.push_back(temp);
		printf(". %s\n", $1);
        } else {
                yyerror("variable already exists");
        }
}
	| IDENT COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER
{
	symbol temp; 
	temp.name = $1;
	temp.type = "array";
	if(!find(symbolTable, temp)) {
                symbolTable.push_back(temp);
                printf(".[] %s, %d\n", $1,$5);
        } else {
                yyerror("array already exists");
        }
}

;

statement: 
	var ASSIGN expression
{
	
}
	| IF bool_exp THEN statements ENDIF
		{}
	| IF bool_exp THEN statements ELSE statements ENDIF
		{}
	| WHILE bool_exp BEGINLOOP statements ENDLOOP
		{}
	| DO BEGINLOOP statements ENDLOOP WHILE bool_exp
		{}
	| READ vars
		{}
	| WRITE vars
		{}
	| CONTINUE
		{}
	| RETURN expression
		{};
	
statements: 
	statement SEMICOLON/* epsilon */
		{}
	| statement SEMICOLON statements
		{};

expression: 
	multiplicative_expression
{}
	| multiplicative_expression ADD expression
{     
}
	| multiplicative_expression SUB expression
{
};

multiplicative_expression: 
	term
	| term MULT multiplicative_expression
		{ 
		}
	| term DIV multiplicative_expression
{ }
	| term MOD multiplicative_expression
		{ }
		;

term: 
	var
{
	string temp = newtemp(); 
	printf(". %")
}
	| SUB var
		{ }
	| NUMBER
		{ }
	| SUB NUMBER
		{ }
	| L_PAREN expression R_PAREN
		{ }
	| SUB L_PAREN expression R_PAREN
		{ }
	| ident L_PAREN expressions R_PAREN
		{ };

expressions: 
	/* epsilon */
		{}
	| comma_sep_expressions
		{};

comma_sep_expressions: 
	expression
		{}
	| expression COMMA comma_sep_expressions
		{};

bool_exp:
	relation_and_exp
		{}
	| relation_and_exp OR bool_exp
		{};

relation_and_exp:
	relation_exp
		{}
	| relation_exp AND relation_and_exp
		{};

relation_exp:
	expression comp expression
		{}
	| NOT expression comp expression
		{}
	| TRUE
		{}
	| NOT TRUE
		{}
	| FALSE
		{}
	| NOT FALSE
		{}
	| L_PAREN bool_exp R_PAREN
		{}
	| NOT L_PAREN bool_exp R_PAREN
		{};

comp:
	EQ
		{}
	| NEQ
		{}
	| LT
		{}
	| GT
		{}
	| LTE
		{}
	| GTE
		{};

var:  ident
{ 
}

	| ident L_SQUARE_BRACKET expression R_SQUARE_BRACKET
		{};
vars:
	var
		{}
	| var COMMA vars
		{};
	

%%

string newtemp(){
	string temp = "_temp" + std::to_string(temp_count) + "_";
	temp_count++;	
	return temp;
}

int main(int argc, char **argv)
{
	yyparse();
   return 0;
}

bool find(vector<symbol> x, symbol y){
	int i = 0;

	while(i<x.size()){ //while i is less than size of vector
		if(x[i].name == y.name){ //if element at index i in vector is equal to symbol we are looking for
		return true;  //found in vector
		}
		else{
		i++;	//keep iterating through vector
		}
	}
	return false; //not found in vector
}

void yyerror(const char *msg)
{
   if(myError == 0)
   {
      printf("** Line %d: %s\n", currLine, msg);
      otherError = 1;
   }
   else
   {
      if(otherError == 1)
      {
         printf("   (%s)\n", msg);
         otherError = 0;
      }
   }
   myError = 0;
}
