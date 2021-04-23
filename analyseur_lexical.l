%{	
 
#include <stdio.h>	
#include <stdlib.h>	          
#include <string.h>
#include <math.h>	
#include "analyseur_syntaxique.tab.h"	

int nbline = 1 ;

%}

%x COMMENT

delim       [ \t]*
chiffre             [0-9]
lettre             [A-Za-z_]
lettre_num         ({lettre}|{chiffre})
id        {lettre}{lettre_num}*
unsigned_integer  {chiffre}+
integer           -*{chiffre}+
exponent          e[+-]?{chiffre}+
i                 {unsigned_integer}
real              ({i}\.{i}?|{i}?\.{i}){exponent}?
string            \'([^'\n]|\'\')+\'
bad_string        \'([^'\n]|\'\')+

ouvrante  (\()
fermante  (\))

%%


"/*"                BEGIN(COMMENT);
<COMMENT>[^*\n]+
<COMMENT>\n         ++nbline;
<COMMENT><<EOF>>    {
                        yyerror("EOF in comment");
                        yyterminate();
                    }
<COMMENT>"*/"       BEGIN(INITIAL);
<COMMENT>[*/]

and                  return(AND);
array                return(ARRAY);
begin                return(_BEGIN);
div                  return(DIV);
do                   return(DO);
else                 return(ELSE);
end                  return(END);
for                  return(FOR);
function             return(FUNCTION);
if                   return(IF);
in                   return(IN);
mod                  return(MOD);
not                  return(NOT);
procedure            return(PROCEDURE);
program              return(PROGRAM);
repeat               return(REPEAT);
then                 return(THEN);
until                return(UNTIL);
var                  return(VAR);
while                return(WHILE);
of					 return(OF);
read				 return(READ);
write				 return(WRITE);
integer              return(INTEGER);
real                 return(REAL);
string               return(STRING);
{ouvrante}           return(OUVRANTE);
{fermante}           return(FERMANTE); 
"<="|"=<"            return(LEQ);
"=>"|">="            return(GEQ);
"<>"                 return(NEQ);
"="                  return(EQ);
":="                 return(AFFECT);
";"					 return(POINT_VIRGULE);
","					 return(VIRGULE);
"["					 return(BRACKET_OUVRANTE);
"]"					 return(BRACKET_FERMANTE);
":"					 return(COLON);
".."                 return(DOUBLEDOT);
"+"                  return(PLUS);
"-"                  return(MOINS);
"*"                  return(MULT);
"/"                  return(DIV);

[*/+\-^,:.()\[\]]    return(yytext[0]);

{real}               return(LITERAL_REAL);
{string}             return(LITERAL_STRING);

{integer}           {
                        return(LITERAL_INTEGER);
                    }
{id}        {
                        return IDENTIFIER; 
                    }

{bad_string}        { fprintf(stderr,"Error on line %d : Unterminated string\n", nbline); }



{delim}        /* do nothing */
\n                   ++nbline;
.                    { fprintf(stderr,"Error on line %d : Illegal character \'%s\'\n", nbline); }

%%

