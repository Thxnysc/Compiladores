#include <iostream>
#include <cstdio>
#include <string>
using namespace std;

extern FILE* yyin;
extern int yylex();

int main(int argc, char* argv[]) {
    if (argc < 2) {
        cerr << "Uso: " << argv[0] << " archivo.m0" << endl;
        return 1;
    }

    FILE* archivo = fopen(argv[1], "r");
    if (!archivo) {
        cerr << "Error: no se pudo abrir el archivo " << argv[1] << endl;
        return 1;
    }

    yyin = archivo;
    yylex();  // Ejecuta el analizador léxico
    fclose(archivo);

    return 0;
}

