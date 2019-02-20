;; Title: TODO Reporter
;; Author: RaycatWhoDat
;; Version: 0.1.0

(setq todo-list '())
(setq todo-buffer-name "*TODOs*")
(setq todo-decoration-categories '("Path:"))
(setq todo-content-categories '("Task:" "Context:"))
(setq todo-patterns '("DEV:" "TODO:"))
(setq todo-extensions-to-check '(".ts"))
(setq todo-theme '((header-color . '(:foreground "RoyalBlue" :weight bold))
                     (text-color . '(:foreground "DimGray"))))

;; Concat the two lists. [DEV]
(define-derived-mode todo-report-mode special-mode "TODOs"
  "TODO Reporter major mode."
  (font-lock-add-keywords 'todo-report-mode `((,(regexp-opt todo-decoration-categories) . font-lock-keyword-face)
                                (,(concat (regexp-opt todo-content-categories) "\\(.*\\)") 1 'font-lock-comment-face))))

(defun find-todos (directory)
  "Search for TODOs. Returns a list of TODOs found in DIRECTORY."
  (if (or (string= directory nil) (string= directory "")) (return))
  (message "Looking for TODOs...")
  (let* ((todo-list '())
         (todo-patterns (concat (regexp-opt todo-patterns) "\\(.*\\)"))
         (todo-extensions-to-check (regexp-opt todo-extensions-to-check))
         (files-to-check (directory-files-recursively directory todo-extensions-to-check)))
    (loop for file in files-to-check do
          (let ((current-file (with-temp-buffer
                                (insert-file-contents file nil)
                                (split-string (buffer-string) "\n" t))))
            (loop for line in current-file do
                  (if (string-match todo-patterns line)
                      (setq todo-list (append todo-list `(((filename . ,file) (todo . ,(string-trim line))))))))))
    (if (<= (length todo-list) 0)
        (message "No TODOs found.")
      (message "Found %s TODOs." (length todo-list))
      todo-list)))

(defun report-todos (todolist)
  "Reports all items in TODO-LIST in a separate window."
  (if (get-buffer todo-buffer-name) (kill-buffer todo-buffer-name))
  (switch-to-buffer-other-window todo-buffer-name)
  (erase-buffer)
  
  (loop for todo in todolist do
        (let ((file-name (cdr (assoc 'filename todo)))
              (todo-text (cdr (assoc 'todo todo)))
              (todo-patterns (concat (regexp-opt todo-patterns) "\\(.*\\)"))
              (todo-extensions-to-check (string-join todo-extensions-to-check "\\|")))
          (insert (format "Path: %s\nTask: %s\n\n"
                          (if (string-match (concat "^.*\/\\(.*\\(" todo-extensions-to-check "\\)\\)$") file-name) (match-string 1 file-name) file-name)
                          (string-trim (if (string-match todo-patterns todo-text) (match-string 1 todo-text) todo-text))))))
  
  (with-current-buffer todo-buffer-name
    (todo-report-mode)))

(report-todos (find-todos "~/Desktop/Work/oranj-angular-core-universal/src"))
