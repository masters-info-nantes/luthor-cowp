open Parsing
open Error 

(** Error override **)
let parse_error s = Error.error "Parsing error" (symbol_start_pos ())