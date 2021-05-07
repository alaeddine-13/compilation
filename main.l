%{	
 
#include <stdio.h>	
#include <stdlib.h>	          
#include <string.h>
#include <math.h>	
#include "syntaxique.tab.h"	

int nbline = 1 ;
extern char nom[];

%}

%x COMMENT

delim       [ \t]*
chiffre             [0-9]
lettre             [A-Za-z_]
lettre_num         ({lettre}|{chiffre})
id        {lettre}{lettre_num}*
unsigned_integer  {chiffre}+
integer           -*{chiffre}+
exposant          e[+-]?{chiffre}+
i                 {unsigned_integer}
real              ({i}\.{i}?|{i}?\.{i}){exposant}?
string            \'([^'\n]|\'\')+\'
bad_string        \'([^'\n]|\'\')+

ouvrante  (\()
fermante  (\))

%%


begin                return(BBEGIN);
else                 return(ELSE);
mod                  return(MOD);
import               return(IMPORT);
program              return(PROGRAM);
repeat               return(REPEAT);
in                   return(IN);
while                return(WHILE);
then                 return(THEN);
for                  return(FOR);
do                   return(DO);
read				 return(READ);
function             return(FUNCTION);
write				 return(WRITE);
and                  return(AND);
or                  return(OR);
array                return(ARRAY);
end                  return(END);
if                   return(IF);
not                  return(NOT);
procedure            return(PROCEDURE);
until                return(UNTIL);
var                  return(VAR);
of					 return(OF);
integer              return(INTEGER);
real                 return(REAL);
div                  return(DIV);
string               return(STRING);
{ouvrante}           return(OUVRANTE);
{fermante}           return(FERMANTE); 
";"					 return(SEMICOLON);
","					 return(VIRGULE);
"["					 return(BRACKET_OUVRANTE);
"]"					 return(BRACKET_FERMANTE);
":"					 return(COLON);
".."                 return(POINT2);
"."                 return(POINT);
"<="|"=<"            return(LESS_EQUAL);
"=>"|">="            return(GREATER_EQUAL);
"<>"                 return(NOT_EQUAL);
"="                  return(EQUAL);
":="                 return(AFFECTATION);
"+"                  return(PLUS);
"-"                  return(MOINS);
"*"                  return(MULT);
"/"                  return(DIV);


"/*"                BEGIN(COMMENT);
<COMMENT>[^*\n]+
<COMMENT>\n         ++nbline;
<COMMENT><<EOF>>    {
                        yyerror("EOF in comment");
                        yyterminate();
                    }
<COMMENT>"*/"       BEGIN(INITIAL);
<COMMENT>[*/]

[*/+\-^,:.()\[\]]    return(yytext[0]);

{real}               return(LIT_REAL);
{string}             return(LIT_STRING);

{integer}           {
                        yylval = atoi(yytext);
                        return(LIT_INTEGER);
                    }

{id}        {
                        strcpy(nom, yytext);
                        return ID; 
                    }

{bad_string}        { printf("erreur syntaxique ligne %d : Unterminated string\n", nbline); }



{delim}        /* do nothing */
\n                   ++nbline;
.                    { printf("erreur syntaxique ligne %d : Illegal character \'%s\'\n", nbline); }

%%

