#!/bin/sh

cat <<EOF
(require 'cl)

(defun lispbox-list-to-filename (list)
  (apply 
   #'concat 
   (maplist
    #'(lambda (cons)
        (if (cdr cons) (file-name-as-directory (car cons)) (car cons)))
    list)))

(defun lispbox-file (rest)
  (concat 
   (file-name-as-directory
    (expand-file-name
     (or (getenv "LISPBOX_HOME")
         (file-name-directory load-file-name))))
   rest))

(defun lispbox-find-lisps ()
  (dolist (file (file-expand-wildcards (lispbox-file "*/lispbox-register.el")))
    (load file)))

(defun lispbox-install-lisp-license (license-path lisp-name)
  (let ((license (concat (file-name-directory load-file-name) (lispbox-list-to-filename license-path))))
    (if (not (file-exists-p license))
      (let* ((prompt (format "Need to install license for %s . Please enter name of file where you saved it: " lisp-name))
             (to-install (read-file-name prompt)))
        (copy-file (expand-file-name to-install) license)))))

(global-font-lock-mode t)

(setq load-path (cons (lispbox-file "${SLIME_DIR}") load-path))
EOF

if [ ! -z "${SBCL_DIR}" ]; then
    cat <<EOF
(setenv "SBCL_HOME" (lispbox-file "${SBCL_DIR}/lib/sbcl"))
EOF
fi

if [ ! -z "${OPENMCL_DIR}" ]; then
    cat <<EOF
(setenv "CCL_DEFAULT_DIRECTORY" (lispbox-file "${OPENMCL_DIR}"))
EOF
fi

cat <<EOF
(require 'slime)
(slime-setup)
(lispbox-find-lisps)

(provide 'lispbox)
EOF
