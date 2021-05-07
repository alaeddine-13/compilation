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

NOEUD creer (const char* nom, TYPE_IDENTIFIANT type, CLASSE classe, NOEUD suivant);
NOEUD insert (NOEUD noeud, TABLE_NOUED table);
NOEUD chercher (const char* nom, TABLE_NOUED table);

void verifierID(char* nom, int nbline);
int verifierIDDeclare(char* nom, int nbline);
void initVar (char* nom);
void verifierVarInitialise(char * nom, int nbline);
void finProcedure(int nbline);
void destructSymbolsTable( TABLE_NOUED SymbolsTable );
int print_error(char* msg, int nbline);
void checkID(char* nom, int nbline);
void checkIDOnInit(char* nom, int nbline);
char* concat(char* s1, char* s2);



