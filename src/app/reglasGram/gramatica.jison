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
"aA-zZ"                      return 'EXP_REG_ABC';
"0-9"                      return 'EXP_REG_NUM';
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
    var arrayDerivaciones = [];
    var symInicial;
%}

%% /* language grammar */

inicio
    :  WISON inicio_sig EOF 
        {
            var elemento = {'id':'listaErrores','cont':arrayErrores};
            var elemento1 = {'id':'listaTerminales','cont':arrayTerminales};
            var elemento2 = {'id':'listaProducciones','cont':arrayProducciones};
            var elemento3 = {'id':'listaNoTerminales','cont':arrayNoTerminales};
            var elemento4 = {'id':'symInicial','cont':symInicial};
            array.push(elemento);
            array.push(elemento1);
            array.push(elemento2);
            array.push(elemento3);
            array.push(elemento4);
            var arrayAux = array;
            array = []; 
            arrayErrores = [];         
            arrayTerminales = [];
            arrayProducciones = [];
            arrayNoTerminales = [];
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
            var elemento = {'id': $2 ,'cont':$5};
            arrayTerminales.push(elemento);
        }
    |error
        {
            console.log('error ' + yytext);
            arrayErrores.push('error en la linea ' + (this._$.first_line) +
            ', columna ' + (this._$.first_column) + ' -> ' + yytext);
        }
    ;

expresion_lex
    : COMILLA cont_expresion_lex COMILLA
        {
            $$ = $2;
        }
    | cont_expr_regulares
        {
            $$ = $1;
        }
    |error
        {
            console.log('error ' + yytext);
            arrayErrores.push('error en la linea ' + (this._$.first_line) +
            ', columna ' + (this._$.first_column) + ' -> ' + yytext);
        }
    ;

cont_expresion_lex
    : STRING
        {
          $$ = yytext;
        }
    | INVALID
        {
          $$ = '\\' + '\\' + yytext;
        }
    | symb_especiales
        {
           $$ = $1;
        }
    ;

symb_especiales
    : '*'
        {
          $$ = '\\' + '\\' + yytext;
        }
    | '='
        {
            $$ = '\\' + '\\' + yytext;
        }
    | '-'
        {
            $$ = '\\' + '\\'+ yytext;
        }
    | '<'
        {
            $$ = '\\' + '\\'+ yytext;
        }
    | '{'
        {
            $$ = '\\' + '\\'+ yytext;
        }
    | '}'
        {
            $$ = '\\' + '\\'+ yytext;
        }
    | '+'
        {
            $$ = '\\' + '\\'+ yytext;
        }
    | '%'
        {
            $$ = '\\' + '\\'+ yytext;
        }
    | '('
        {
            $$ = '\\' + '\\'+ yytext;
        }
    | ')'
        {
            $$ = '\\' + '\\'+ yytext;
        }
    | '['
        {
            $$ = '\\' + '\\'+ yytext;
        }
    | ']'
        {
             $$ = '\\' + '\\'+ yytext;
        }
    | ';'
        {
            $$ = '\\' + '\\' +yytext;
        }
    | '?'
        {
           $$ = '\\' + '\\'+ yytext;
        }
    | '¿'
        {
            $$ = '\\' + '\\'+ yytext;
        }
    | ':'
        {
            $$ = '\\' + '\\'+ yytext;
        }
    | COMILLA
        {
            $$ = '\\' + '\\'+ yytext;
        }
    | '|'
        {
             $$ = '\\' + '\\' +yytext;
        }
    ;


cont_expr_regulares
    : '[' param_cont_expr_regulares sig_cont_expr_regulares
        {
            $$ = '[' + $2 + $3 ;
        }
    | cont_expr_regulares_combinado
        {
            $$ = $1;
        } 
    ;

cont_expr_regulares_combinado
    : cont_expr_regulares_combinado expr_reg_comb
        {
            $$ = $1 + $2;
        }
    | expr_reg_comb
        {
            $$ = $1;
        }
    ;

expr_reg_comb
    : '(' cont_expr_reg_comb ')'
        {
            $$ = '(' + $2 + ')';
        }
    ;

cont_expr_reg_comb
    : cont_expr_regulares
        {
            $$ = $1;
        }
    | NOMBRE_TERMINAL
        {
            $$ = yytext;
        }
    |error
        {
            console.log('error ' + yytext);
            arrayErrores.push('error en la linea ' + (this._$.first_line) +
            ', columna ' + (this._$.first_column) + ' -> ' + yytext);
        }
    ;

param_cont_expr_regulares
    : EXP_REG_ABC 
        {
            $$ = 'a-zA-Z';
        }
    | EXP_REG_NUM
        {
            $$ = yytext;
        }
    |error
        {
            console.log('error ' + yytext);
            arrayErrores.push('error en la linea ' + (this._$.first_line) +
            ', columna ' + (this._$.first_column) + ' -> ' + yytext);
        }
    ;

sig_cont_expr_regulares
    : ']'
        {
            $$ = yytext;
        }
    | ']' clausula_expr
        {
            $$ = ']' + $2;
        }
    |error
        {
            console.log('error ' + yytext);
            arrayErrores.push('error en la linea ' + (this._$.first_line) +
            ', columna ' + (this._$.first_column) + ' -> ' + yytext);
        }
    ;

clausula_expr
    : '*'
        {
            $$ = yytext;
        }
    | '+'
        {
            $$ = yytext;
        }
    | '?'
        {
            $$ = yytext;
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
    |error
        {
            console.log('error ' + yytext);
            arrayErrores.push('error en la linea ' + (this._$.first_line) +
            ', columna ' + (this._$.first_column) + ' -> ' + yytext);
        }
    ;

no_terminal 
    : NO_TERMINAL NOMBRE_PRODUCCION ';'
        {
            arrayNoTerminales.push($2);
        }
    ;

initial_prod
    : INITIAL_SYM NOMBRE_PRODUCCION ';'
        {
            symInicial = $2;
        }
    |error
        {
            console.log('error ' + yytext);
            arrayErrores.push('error en la linea ' + (this._$.first_line) +
            ', columna ' + (this._$.first_column) + ' -> ' + yytext);
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
    : NOMBRE_PRODUCCION '<' '=' derivaciones ';'
        {
            var produccion = $4;
            var elemento = {'id': $1, 'cont': arrayDerivaciones };
            arrayProducciones.push(elemento);
            arrayDerivaciones = [];
        }
    |error
        {
            console.log('error ' + yytext);
            arrayErrores.push('error en la linea ' + (this._$.first_line) +
            ', columna ' + (this._$.first_column) + ' -> ' + yytext);
        }
    ;

derivaciones
    : derivaciones derivacion
        {
            $$ = $1 + $2
        }
    |derivacion
        {
            $$ = $1;
        }
    |error
        {
            console.log('error ' + yytext);
            arrayErrores.push('error en la linea ' + (this._$.first_line) +
            ', columna ' + (this._$.first_column) + ' -> ' + yytext);
        }
    ;

derivacion
    : NOMBRE_PRODUCCION
        {
            arrayDerivaciones.push(yytext);
            $$ = yytext;
        }
    | NOMBRE_TERMINAL
        {
            arrayDerivaciones.push(yytext);
            $$ = yytext;
        }
    | '|'
        {
            arrayDerivaciones.push(yytext);
            $$ = yytext;

        }
    ;
    