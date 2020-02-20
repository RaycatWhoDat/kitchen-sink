(defun capitalize-first-last (input)
    "Given INPUT is a space-delimited string, capitalize the first and last letter of each word."
    (loop 
        for letter across input
		for index from 0
		collect (if (or (zerop index) 
			            (= (1+ index) (length input))
                        (char= (char input (1- index)) #\Space)
                        (char= (char input (1+ index)) #\Space))
                    (string-upcase letter)
                    (string-downcase letter)) into result
		finally (return (format nil "~{~A~^~}" result))))

(print (capitalize-first-last "whatever you want"))