%{
  let texte = open_out "compiled.c"
  let () = output_string texte "#include<stdio.h> \n\n"

    (** Overrides the default parse_error function. *)  
    
  let parse_error s = Error.error "Parsing error" (symbol_start_pos ())
%}

%token <string> STRING
%token DIM
%token AS
%token <string> PRIM_TYPE
%token PRINT
%token <string> IDENTIFIER
%token EOF


%start init
%type <unit> init
%type <unit> main
%%



main:
  PRINT STRING {output_string texte "printf(";output_string texte $2;output_string texte ");\n"}
  | PRINT STRING main{output_string texte "printf(";output_string texte $2;output_string texte ");\n"}
  | DIM IDENTIFIER AS PRIM_TYPE{output_string texte $4;output_string texte $2;output_string texte ";\n"}
  | DIM IDENTIFIER AS PRIM_TYPE main{output_string texte $4;output_string texte $2;output_string texte ";\n"}
;

init:
	main{}
;
