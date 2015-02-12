{
	open Interpret_parser
}

let type  	= "int"|"double"|"String"
let privacy = "private"|"public"|"protected"
let integer  = ['0'-'9']+
let number   = integer ('.' integer)?
let string = '\"'_*'\"'
let identifier = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule token = parse
  | "/*" {comment lexbuf}
  (* | "//"[^'\n']*'\n' {SINGLE_COM}
  | integer as i {INTEGER i}
  | number {NUMBER}
  | type {PRIM_TYPE}
  | privacy {PRIVACY} *)
  | "PRINT" {PRINT}
  | string as i{STRING i}
  (* | identifier as i{IDENTIFIER i}
  | '(' {BEGIN_PAR}
  | ')' {END_PAR}
  | '{' {BEGIN_CURL}
  | '}' {END_CURL}
  | ';' {SEMICOLON}
  | '+' {PLUS}
  | '-' {MINUS}
  | '*' {MUL}
  | '/' {DIV}
  | '^' {POW}
  | '=' {EQUAL}
  | "class" {CLASS} *)

  | eof {EOF}
  | _  {token lexbuf}
  
and comment = parse
  | "*/" {token lexbuf}
  | _    {comment lexbuf}
  | eof  {EOF}
