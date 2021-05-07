%{

#include "semantique.c"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// nombre de lignes lus partagé avec l'analyseur lexical
extern int nbline;
// chaine de caractères partagée avec l’analyseur lexical
char nom[256];


int yyerror(char const * msg);
int yylex();
void Begin();
void End();

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

declaration_corps   	: liste_identificateurs ':' type{
							while( g_index > 0 ) {
								g_index-- ;
								g_ListIdentifiers[g_index]->type = g_type;
							}
							g_index = 0 ;
						}
						;

liste_identificateurs   : IDENTIFIER {
							checkIdentifier(nom,nbline);
						} ',' liste_identificateurs
						| IDENTIFIER {
							checkIdentifier(nom,nbline);
						}
						;

type 					: standard_type
						| ARRAY '[' LITERAL_INTEGER DOUBLEDOT LITERAL_INTEGER ']' OF  standard_type
						;

standard_type 			: INTEGER
						{ g_type = tInt; }
						| error {yyerror("Type not valid");}
						;

declaration_methodes 	: declaration_methode POINT_VIRGULE declaration_methodes
						| declaration_methode POINT_VIRGULE
						;

declaration_methode 	: entete_methode liste_declarations instruction_composee
						| entete_methode instruction_composee
						;

entete_methode 			: PROCEDURE { g_IfProc = 1; }
						  IDENTIFIER
						{
							if( chercherNoeud(nom, table) ){
								yyerror("Procedure already defined");
							}else{
								g_noeudProc = creerNoeud(nom, NODE_TYPE_UNKNOWN, procedure, NULL);
								table = insererNoeud(g_noeudProc, table);
							}
							g_IfProcParameters = 1;
			            }
						  arguments
						{
						    g_noeudProc->nbParam = g_nbParam;
							g_nbParam = 0;
						}
						;

arguments 				: '(' liste_parametres
						{
							 g_IfProcParameters = 0;
						}
						  ')'
						;

liste_parametres 		: declaration_corps POINT_VIRGULE liste_parametres
						| declaration_corps error liste_parametres   {yyerror ("Semicolon expected"); }
						| declaration_corps
						;

instruction_composee    : _BEGIN liste_instructions END {endProc(nbline);}
						| _BEGIN END {endProc(nbline);}
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
						| WRITE '(' liste_expressions ')' {
							g_nbParam = 0;
						}
						| READ '(' liste_identificateurs ')' {
							g_nbParam = 0;
						}
						;

lvalue 					: IDENTIFIER
						{
							if(checkIdentifierDeclared(nom,nbline)) {
								varInitialized (nom);
							}
						}
						'[' expression ']'
						| IDENTIFIER
						{
							if(checkIdentifierDeclared(nom,nbline)) {
								varInitialized (nom);
							}
						}
						;

appel_methode 			: IDENTIFIER
						{
							g_noeud = chercherNoeud(nom,table);
						}
						  '(' liste_expressions ')'
						{
							if ( g_noeud->nbParam != g_nbParam)
								yyerror("invalid number of parameters ");
							g_nbParam = 0;
						}
						| IDENTIFIER error {yyerror("Missing parentheses");}
						;

liste_expressions 		: expression
						{
							g_nbParam ++;
						}
						  ',' liste_expressions
						| expression
						{
							g_nbParam ++;
						}
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
						{
							if(checkIdentifierDeclared(nom,nbline)) {
								checkVarInit(nom, nbline);
							}
						}
						| IDENTIFIER
						{
							if(checkIdentifierDeclared(nom,nbline)) {
								checkVarInit(nom, nbline);
							}
						}
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

void Begin()
{
	//initialisations
	table = NULL;
	table_local = NULL;

	g_type = NODE_TYPE_UNKNOWN;

	g_index = 0;
	g_nbParam = 0;

	g_IfProc = 0 ;
    g_IfProcParameters = 0 ;
}

void End()
{
	destructSymbolsTable(table);
}


main()
{
	Begin();
	yyparse();
	End();
}

yywrap()
{
	return(1);
}


