;; Name: javascript-extras.el
;; Author: Ray Perry
;; Version: 0.0.1

(defun create-new-test (description)
   "This will create a new JavaScript test with DESCRIPTION."
   (interactive "sDescription: ")
   (insert (concat "test(\"" description "\", async () => {});") "\n"))
