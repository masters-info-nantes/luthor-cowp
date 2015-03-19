open Lexing

type syntax_exception = string * Lexing.position

exception SyntaxError of syntax_exception

let error message pos = raise (SyntaxError (message, pos))

let print (m,p) =
  Printf.eprintf "Error line %d character %d: %s \n" p.pos_lnum (p.pos_bol + 1) m

let warning message pos = print (message, pos)
