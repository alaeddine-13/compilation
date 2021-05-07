#include "semantique.h"

TABLE_NOUED table, table_local;

// Variables Globales
NOEUD g_noeud, g_noeudProc;
NOEUD g_ListIdentifiers[100];

TYPE_IDENTIFIANT g_type;
int g_index;
int g_IfProc;
int g_IfProcParameters;
int g_nbParam;

NOEUD creer (const char* nom, TYPE_IDENTIFIANT type, CLASSE classe, NOEUD suivant){
    NOEUD noeud = (NOEUD)malloc(sizeof(struct NOEUD));
    noeud->nom = (char *)malloc(strlen(nom)+1);
    strcpy(noeud->nom, nom);
    noeud->type = type;
    noeud->classe = classe;
    noeud->suivant = suivant;
    return noeud;
}

NOEUD insert (NOEUD noeud, TABLE_NOUED table) {
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

NOEUD chercher (const char* nom, TABLE_NOUED table) {
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


void verifierID (char* nom, int nbline){
    CLASSE classe;

    if (g_IfProc){
        if (g_IfProcParameters){
            classe = parametre;
            g_nbParam ++;
        }else{
            classe = variable;
        }
        if(chercher(nom, table_local) ){
            print_error(concat("Identificateur deja defini: ", nom),nbline);
        }else{
            NOEUD noeud = creer(nom, g_type, classe, NULL);
            table_local = insert(noeud, table_local);
            g_ListIdentifiers[g_index] = noeud;
            g_index++;
        }
    }else{
        if(chercher(nom, table) ){
            print_error(concat("Identificateur deja defini: ", nom),nbline);
        }else{
            NOEUD noeud = creer(nom, g_type, variable, NULL);
            table = insert(noeud, table);
            g_ListIdentifiers[g_index] = noeud;
            g_index++;
        }
    }
}

int verifierIDDeclare (char* nom, int nbline){

    NOEUD noeud;

    if (g_IfProc){
        noeud = chercher(nom, table_local);
        if ( !noeud ){
            noeud = chercher(nom, table);
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
        noeud = chercher(nom, table);
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

void initVar (char* nom){

    NOEUD noeud;

    if (g_IfProc){
        noeud = chercher(nom, table_local);
        if ( !noeud )
            noeud = chercher(nom, table);
    }else{
        noeud = chercher(nom, table);
    }
    noeud->isInit = 1;
}

void verifierVarInitialise (char* nom, int nbline){

    NOEUD noeud;

    if (g_IfProc){
        noeud = chercher(nom, table_local);
        if ( !noeud )
            noeud = chercher(nom, table);
    }else{
        noeud = chercher(nom, table);
    }
    if(noeud && noeud->classe == variable && !noeud->isInit)
        print_error("Variable non initialise",nbline);
}

void finProcedure(int nbline)
{
    NOEUD tmp_table;
    if (g_IfProc == 1){
        g_IfProc = 0;
        tmp_table = table_local;
        table_local = NULL;
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
    if(verifierIDDeclare(nom, nbline)) {
        verifierVarInitialise(nom, nbline);
    }
}


void checkIDOnInit(char* nom, int nbline){
    if(verifierIDDeclare(nom, nbline)) {
        initVar(nom);
    }
}

char* concat(char* s1, char* s2){
    char* message;
    message = malloc(strlen(s1)+ strlen(s2));
    strcpy(message, s1);
    strcat(message, s2);
    return message;
}
