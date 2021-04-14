/* description: Parses end executes mathematical expressions. */

/* lexical grammar */
%lex

%%
"Terminal"              return 'TERMINAL';
"Wison"              return 'WISON';
"Lex"              return 'LEX';
"Syntax"              return 'SYNTAX';
"No_Terminal"              return 'NO_TERMINAL';
"Initial_Sim"              return 'INITIAL_SYM';
\s+                   /* skip whitespace */
"#"[^\n]*             /*NO hacer nada*/
"/**"([^*]+|\*+[^/*]+)*"*"+"/"  /*No hacer Nada*/
"$_"("_"+|[a-zA-Z]+|[0-9]+)* return 'NOMBRE_TERMINAL';
"%_"("_"+|[a-zA-Z]+|[0-9]+)* return 'NOMBRE_PRODUCCION';
[0-9]+                return 'ENTERO';
[a-zA-Z]+             return 'STRING';
"*"                   return '*';
"="                   return '=';
"-"                   return '-';
"<"                   return '<';
"{"                   return '{';
"}"                   return '}';
"+"                   return '+';
"%"                   return '%';
"("                   return '(';
")"                   return ')';
"["                   return '[';
"]"                   return ']';
";"                   return ';';
"?"                   return '?';
"¿"                   return '¿';
":"                   return ':';
("'"|"`"|"‘"|"’")     return 'COMILLA';
"|"                   return '|';
<<EOF>>               return 'EOF';
.                     return 'INVALID';

/lex

/* operator associations and precedence */

/*
%left '+' '-'
%left '*' '/'
%left '^'
%left UMINUS
 */

%start inicio

%{
	/*Codigo Javascript Incrustado*/
    var array = []; 
    var arrayErrores = [];
    var arrayTerminales = [];
    var arrayProducciones = [];
    var arrayNoTerminales = [];
    var symInicial;
%}

%% /* language grammar */

inicio
    :  WISON inicio_sig EOF 
        {
            var elemento = {'id':'listaErrores','cont':arrayErrores};
            array.push(elemento);
            var arrayAux = array;
            array = []; 
            arrayErrores = [];             
            return arrayAux;
        }    
    ;

inicio_sig
    : '¿'  contenido '?' WISON
        {

        }
    |error
        {
            console.log('error ' + yytext);
            arrayErrores.push('error en la linea ' + (this._$.first_line) +
            ', columna ' + (this._$.first_column) + ' -> ' + yytext);
        }
    ;

contenido
    : lex syn 
        {

        }
    ; 

lex
    :LEX '{' ':' cont_lex ':' '}'
        {
            $$ = $4;
        }
    |error
        {
            console.log('error ' + yytext);
            arrayErrores.push('error en la linea ' + (this._$.first_line) +
            ', columna ' + (this._$.first_column) + ' -> ' + yytext);
        }
    ;

cont_lex
    : cont_lex only_terminal
        {
             /*$$ = Number(yytext); */

        }
    |only_terminal
        {

        }
    ;

only_terminal
    : TERMINAL NOMBRE_TERMINAL '<' '-' expresion_lex ';'
        {

        }
    ;

expresion_lex
    : COMILLA cont_expresion_lex COMILLA
        {

        }
    | cont_expr_regulares
        {

        }
    ;

cont_expresion_lex
    : STRING
        {
          
        }
    | INVALID
        {
          
        }
    | symb_especiales
        {
           
        }
    ;

symb_especiales
    : '*'
        {
          
        }
    | '='
        {
            
        }
    | '-'
        {
            
        }
    | '<'
        {
            
        }
    | '{'
        {
            
        }
    | '}'
        {
            
        }
    | '+'
        {
            
        }
    | '%'
        {
            
        }
    | '('
        {
            
        }
    | ')'
        {
            
        }
    | '['
        {
            
        }
    | ']'
        {
             
        }
    | ';'
        {
            
        }
    | '?'
        {
           
        }
    | '¿'
        {
            
        }
    | ':'
        {
            
        }
    | COMILLA
        {
            
        }
    | '|'
        {
             
        }
    ;


cont_expr_regulares
    : '[' param_cont_expr_regulares sig_cont_expr_regulares
        {

        }
    | cont_expr_regulares_combinado
        {

        } 
    ;

cont_expr_regulares_combinado
    : cont_expr_regulares_combinado expr_reg_comb
        {

        }
    | expr_reg_comb
        {

        }
    ;

expr_reg_comb
    : '(' cont_expr_reg_comb ')'
        {

        }
    ;

cont_expr_reg_comb
    : cont_expr_regulares
        {

        }
    | NOMBRE_TERMINAL
        {

        }
    ;

param_cont_expr_regulares
    : STRING '-' STRING
        {

        }
    | ENTERO '-' ENTERO
        {

        }
    ;

sig_cont_expr_regulares
    : ']'
        {

        }
    | ']' clausula_expr
        {

        }
    ;

clausula_expr
    : '*'
        {

        }
    | '+'
        {

        }
    | '?'
        {

        }
    ;

syn 
    : SYNTAX '{' '{' ':' cont_syn ':' '}' '}'
        {
            $$ = $5;
        }
    |error
        {
            console.log('error ' + yytext);
            arrayErrores.push('error en la linea ' + (this._$.first_line) +
            ', columna ' + (this._$.first_column) + ' -> ' + yytext);
        }
    ;

cont_syn
    :  no_terminales initial_prod producciones
        {
           
        }
    ;

no_terminales
    : no_terminales no_terminal
        {

        }
    | no_terminal
        {

        }
    ;

no_terminal 
    : NO_TERMINAL NOMBRE_PRODUCCION ';'
        {

        }
    ;

initial_prod
    : INITIAL_SYM NOMBRE_PRODUCCION ';'
        {

        }
    ;

producciones
    : producciones produccion
        {

        }
    | produccion
        {

        }
    ;
produccion
    : NOMBRE_PRODUCCION '<' '=' cont_derivaciones ';'
        {

        }
    ;

cont_derivaciones
    : cont_derivaciones '|' derivaciones
        {

        }
    | derivaciones
        {
            
        }
    ;


derivaciones
    : derivaciones derivacion
        {

        }
    |derivacion
        {

        }
    ;

derivacion
    : NOMBRE_PRODUCCION
        {

        }
    | NOMBRE_TERMINAL
        {

        }
    ;
    