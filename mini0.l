%option noyywrap

%{

#define YY_NO_UNISTD_H
#define YY_NO_INPUT
#define YY_NO_OUTPUT

#ifndef fileno
#define fileno(f) _fileno(f)
#endif

#ifndef isatty
#define isatty(fd) 0
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* ==== FUNCIÓN AUXILIAR PARA MOSTRAR TOKENS ==== */
void printToken(const char* tipo, const char* valor, int linea) {
    printf("TOKEN: %-15s  VALOR: %-20s  LINEA: %d\n", tipo, valor, linea);
}
%}

/* ==== DEFINICIÓN DE EXPRESIONES REGULARES ==== */
digit       [0-9]
hexdigit    [0-9a-fA-F]
id          [a-zA-Z_][a-zA-Z0-9_]*
ws          [ \t]+
nl          \n

%%
"if"            { printToken("IF", yytext, yylineno); }
"else"          { printToken("ELSE", yytext, yylineno); }
"while"         { printToken("WHILE", yytext, yylineno); }
"return"        { printToken("RETURN", yytext, yylineno); }
"int"           { printToken("INT", yytext, yylineno); }
"float"         { printToken("FLOAT", yytext, yylineno); }
"string"        { printToken("STRING", yytext, yylineno); }

"=="            { printToken("EQ", yytext, yylineno); }
"!="            { printToken("NEQ", yytext, yylineno); }
"<="            { printToken("LEQ", yytext, yylineno); }
">="            { printToken("GEQ", yytext, yylineno); }
"<"             { printToken("LT", yytext, yylineno); }
">"             { printToken("GT", yytext, yylineno); }

"="             { printToken("ASSIGN", yytext, yylineno); }
";"             { printToken("SEMICOLON", yytext, yylineno); }
","             { printToken("COMMA", yytext, yylineno); }
"("             { printToken("LPAREN", yytext, yylineno); }
")"             { printToken("RPAREN", yytext, yylineno); }
"{"             { printToken("LBRACE", yytext, yylineno); }
"}"             { printToken("RBRACE", yytext, yylineno); }
"+"             { printToken("PLUS", yytext, yylineno); }
"-"             { printToken("MINUS", yytext, yylineno); }
"*"             { printToken("MULT", yytext, yylineno); }
"/"             { printToken("DIV", yytext, yylineno); }

0[xX]{hexdigit}+    { printToken("NUM_HEX", yytext, yylineno); }
{digit}+             { printToken("NUM_INT", yytext, yylineno); }
{digit}+"."{digit}+  { printToken("NUM_FLOAT", yytext, yylineno); }

\"([^\\\"]|\\.)*\"   { printToken("STRING_LITERAL", yytext, yylineno); }

{id}                 { printToken("IDENTIFIER", yytext, yylineno); }

{ws}                 ;
{nl}                 { yylineno++; }

.                    { printToken("ERROR", yytext, yylineno); }

%%


