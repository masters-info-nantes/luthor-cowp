let my_hash : (string,string) Hashtbl.t = Hashtbl.create 2;;

let add_var a b = Hashtbl.add my_hash a b;;

let print_variable variable =
	let vartype = Hashtbl.find my_hash variable in 
    match vartype with
    | "Integer" -> print_string ("printf(\"%d\\n\" , " ^ variable ^ ")")
    | "String" -> print_string ("printf(\"%s\\n\" , " ^ variable ^ ")")
    | _ -> print_string ("printf(\""^ variable ^ "\")")


let generate_header () =
	print_string "#include <stdio.h>\n";
	print_string "#include <stdlib.h>\n";
	print_string "\n";
	print_string "int main(int argc, char** argv){\n\n"
;;

let generate_footer () = 
	print_string "\n\treturn 0;\n";
	print_string "}\n"
;;