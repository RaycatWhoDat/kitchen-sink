(defmacro assert (test-form &optional message)
  "Assert that TEST-FORM evaluates to t."
  `(when (not ,test-form)
     (error ,(if message
               (concat message ": %s")
               "Assertion failed: %s")
       (format "%s" ',test-form))))

(defun calculate-tip ()
  "Prompts for BILL-AMOUNT and TIP-PERCENTAGE. Returns the amount of
the tip and the new total."
  (interactive)
  (let* ((bill-amount (* (read-number "Bill amount: " 0) 100))
          (tip-percentage (float (read-number "Tip percentage (0 - 100%): " 0)))
          (tip-amount (* bill-amount (/ tip-percentage 100)))
          (total-amount (+ bill-amount tip-amount)))

    (assert (and (>= tip-percentage 0) (<= tip-percentage 100))
      "This function requires TIP-PERCENTAGE to be a number between 0 and 100")

    (message "Your tip amount is $%2.2f. Your new total is $%2.2f."
      (/ tip-amount 100)
      (/ total-amount 100))))

(calculate-tip)
