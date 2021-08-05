(defvar *new-json* #H(()))
(defvar *fixed-fields* '())

(each ((json-entry (file-get-json "./bad-json.json")))
  (when-match (@key . @value) json-entry
    (let ((subkeys (remove-if 'empty (sspl "[]" key))))
      (set *fixed-fields*
        (append *fixed-fields*
          ^(,(reduce-right
               (lambda (subkey1 subkey2)
                 (if (empty subkey2)
                   ^#H(() (,subkey1 ,value))
                   ^#H(() (,subkey1 ,subkey2))))
               subkeys '())))))))

(each ((fixed-field *fixed-fields*))
  (prinl fixed-field)
  (set *new-json* (hash-uni *new-json* fixed-field)))

(pprint (tojson *new-json*))
