%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int nbline; 


int yyerror(char const * msg);	
int yylex();

%}
%token PROGRAM 
%token IMPORT
%token PROCEDURE
%token FUNCTION
%token BBEGIN
%token END
%token DO
%token WHILE
%token FOR
%token REPEAT
%token UNTIL
%token IF
%token THEN
%token ELSE
%token ID
%token SEMICOLON
%token COLON
%token POINT
%token POINT2
%token IN
%token NOT
%token AND
%token OR
%token ARRAY
%token OF
%token VAR
%token TYPE
%token REAL
%token STRING
%token INTEGER
%token READ
%token WRITE
%token MOD

%token LESS_EQUAL
%token GREATER_EQUAL
%token NOT_EQUAL
%token EQUAL
%token AFFECTATION

%token LIT_INTEGER
%token LIT_REAL
%token LIT_STRING

%token PLUS
%token MOINS
%token MULT
%token DIV
%token OUVRANTE
%token FERMANTE
%token BRACKET_FERMANTE
%token BRACKET_OUVRANTE
%token VIRGULE

%start programme

%%

programme 				: entete liste_declarations declaration_methodes instruction_composee
						| entete liste_declarations instruction_composee
						| entete declaration_methodes instruction_composee
						| entete instruction_composee 
						| entete 
						;

entete					: PROGRAM ID SEMICOLON
            			| error ID SEMICOLON     {yyerror ("mot clef 'program' absent"); }
                		| PROGRAM error SEMICOLON        {yyerror ("nom du prog invalide"); } 
                		| PROGRAM ID error           {yyerror ("semicolon expecte"); }
                		;

liste_declarations  	: declaration liste_declarations 
						| declaration
						;
 
declaration 			: VAR declaration_corps SEMICOLON 
						| error declaration_corps SEMICOLON      {yyerror ("mot clef 'var' absent"); }
						| VAR declaration_corps error				 {yyerror ("semicolon expecte"); }
						;
 
declaration_corps   	: liste_identificateurs COLON type;

 
liste_identificateurs   : ID VIRGULE liste_identificateurs 
						| ID ;
 
type 					: standard_type 
						| ARRAY BRACKET_OUVRANTE LIT_INTEGER POINT POINT LIT_INTEGER BRACKET_FERMANTE
						;

standard_type 			: INTEGER
						| REAL
						| STRING
						| error {yyerror("type invalide");}
						;
 
declaration_methodes 	: declaration_methode SEMICOLON declaration_methodes 
						| declaration_methode SEMICOLON
						;
 
declaration_methode 	: entete_methode liste_declarations instruction_composee 
						| entete_methode instruction_composee 
						;
 
entete_methode 			: PROCEDURE 
						  ID
						  arguments
						;
 
arguments 				: OUVRANTE liste_parametres  
						  FERMANTE
						| OUVRANTE FERMANTE
						;
 
liste_parametres 		: declaration_corps SEMICOLON liste_parametres 	
						| declaration_corps 
						| declaration_corps error liste_parametres   {yyerror ("semicolon expecte"); }
						;
 
instruction_composee    : BBEGIN liste_instructions END
						| BBEGIN END 
						;
 
liste_instructions 		: instruction SEMICOLON liste_instructions 
						| instruction SEMICOLON 
						| instruction error  {yyerror ("semicolon expecte"); }
						;

instruction  			: lvalue AFFECTATION expression 
						| appel_methode
						| instruction_composee 
						| IF expression THEN instruction ELSE instruction 
						| WHILE expression DO instruction 
						| WRITE OUVRANTE liste_expressions FERMANTE
						| READ OUVRANTE liste_identificateurs FERMANTE
						;
 
lvalue 					: ID 
						BRACKET_OUVRANTE expression BRACKET_FERMANTE 
						| ID 
						;
 
appel_methode 			: ID 
						  OUVRANTE liste_expressions FERMANTE
						| ID error {yyerror("parenthese absente");}
						;
 
liste_expressions 		: expression 
						  VIRGULE liste_expressions 
						| expression 
						|
						;
 
expression 				: facteur 
						| facteur addop facteur 
						| facteur mulop facteur
						;
 
mulop 					: MULT
						| DIV 
						;

addop 					: PLUS
						| MOINS
						;
 
facteur 				: ID 
						| ID 
						  BRACKET_OUVRANTE expression BRACKET_FERMANTE
						| LIT_INTEGER 
						| OUVRANTE expression FERMANTE
						;

%% 

int yyerror(char const * msg) 
{
	fprintf(stderr, "erreur ligne %d : %s\n", nbline, msg);
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
  
                   
