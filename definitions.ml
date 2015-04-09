let my_hash : (string,string) Hashtbl.t = Hashtbl.create 2;;

let add_var a b = Hashtbl.add my_hash a b

let print_variable variable =
	let vartype = Hashtbl.find my_hash variable in 
    match vartype with
    | "Integer" -> print_string ("printf(\"%d\\n\" , " ^ variable ^ ")")
    | "String" -> print_string ("printf(\"%s\\n\" , " ^ variable ^ ")")
    | _ -> print_string ("printf(\""^ variable ^ "\")")
