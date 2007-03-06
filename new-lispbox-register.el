
(push (list 
       'clisp-2.35
       (list 
	(lispbox-list-to-filename  (list (file-name-directory load-file-name) "bin" "clisp"))
	"-ansi" "-K" "full" "-B"
	(lispbox-list-to-filename (list (file-name-directory load-file-name) "lib" "clisp"))))
      slime-lisp-implementations)