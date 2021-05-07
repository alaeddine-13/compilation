#include "stdio.h"
#include <stdlib.h>
#include <string.h>

typedef enum {
    NODE_TYPE_UNKNOWN,
    tInt,
    tReal,
    tString
} TYPE_IDENTIFIANT;

typedef enum {
    CLASSE_UNKNOWN,
    variable,
    procedure,
    parametre
} CLASSE;

struct NOEUD
{
    char* nom;
    TYPE_IDENTIFIANT type;
    CLASSE classe;
    int isInit;
    int isUsed;
    int nbParam;

    struct NOEUD * suivant;
};
typedef struct NOEUD * NOEUD;
typedef NOEUD TABLE_NOUED;

NOEUD creerNoeud (const char* nom, TYPE_IDENTIFIANT type, CLASSE classe, NOEUD suivant);
NOEUD insererNoeud (NOEUD noeud, TABLE_NOUED table);
NOEUD chercherNoeud (const char* nom, TABLE_NOUED table);

void checkIdentifier(char* nom, int nbline);
int checkIdentifierDeclared(char* nom, int nbline);
void varInitialized (char* nom);
void checkVarInit(char * nom, int nbline);
void endProc(int nbline);
void destructSymbolsTable( TABLE_NOUED SymbolsTable );
int print_error(char* msg, int nbline);
void checkID(char* nom, int nbline);
void checkIDOnInit(char* nom, int nbline);
char* concat(char* s1, char* s2);



