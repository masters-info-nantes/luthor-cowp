{
	open Interpret_parser
    open Lexing
    open Error
    
    
  
  (** Increments the lexing buffer line number counter.*)
  let incr_line lexbuf =
    let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <-
      {pos with pos_lnum = pos.pos_lnum + 1; pos_bol = 0}

  (** Increments the lexing buffer line offset by the given length. *)
  let incr_bol lexbuf length =
    let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <- {pos with pos_bol = pos.pos_bol + length}
    
  (** Increments the lexing buffer line offset by the given lexem length. *)
  let incr_bol_lxm lexbuf lxm = incr_bol lexbuf (String.length lxm)
  
  (** Turns a char into a string containing this char. *)
  let string_of_char c = String.make 1 c
 
}

let integer  = ['0'-'9']+
let number   = integer ('.' integer)?
let string = '\"'(_[^'\"'])* '\"'
let identifier = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule token = parse
  
  | "String" {incr_bol lexbuf 6; TYPE_STRING}
  | "Integer" {incr_bol lexbuf 7; TYPE_INTEGER}
  
  | string as i{incr_bol_lxm lexbuf i ; STRING i}
  | identifier as i{incr_bol_lxm lexbuf i ; IDENTIFIER i}
  | integer as i {INTEGER i}
  | number as i {NUMBER i}

  | "PRINT" {incr_bol lexbuf 4; PRINT}
  | "DIM" {incr_bol lexbuf 3; DIM}
  | "AS"	{incr_bol lexbuf 2; AS}
  | "CONST"	{incr_bol lexbuf 5; CONST}
  
  | "If"     { incr_bol lexbuf 2; IF }
  | "Then"   { incr_bol lexbuf 4; THEN }
  | "Else"   { incr_bol lexbuf 4; ELSE }  
  | "End If" { incr_bol lexbuf 6; IFEND }  
  | "For"    { incr_bol lexbuf 3; FOR } 
  | "To"     { incr_bol lexbuf 2; TO } 
  | "Next"   { incr_bol lexbuf 4; NEXT } 
  | "While"  { incr_bol lexbuf 5; WHILE } 
  | "Do"     { incr_bol lexbuf 2; DO } 
  | "Loop"   { incr_bol lexbuf 4; LOOP } 
  
  | "==" { incr_bol lexbuf 1; DEQUAL }
  | "=" { incr_bol lexbuf 1; EQUAL }
  | "<" { incr_bol lexbuf 1; GTHAN }
  | ">" { incr_bol lexbuf 1; LTHAN }
  | "," { incr_bol lexbuf 1; COMMA } 
  | "+" { incr_bol lexbuf 1; PLUS } 
  | "-" { incr_bol lexbuf 1; LESS } 
  | "*" { incr_bol lexbuf 1; TIMES } 
  | "/" { incr_bol lexbuf 1; DIVIDE } 
  
  | '\r' | '\n' | "\r\n" {incr_line lexbuf ; token lexbuf}
  | ' ' | '\t' {incr_bol lexbuf 1 ; token lexbuf}
  
  | eof {EOF}
  | _ as c {Error.warning("Unrecognized character " ^ (string_of_char c)) lexbuf.lex_curr_p;incr_bol lexbuf 1 ;token lexbuf}
  
