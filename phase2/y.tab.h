/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    L_PAREN = 258,
    R_PAREN = 259,
    ADD = 260,
    SUB = 261,
    MULT = 262,
    DIV = 263,
    EQ = 264,
    NUMBER = 265,
    IDENT = 266,
    FUNCTION = 267,
    BEGIN_PARAMS = 268,
    END_PARAMS = 269,
    BEGIN_LOCALS = 270,
    END_LOCALS = 271,
    BEGIN_BODY = 272,
    END_BODY = 273,
    ARRAY = 274,
    OF = 275,
    IF = 276,
    THEN = 277,
    ENDIF = 278,
    ELSE = 279,
    WHILE = 280,
    DO = 281,
    BEGINLOOP = 282,
    ENDLOOP = 283,
    CONTINUE = 284,
    READ = 285,
    WRITE = 286,
    AND = 287,
    OR = 288,
    NOT = 289,
    TRUE = 290,
    FALSE = 291,
    RETURN = 292,
    MOD = 293,
    NEQ = 294,
    LT = 295,
    GT = 296,
    LTE = 297,
    GTE = 298,
    INTEGER = 299,
    SEMICOLON = 300,
    COLON = 301,
    COMMA = 302,
    L_SQUARE_BRACKET = 303,
    R_SQUARE_BRACKET = 304,
    ASSIGN = 305
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 15 "mini_l.y" /* yacc.c:1909  */

 int num;
 char* ident;

#line 110 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
