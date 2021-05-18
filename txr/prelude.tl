(set (symbol-function 'pretty-print) (fun pprint))
(set (symbol-function 'print-line) (fun prinl))
(set (symbol-function 'pretty-print-line) (fun pprinl))
(set (symbol-function 'to-string) (fun tostring))
(set (symbol-function 'to-string-pretty) (fun tostringp))

(print-line "This is a test")
