%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}



%token FOR IF ELSE WHILE DO SWITCH CASE BREAK DEFAULT PRINTF
%token MAS MENOS MULTIPLICACION DIVISION MODULO
%token IGUAL MASIGUAL MENOSIGUAL MULTIPLICACIONIGUAL DIVISIONIGUAL MODULOIGUAL
%token DECREMENTO INCREMENTO
%token IGUALIGUAL DIFERENTE MAYOR MENOR MAYORIGUAL MENORIGUAL 
%token AND OR NOT
%token INT FLOAT CHAR DOUBLE VOID SHORT LONG SIGNED UNSIGNED
%token PUNTOCOMA COMA PUNTO DOSPUNTOS
%token LLAVEABRIR LLAVECERRAR CORCHETEABRIR CORCHETECERRAR PARENTESISABRIR PARENTESISCERRAR
%token COMILLAS COMILLASIMPLE
%token NUMEROS VARIABLES CADENA




%%




programa:
    /* Regla inicial */
    | programa sentencia
    ;

sentencia:
    if_statement
    |for_statement
    |while_statement
    |do_while_statement
    |switch_statement
    |impresion          
    |asigancionVariable
    |operacion
    ;

if_statement:
    IF PARENTESISABRIR condicion PARENTESISCERRAR LLAVEABRIR contenido LLAVECERRAR 
    {
        printf("Sentencia if encontrada y correcta");
    }
    ;
for_statement:
    FOR PARENTESISABRIR inicializacion PUNTOCOMA condicion PUNTOCOMA incremento PARENTESISCERRAR LLAVEABRIR contenido LLAVECERRAR
    {
        printf("Sentencia for encontrada y correcta");
    }
    ;
while_statement:
    WHILE PARENTESISABRIR condicion PARENTESISCERRAR LLAVEABRIR contenido LLAVECERRAR
    {
        printf("Sentencia while encontrada y correcta");
    }
    ;


do_while_statement:
    DO LLAVEABRIR contenido LLAVECERRAR WHILE PARENTESISABRIR condicion PARENTESISCERRAR PUNTOCOMA
    {
        printf("Sentencia do while encontrada y correcta");
    }
    ;
switch_statement:
    SWITCH PARENTESISABRIR VARIABLES PARENTESISCERRAR LLAVEABRIR case_clauses default_clause_opt LLAVECERRAR
    {
        printf("Sentencia switch encontrada y correcta");
    }
    ;

case_clauses:
    case_clause
    | case_clauses case_clause
    ;

case_clause:
    CASE NUMEROS DOSPUNTOS contenido BREAK PUNTOCOMA
    ;

default_clause_opt:
    /* vacío */
    | DEFAULT DOSPUNTOS contenido BREAK PUNTOCOMA
    ;

inicializacion:
    tipoDeDato VARIABLES IGUAL opcion
    ;
tipoDeDato:
    INT
    |FLOAT
    |CHAR
    |DOUBLE
    |VOID
    |SHORT
    |LONG
    |SIGNED
    |UNSIGNED
    ;
condicion:
    opcion operadorRelacional opcion
    | opcion operadorLogico opcion
    | NOT condicion
    | PARENTESISABRIR condicion PARENTESISCERRAR
    ;
operadorLogico:
    AND
    | OR
    ;

operadorRelacional:
    IGUALIGUAL
    |DIFERENTE
    |MAYOR
    |MENOR
    |MAYORIGUAL
    |MENORIGUAL
    ;

operadorAsignacion:
    IGUAL
    |MASIGUAL
    |MENOSIGUAL
    |MULTIPLICACIONIGUAL
    |DIVISIONIGUAL
    |MODULOIGUAL
    ;
incremento:
    VARIABLES INCREMENTO
    |VARIABLES DECREMENTO
    ;
contenido:
    /* vacío */           /* Añadido para permitir vacío */
    | contenido sentencia /* Permitir múltiples sentencias */
    ;
impresion:
    PRINTF PARENTESISABRIR CADENA PARENTESISCERRAR PUNTOCOMA
    ;
asigancionVariable:
    tipoDeDato VARIABLES IGUAL opcion PUNTOCOMA
    |tipoDeDato VARIABLES IGUAL CADENA PUNTOCOMA
    ;
operacion:
    VARIABLES IGUAL opcion operador opcion PUNTOCOMA
    ;
opcion:
    NUMEROS
    | VARIABLES
    | opcion operador opcion
    | PARENTESISABRIR opcion PARENTESISCERRAR
    ;
operador:
    MAS
    |MENOS
    |MULTIPLICACION
    |DIVISION
    |MODULO
    ;
%%


void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    return yyparse();
}
