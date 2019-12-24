;; ("01010101" "11010010" "10101010")

(defmacro assert (test-form &optional message)
  "Assert that TEST-FORM evaluates to t."
  `(when (not ,test-form)
     (error ,(if message
               (concat message ": %s")
               "Assertion failed: %s")
       (format "%s" ',test-form))))

(defun convert-to-bools (sequences)
  "Given SEQUENCES is a list of eight-character strings, it
  returns a list of lists containing t or nil for each 1 and 0
  respectively."

  (dolist (sequence sequences)
    (assert (= (length sequence) 8)
      "All sequences must be eight characters in length"))

  (loop for character across (apply #'concat sequences)
    collect (if (char-equal character 49) t nil) into chunk
    when (= (length chunk) 8)
    collect chunk and do (setq chunk nil)))

(defun calculate-tip ()
  "Prompts for BILL-AMOUNT and TIP-PERCENTAGE. Returns the amount of
the tip and the new total."
  (interactive)
  (let* ((bill-amount (read-number "Bill amount: " 0))
          (tip-percentage (float (read-number "Tip percentage (0 - 100%): " 0)))
          (tip-amount (* bill-amount (/ tip-percentage 100)))
          (total-amount (+ bill-amount tip-amount)))

    (when (not (and (>= tip-percentage 0) (<= tip-percentage 100)))
      (error "This function requires TIP-PERCENTAGE to be a number between 0 and 100"))

    (message "Your tip amount is $%2.2f. Your new total is $%2.2f." tip-amount total-amount)))

(convert-to-bools '("01010101" "11010010" "10101010" "1"))

(calculate-tip)
