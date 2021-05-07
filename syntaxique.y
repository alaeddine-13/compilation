%{

#include "semantique.c"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int nbline; 
char nom[256];

int yyerror(char const * msg);	
int yylex();
void Begin();
void End();

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
 
declaration_corps   	: liste_identificateurs COLON type{
                            while( g_index > 0 ) {
                                g_index-- ;
                                g_ListIdentifiers[g_index]->type = g_type;
                            }
                            g_index = 0 ;
                        }
                        ;

 
liste_identificateurs   : ID {
                            checkIdentifier(nom,nbline);
                        } VIRGULE liste_identificateurs
						| ID {
                            checkIdentifier(nom,nbline);
                        };
 
type 					: standard_type 
						| ARRAY BRACKET_OUVRANTE LIT_INTEGER POINT POINT LIT_INTEGER BRACKET_FERMANTE OF standard_type
						| ARRAY BRACKET_OUVRANTE LIT_INTEGER POINT POINT LIT_INTEGER BRACKET_FERMANTE OF error {yyerror("missing type");}
						;

standard_type 			: INTEGER
                        { g_type = tInt; }
						| REAL
						{ g_type = tReal; }
						| STRING
						{ g_type = tString; }
						| error {yyerror("type invalide");}
						;
 
declaration_methodes 	: declaration_methode SEMICOLON declaration_methodes 
						| declaration_methode SEMICOLON
						;
 
declaration_methode 	: entete_methode liste_declarations instruction_composee 
						| entete_methode instruction_composee 
						;
 
entete_methode 			: PROCEDURE { g_IfProc = 1; }
						  ID
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
						SEMICOLON
						| PROCEDURE ID
						 {
                            if( chercherNoeud(nom, table) ){
                                yyerror("Procedure already defined");
                            }else{
                                g_noeudProc = creerNoeud(nom, NODE_TYPE_UNKNOWN, procedure, NULL);
                                table = insererNoeud(g_noeudProc, table);
                            }
                            g_IfProcParameters = 1;
                        }
                        SEMICOLON
						| PROCEDURE error arguments SEMICOLON {yyerror("missing identifier");}
						| PROCEDURE ID error {yyerror("missing semicolon");}
						| PROCEDURE ID error SEMICOLON {yyerror("wrong arguments");}
						;
 
arguments 				: OUVRANTE liste_parametres
						{
							 g_IfProcParameters = 0;
						}
						  FERMANTE
						| OUVRANTE FERMANTE
						;
 
liste_parametres 		: declaration_corps SEMICOLON liste_parametres 	
						| declaration_corps 
						| declaration_corps error liste_parametres   {yyerror ("semicolon expecte"); }
						;
 
instruction_composee    : BBEGIN liste_instructions END {endProc(nbline);}
						| BBEGIN END {endProc(nbline);}
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
						| WRITE OUVRANTE liste_expressions FERMANTE {
                            g_nbParam = 0;
                        }
						| READ OUVRANTE liste_identificateurs FERMANTE {
                            g_nbParam = 0;
                        }
						;
 
lvalue 					: ID
						{
						    checkIDOnInit(nom, nbline);
						}
						BRACKET_OUVRANTE expression BRACKET_FERMANTE 
						| ID
						{
						    checkIDOnInit(nom, nbline);
						}
						;
 
appel_methode 			: ID
						{
							g_noeud = chercherNoeud(nom,table);
						}
						  OUVRANTE liste_expressions FERMANTE
						{
							if ( g_noeud->nbParam != g_nbParam)
								yyerror("invalid number of parameters ");
							g_nbParam = 0;
						}
						| ID error {yyerror("parenthese absente");}
						;
 
liste_expressions 		: expression
						{
							g_nbParam ++;
						}
						  VIRGULE liste_expressions
						| expression
						{
							g_nbParam ++;
						}
						|
						;
 
expression 				: facteur 
						| facteur addop facteur 
						| facteur mulop facteur
						| facteur error facteur {yyerror("op absent");}
						;
 
mulop 					: MULT
						| DIV 
						;

addop 					: PLUS
						| MOINS
						;
 
facteur 				: ID
						{
						    checkID(nom, nbline);
						}
						| ID
						{
						    checkID(nom, nbline);
						}
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

void Begin()
{
	//initialisations
	table = NULL;
	tableLocale = NULL;

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
  
                   
