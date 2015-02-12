%{
  let texte = open_out "compiled.c"
  let () = output_string texte "#include<stdio.h> \n\n"
%}

%token <string> STRING
%token PRINT
%token EOF


%start init
%type <unit> init
%type <unit> main
%%



main:
  PRINT STRING {output_string texte "printf(";output_string texte $2;output_string texte ");\n"}
  | PRINT STRING main{output_string texte "printf(";output_string texte $2;output_string texte ");\n"}
;

init:
	main{}
;
