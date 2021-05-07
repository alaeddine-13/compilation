/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_SYNTAXIQUE_TAB_H_INCLUDED
# define YY_YY_SYNTAXIQUE_TAB_H_INCLUDED
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
    PROGRAM = 258,
    IMPORT = 259,
    PROCEDURE = 260,
    FUNCTION = 261,
    BBEGIN = 262,
    END = 263,
    DO = 264,
    WHILE = 265,
    FOR = 266,
    REPEAT = 267,
    UNTIL = 268,
    IF = 269,
    THEN = 270,
    ELSE = 271,
    ID = 272,
    SEMICOLON = 273,
    COLON = 274,
    POINT = 275,
    POINT2 = 276,
    IN = 277,
    NOT = 278,
    AND = 279,
    OR = 280,
    ARRAY = 281,
    OF = 282,
    VAR = 283,
    TYPE = 284,
    REAL = 285,
    STRING = 286,
    INTEGER = 287,
    READ = 288,
    WRITE = 289,
    MOD = 290,
    LESS_EQUAL = 291,
    GREATER_EQUAL = 292,
    NOT_EQUAL = 293,
    EQUAL = 294,
    AFFECTATION = 295,
    LIT_INTEGER = 296,
    LIT_REAL = 297,
    LIT_STRING = 298,
    PLUS = 299,
    MOINS = 300,
    MULT = 301,
    DIV = 302,
    OUVRANTE = 303,
    FERMANTE = 304,
    BRACKET_FERMANTE = 305,
    BRACKET_OUVRANTE = 306,
    VIRGULE = 307
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_SYNTAXIQUE_TAB_H_INCLUDED  */
