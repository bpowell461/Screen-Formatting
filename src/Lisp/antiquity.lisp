#!/usr/bin/sbcl --script
(defvar num 60)
(defvar lineIndex 1)
(defvar longLine)
(defvar shortLine)
(defvar tmpList)
(defvar shortList)
(defvar longList)
(defvar longLineNum 1)
(defvar shortLineNum 1)
(defvar filename)

(setq filename (nth 1 sb-ext:*posix-argv*))
(setq longList (make-array 0 :adjustable t :fill-pointer 0))
(setq shortList (make-array 10 :adjustable t :fill-pointer 0))
(setq tmpList (make-array 0 :adjustable t :fill-pointer 0))
(loop for i from 0 to 10
do (vector-push "aa" shortList)
)
(defvar b)
(defun tokenize (string)
  (loop
     for start = 0 then (+ space 1)
     for space = (position #\space string :start start)
     for token = (subseq string start space)
     unless (string= token "") collect token
     until (not space)))

(defparameter *stringList*
   (with-open-file (stream filename :direction :input)
     (loop for line = (read-line stream nil)
           while line
           append (tokenize line))))

(format t "~8,d" lineIndex)
(format t "~d" "  ")
(loop for token in *stringList* do
(setq b (ignore-errors (parse-number token)))
(if (not b)
   (progn
     (if (>  (length token) num)

     ;if
     (progn

     (if (>= (length tmpList) (length longList))
        (progn
        (setq longLineNum lineIndex)
	(setq longList tmpList)
        )
     )
     (if (<= (length tmpList) (length shortList))
        (progn
        (setq shortLineNum lineIndex)
        (setq shortList tmpList)
        )
     )

     (setq tmpList (make-array 0 :adjustable t :fill-pointer 0))
     (terpri)
     (incf lineIndex 1)
     (format t "~8,d" lineIndex)
     (format t "~d" "  ")
     (format t "~d" token)
     (format t "~d" " ")
     (setq num 60)
     (decf num (length token))
     (decf num 1)
     )

     ;else
     (progn
     (format t "~d" token)
     (format t "~d" " ")
     (decf num (length token))
     (decf num 1)

     (vector-push-extend token tmpList)

     )



     )
  )
)
)
(terpri)
(terpri)
(format t "~7a" "LONG")
(format t "~12a" longLineNum)
(format t "~d" longList) 
(terpri)
(format t "~7a" "SHORT")
(format t "~12a" shortLineNum)
(format t "~d" shortList)

(terpri)
