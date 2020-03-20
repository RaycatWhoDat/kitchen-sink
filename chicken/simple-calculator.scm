(import
  (chicken io)
  (chicken string)
  (chicken irregex)
  loop)

(print "Enter a list of numbers separated by spaces:")
(let ((input (read-line (current-input-port))))
  (print
    (loop
      for number in (string-split (irregex-replace/all "[^0-9]" input " ") " ")
      sum (string->number number))))
