(defpackage #:multiplication-docs/index
  (:use #:cl)
  (:import-from #:40ants-doc
                #:defsection-copy
                #:section
                #:defsection)
  (:import-from #:docs-config
                #:docs-config)
  (:export #:@index
           #:@readme))
(in-package #:multiplication-docs/index)


(defsection @index (:title "Multiplication Game!")
  "
Helps your child learn the multiplication table and improve their math skills.

<img src=\"/static/demo.gif\" width=\"70%\"/>

In a playful way, it helps to learn the multiplication table.

Main Features:

- shows hints to make learning easier;
- goes from simple examples to complex ones;
- shows seals!
")


(defsection-copy @readme @index)


(defmethod docs-config ((system (eql (asdf:find-system "multiplication-docs"))))
  ;; 40ANTS-DOC-THEME-40ANTS system will bring
  ;; as dependency a full 40ANTS-DOC but we don't want
  ;; unnecessary dependencies here:
  (uiop:symbol-call :ql :quickload :40ants-doc-theme-40ants)
  (list :theme
        (find-symbol "40ANTS-THEME"
                     (find-package "40ANTS-DOC-THEME-40ANTS"))))



(defmethod docs-builder/builder:build :around ((builder t) (system (eql (asdf:registered-system "multiplication-docs")))
                                               &rest rest
                                               &key local root-sections)
  (declare (ignore rest local root-sections))
  (let* ((target-dir (call-next-method))
         (static-dir (namestring
                      (merge-pathnames (make-pathname :directory '(:relative "static"))
                                       target-dir))))

    (uiop:run-program (format nil "rm -fr ~A"
                              static-dir))
    ;; We keep static in the root folder to make images accessable
    ;; from the README
    (uiop:run-program (format nil "cp -R static ~A"
                              static-dir))))
