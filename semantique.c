#include "semantique.h"

TABLE_NOUED table, tableLocale;

// Variables Globales
NOEUD g_noeud, g_noeudProc;
NOEUD g_ListIdentifiers[100];

TYPE_IDENTIFIANT g_type;
int g_index;
int g_IfProc;
int g_IfProcParameters;
int g_nbParam;

NOEUD creerNoeud (const char* nom, TYPE_IDENTIFIANT type, CLASSE classe, NOEUD suivant){
    NOEUD noeud = (NOEUD)malloc(sizeof(struct NOEUD));
    noeud->nom = (char *)malloc(strlen(nom)+1);
    strcpy(noeud->nom, nom);
    noeud->type = type;
    noeud->classe = classe;
    noeud->suivant = suivant;
    return noeud;
}

NOEUD insererNoeud (NOEUD noeud, TABLE_NOUED table) {
    if( !table ) {
        return noeud;
    }
    else {
        NOEUD last = table;
        while( last->suivant ) {
            last = last->suivant;
        }
        last->suivant = noeud;
        return table;
    }
}

NOEUD chercherNoeud (const char* nom, TABLE_NOUED table) {
    if( !table )
        return NULL;
    NOEUD noeud = table;
    while( noeud && ( strcmp(nom, noeud->nom) != 0 ) )
        noeud = noeud->suivant;
    return noeud;
}

void destructSymbolsTable( TABLE_NOUED table )
{
    if( !table )
        return;
    NOEUD noeud = table;
    while( noeud )
    {
        free(noeud->nom);
        free(noeud);
        noeud = noeud->suivant;
    }
}


void DisplaySymbolsTable( TABLE_NOUED SymbolsTable ){
    if( !SymbolsTable )
        return;
    NOEUD Node = SymbolsTable;
    while( Node )
    {
        switch( Node->type )
        {
            case tInt :
                printf("int ");
                break;

            case NODE_TYPE_UNKNOWN :
                switch (Node->classe)
                {
                    case procedure:
                        printf("procedure ");
                        break;

                    default:
                        break;
                }

            default :
                printf("Unknown ");
        }

        switch (Node->classe)
        {
            case variable:
                printf("variable ");
                break;

            case parametre:
                printf("parametre ");
                break;

            default:
                break;
        }

        printf(" nom var %s", Node->nom);
        printf("\n");

        Node = Node->suivant;
    }
}


void checkIdentifier (char* nom, int nbline){
    CLASSE classe;

    if (g_IfProc){
        if (g_IfProcParameters){
            classe = parametre;
            g_nbParam ++;
        }else{
            classe = variable;
        }
        if( chercherNoeud(nom, tableLocale) ){
            print_error(concat("Identificateur deja defini: ", nom),nbline);
        }else{
            NOEUD noeud = creerNoeud(nom, g_type, classe ,NULL);
            tableLocale = insererNoeud(noeud, tableLocale);
            g_ListIdentifiers[g_index] = noeud;
            g_index++;
        }
    }else{
        if( chercherNoeud(nom, table) ){
            print_error(concat("Identificateur deja defini: ", nom),nbline);
        }else{
            NOEUD noeud = creerNoeud(nom, g_type, variable ,NULL);
            table = insererNoeud(noeud, table);
            g_ListIdentifiers[g_index] = noeud;
            g_index++;
        }
    }
}

int checkIdentifierDeclared (char* nom, int nbline){

    NOEUD noeud;

    if (g_IfProc){
        noeud = chercherNoeud(nom,tableLocale);
        if ( !noeud ){
            noeud = chercherNoeud(nom,table);
            if( !noeud ){
                print_error(concat("variable non declare: ", nom),nbline);
                return 0;
            }else
            {
                noeud->isUsed = 1;
            }
        }else
        {
            noeud->isUsed = 1;
        }
    }else{
        noeud = chercherNoeud(nom,table);
        if( !noeud ){
            print_error(concat("variable non declare: ", nom),nbline);
            return 0;
        }else
        {
            noeud->isUsed = 1;
        }
    }
    return 1;
}

void varInitialized (char* nom){

    NOEUD noeud;

    if (g_IfProc){
        noeud = chercherNoeud(nom,tableLocale);
        if ( !noeud )
            noeud = chercherNoeud(nom,table);
    }else{
        noeud = chercherNoeud(nom,table);
    }
    noeud->isInit = 1;
}

void checkVarInit (char* nom,int nbline){

    NOEUD noeud;

    if (g_IfProc){
        noeud = chercherNoeud(nom,tableLocale);
        if ( !noeud )
            noeud = chercherNoeud(nom,table);
    }else{
        noeud = chercherNoeud(nom,table);
    }
    if(noeud && noeud->classe == variable && !noeud->isInit)
        print_error("Variable not initialized",nbline);
}

void endProc(int nbline)
{
    NOEUD tmp_table;
    printf("g_ifproc: %d", g_IfProc);
    if (g_IfProc == 1){
        // printf("*** Table Locale ***\n");
        // DisplaySymbolsTable( tableLocale );
        g_IfProc = 0;
        tmp_table = tableLocale;
        tableLocale = NULL;
    }else{
        // printf("*** Table Globale ***\n");
        // DisplaySymbolsTable( table );
        tmp_table = table;
    }
    while( tmp_table ){
        if (tmp_table->classe == variable && !tmp_table->isUsed)
        {
            char* message;
            const char* msg = "Variable declared not used: ";
            message = malloc(strlen(msg)+ strlen(tmp_table->nom));
            strcpy(message, msg);
            strcat(message, tmp_table->nom);
            print_error(message,nbline);
        }

        tmp_table = tmp_table->suivant;
    }
}

int print_error(char * msg, int nbline)
{
    printf("erreur semantique ligne %d : %s\n", nbline, msg);
    return(1);
}


void checkID(char* nom, int nbline){
    if(checkIdentifierDeclared(nom, nbline)) {
        checkVarInit(nom, nbline);
    }
}


void checkIDOnInit(char* nom, int nbline){
    if(checkIdentifierDeclared(nom,nbline)) {
        varInitialized (nom);
    }
}

char* concat(char* s1, char* s2){
    char* message;
    message = malloc(strlen(s1)+ strlen(s2));
    strcpy(message, s1);
    strcat(message, s2);
    return message;
}
