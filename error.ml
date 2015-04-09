open Lexing

type luthor_exception = string * Lexing.position

exception LuthorError of luthor_exception

let error message pos = raise (LuthorError (message, pos))

let print (m,p) =
  Printf.eprintf "Error line %d character %d: %s\n" p.pos_lnum (p.pos_bol + 1) m