%{
	let parse_error s = Error.error "Parsing error" (symbol_start_pos ())
%}

%token <string> IDENTIFIER
%token <string> NUMBER
%token EOL
%token AS
%token TYPE_INTEGER
%token TYPE_STRING
%token <string> STRING
%token PRINT
%token EOF
%token DIM
%token IF
%token END
%token EQUAL
%token GTHAN
%token LTHAN
%token THEN
%token ELSE
%token <char> CHAR
%start main
%type <unit> main
%%

/*
 * A file is a list of characters ending with the end of file token. When
 * the end of the file is reached, we just print a new line.
 */
main:
   expressions EOF {print_newline ()}
;

expressions:
    /* empty */ {}
  | expressions EOL {print_string "\n"}
  | expressions affectations{}
  | expressions print_expr{}
  | expressions condition{}
;

condition:
	| expressions IF predicate THEN{print_string "if(";print_string $3;print_string "){"}
	| expressions END IF{ print_string "}"}
;	| expressions ELSE condition{print_string " else "}

predicate:
	| IDENTIFIER EQUAL NUMBER {$1 ^ " == " ^ $3}
	| IDENTIFIER GTHAN NUMBER {$1 ^ " > " ^ $3}
	| IDENTIFIER LTHAN NUMBER {$1 ^ " < " ^ $3}
	| IDENTIFIER GTHAN EQUAL NUMBER {$1 ^ " >= " ^ $4}
	| IDENTIFIER LTHAN EQUAL NUMBER {$1 ^ " <= " ^ $4}
;

print_expr:
  | expressions PRINT STRING {print_string "printf(" ;print_string $3;print_string ");"}
;

affectations:
	| expressions DIM IDENTIFIER AS TYPE_STRING {print_string "char* ";print_string $3;print_string ";"}
	| expressions DIM IDENTIFIER AS TYPE_INTEGER {print_string "int ";print_string $3;print_string ";"}
;
