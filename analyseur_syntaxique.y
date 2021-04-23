%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// nombre de lignes lus partagé avec l'analyseur lexical
extern int nbline; 


int yyerror(char const * msg);	
int yylex();

%}

%token PROGRAM 
%token POINT_VIRGULE
%token IDENTIFIER
%token AND
%token ARRAY
%token _BEGIN
%token DIV
%token DO
%token ELSE
%token END
%token FOR
%token FUNCTION
%token IF
%token IN
%token MOD
%token NOT
%token PROCEDURE
%token REPEAT
%token THEN
%token TYPE
%token UNTIL
%token VAR
%token WHILE
%token OF
%token READ
%token WRITE
%token INTEGER
%token REAL
%token STRING

%token LEQ
%token GEQ
%token NEQ
%token EQ
%token AFFECT
%token DOUBLEDOT

%token LITERAL_INTEGER
%token LITERAL_REAL
%token LITERAL_STRING

%start programme

%%

programme 				: entete liste_declarations declaration_methodes instruction_composee
						| entete liste_declarations instruction_composee
						| entete instruction_composee 
						| entete 
						;

entete					: PROGRAM IDENTIFIER POINT_VIRGULE
            			| error IDENTIFIER POINT_VIRGULE     {yyerror ("Keyword 'program' is missing"); }
                		| PROGRAM error POINT_VIRGULE        {yyerror ("The program name is invalid"); } 
                		| PROGRAM IDENTIFIER error           {yyerror ("Semicolon expected"); }
                		;

liste_declarations  	: declaration liste_declarations 
						| declaration 
						;
 
declaration 			: VAR declaration_corps POINT_VIRGULE 
						| error declaration_corps POINT_VIRGULE      {yyerror ("Keyword 'var' is missing"); }
						| VAR declaration_corps error				 {yyerror ("Semicolon expected"); }
						;
 
declaration_corps   	: liste_identificateurs ':' type;
 
liste_identificateurs   : IDENTIFIER ',' liste_identificateurs 
						| IDENTIFIER ;
 
type 					: standard_type 
						| ARRAY '[' LITERAL_INTEGER DOUBLEDOT LITERAL_INTEGER ']' OF  standard_type 
						;

standard_type 			: INTEGER
						| error {yyerror("Type not valid");}
						;
 
declaration_methodes 	: declaration_methode POINT_VIRGULE declaration_methodes 
						| declaration_methode POINT_VIRGULE
						;
 
declaration_methode 	: entete_methode liste_declarations instruction_composee 
						| entete_methode instruction_composee 
						;
 
entete_methode 			: PROCEDURE 
						  IDENTIFIER
						  arguments ;
 
arguments 				: '(' liste_parametres  
						  ')' 
						;
 
liste_parametres 		: declaration_corps POINT_VIRGULE liste_parametres 	
						| declaration_corps error liste_parametres   {yyerror ("Semicolon expected"); }
						| declaration_corps 
						;
 
instruction_composee    : _BEGIN liste_instructions END
						| _BEGIN END 
						;
 
liste_instructions 		: instruction POINT_VIRGULE liste_instructions 
						| instruction POINT_VIRGULE 
						| instruction error  {yyerror ("Semicolon expected"); }
						;

instruction  			: lvalue AFFECT expression 
						| appel_methode
						| instruction_composee 
						| IF expression THEN instruction ELSE instruction 
						| WHILE expression DO instruction 
						| WRITE '(' liste_expressions ')'
						| READ '(' liste_identificateurs ')'
						;
 
lvalue 					: IDENTIFIER 
						'[' expression ']' 
						| IDENTIFIER 
						;
 
appel_methode 			: IDENTIFIER 
						  '(' liste_expressions ')' 
						| IDENTIFIER error {yyerror("Missing parentheses");}
						;
 
liste_expressions 		: expression 
						  ',' liste_expressions 
						| expression 
						|
						;
 
expression 				: facteur 
						| facteur addop facteur 
						| facteur mulop facteur
						;
 
mulop 					: '*' 
						| '/' 
						;

addop 					: '+' 
						| '-' 
						;
 
facteur 				: IDENTIFIER 
						| IDENTIFIER 
						  '[' expression ']' 
						| LITERAL_INTEGER 
						| '(' expression ')' 
						;

%% 

int yyerror(char const * msg) 
{
	fprintf(stderr, "Error on line %d : %s\n", nbline, msg);
	return(1);
}

extern FILE *yyin;


main()
{
	yyparse();
}

yywrap()
{
	return(1);
}
  
                   
