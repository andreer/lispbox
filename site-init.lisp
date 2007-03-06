(in-package :cl-user)

#+allegro
(progn
  (setf excl::*redefinition-pathname-comparison-hook*
        (list #'(lambda (old new obj type)
                  (declare (ignore obj type))
                  (when (and old new)
                    (string= 
                     (namestring old) 
                     (let ((str (namestring new)))
                       (subseq str 0 (position #\; str :from-end t))))))))
  (tpl:setq-default *debugger-hook* #'swank:swank-debugger-hook)
  (tpl:setq-default *print-length* 10)
  (tpl:setq-default *print-level*  5)
  (tpl:setq-default *print-circle* nil))

(setq *debugger-hook* #'swank:swank-debugger-hook)
(setf  *print-length* 10)
(setf  *print-level*  5)
(setf *print-circle* nil)

(setf swank::*swank-pprint-case* :downcase)
(setf swank::*swank-pprint-length* nil)
(setf swank::*swank-pprint-level* nil)
(setf swank::*swank-pprint-circle* nil)

(defun lispbox-file (relative-pathname)
  (merge-pathnames 
   relative-pathname
   (make-pathname
    :directory (butlast (pathname-directory *load-pathname*))
    :name nil
    :type nil
    :defaults *load-pathname*)))

#-asdf
(progn
  (multiple-value-bind (value error)
      (ignore-errors (require :asdf))
    (if error
      (load (lispbox-file (make-pathname :name "asdf" :type "lisp"))))))

(load (lispbox-file (make-pathname :name "asdf-extensions" :type "lisp")))

;;; Clean up CL-USER package
(loop with cl = (find-package :cl)
   for p in (package-use-list :cl-user) 
   unless (eql p cl) do (unuse-package p :cl-user))
(use-package :asdf :cl-user)
(use-package :com.gigamonkeys.asdf-extensions :cl-user)

(register-source-directory (lispbox-file (make-pathname :directory '(:relative "practicals-1.0"))))

