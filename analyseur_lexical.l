%{	
 
#include <stdio.h>	
#include <stdlib.h>	          
#include <string.h>
#include <math.h>	
#include "analyseur_syntaxique.tab.h"	

int nbline = 1 ;
extern char nom[];

%}

%x COMMENT

white_space       [ \t]*
digit             [0-9]
alpha             [A-Za-z_]
alpha_num         ({alpha}|{digit})
hex_digit         [0-9A-F]
identifier        {alpha}{alpha_num}*
unsigned_integer  {digit}+
integer           -*{digit}+
exponent          e[+-]?{digit}+
i                 {unsigned_integer}
real              ({i}\.{i}?|{i}?\.{i}){exponent}?
string            \'([^'\n]|\'\')+\'
bad_string        \'([^'\n]|\'\')+

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

"<="|"=<"            return(LEQ);
"=>"|">="            return(GEQ);
"<>"                 return(NEQ);
"="                  return(EQ);
":="                 return(AFFECT);
";"					 return(POINT_VIRGULE);
".."                 return(DOUBLEDOT);

{real}               return(LITERAL_REAL);
{string}             return(LITERAL_STRING);

{integer}           {   yylval = atoi(yytext); 
                        return(LITERAL_INTEGER);
                    }
{identifier}        {   strcpy(nom, yytext); 
                        return IDENTIFIER; 
                    }

{bad_string}        { fprintf(stderr,"Error on line %d : Unterminated string\n", nbline); }

[*/+\-^,:.()\[\]]    return(yytext[0]);

{white_space}        /* do nothing */
\n                   ++nbline;
.                    { fprintf(stderr,"Error on line %d : Illegal character \'%s\'\n", nbline); }

%%

