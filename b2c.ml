(**
 * The main function.
 *)
let () =
  if Array.length Sys.argv < 2
    then print_endline "Please provide a file name as agrument" else
    let input_file = Sys.argv.(1) in
      if not (Sys.file_exists input_file)
        then print_endline "This file does not exist" else
        try
			let lexbuf = Lexing.from_channel (open_in input_file) in
			Parser.main Scanner.main lexbuf
        with
			Error.LuthorError e -> Error.print e
