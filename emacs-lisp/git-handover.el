;; Name: git-handover.el
;; Author: Ray Perry
;; Version: 0.0.5

;; Changelog
;; ---------
;; 0.0.1
;; Initial version with set commit messages.
;;
;; 0.0.2
;; Allow for different commit messages.
;;
;; 0.0.3
;; Add support for Pivotal Tracker Ticker Numbers.
;;
;; 0.0.4
;; Extract commands to the top level for better testing.
;;
;; 0.0.5
;; Add optional completion message to commands.
;;

(defvar *version-control-program* "git" "The command that points towards a VCS.")
(defvar *branch-name* nil "The current mob session branch name.")
(defvar *ticket-number* nil "The current ticket being worked on this mob session.")

(setq start-commands
  '("fetch origin master"
     "checkout master"
     "merge origin/master --ff-only"
     (concat "checkout -b " *branch-name*)
     (concat "push --set-upstream origin " *branch-name* " --no-verify")))

(setq pass-commands
  '("fetch origin master"
     "add ."
     (concat "commit -m '" (git-handover--set-commit-message) "' --allow-empty")
     (concat "push origin " *branch-name* " --no-verify")
     "checkout master"
     (concat "branch -D " *branch-name*)))

(setq receive-commands
  '((concat *version-control-program* " fetch origin " *branch-name*)
     (concat *version-control-program* " checkout --track origin/" *branch-name*)))

(setq finish-commands
  '("add ."
     (concat "commit -m '" (git-handover--set-commit-message) "' --allow-empty")
     "fetch origin master"
     "checkout master"
     "merge origin/master --ff-only"
     (concat "merge --squash --ff " *branch-name*)
     (concat "branch -D " *branch-name*)
     (concat "push origin --delete " *branch-name* " --no-verify")))

(defun in-mob-session-p ()
  "Returns t if we're in a mob session."
  (not (null *branch-name*)))

(defun git-handover--set-commit-message (&optional commit-message)
  "Returns DESCRIPTION for use in `git-handover` commands."
  (if commit-message
    (concat "Team [#" *ticket-number* "] " commit-message)
    (read-string "Commit message: " (concat "Team [#" *ticket-number* "] "))))

(defun git-handover--set-ticket-number (&optional ticket-number)
  "Sets *TICKET-NUMBER* to TICKET-NUMBER."
  (interactive "sTicket number: ")
  (setq *ticket-number* ticket-number)
  (message (format "Current ticket number set to: %s" *ticket-number*)))

(defun run-git-handover-commands (commands-to-run &optional completion-message)
  "Runs all commands in COMMANDS-TO-RUN via `shell-command'. If
present, COMPLETION-MESSAGE will be displayed when all commands
have been attempted."
  (dolist (command commands-to-run)
    (shell-command (concat *version-control-program* " " (eval command))))
  (when completion-message (message completion-message)))

(defun git-handover-status ()
  "Returns the status of the current mob session."
  (interactive)
  (message
    (if (in-mob-session-p)
      (format "Currently in mob session: %s" *branch-name*)
      (format "Not in a mob session."))))

(defun git-handover-set-branch (branch-name)
  "This sets *BRANCH-NAME* to BRANCH-NAME."
  (interactive "sBranch name: ")
  (setq *branch-name* branch-name)
  (message (format "Current mob session set to: %s" *branch-name*)))

(defun git-handover-set-directory (directory)
  "This will set the directory path to operate on."
  (interactive "DDirectory to start with: ")
  (setq default-directory (expand-file-name directory))
  (message (format "Current working directory: %s" default-directory)))

(defun git-handover-cancel ()
  "This will cancel the current mob session."
  (interactive)
  (when (in-mob-session-p)
    (message (format "%s" (concat "Session " *branch-name* " finished.")))
    (setq *branch-name* nil)
    (setq *ticket-number* nil)))

(defun git-handover-start ()
  "This will start a new mob session using BRANCH-NAME as the
newly-created branch name."
  (interactive)
  (unless (in-mob-session-p)
    (call-interactively 'git-handover-set-directory)
    (call-interactively 'git-handover-set-branch)
    (git-handover--set-ticket-number))
  (run-git-handover-commands
    start-commands
    (format "%s" (concat "Session " *branch-name* " started."))))

(defun git-handover-pass ()
  "This will pass the branch to the next typist in the mob
session."
  (interactive)
  (when (in-mob-session-p)
    (run-git-handover-commands
      pass-commands
      (format "%s" (concat "Session " *branch-name* " passed.")))))

(defun git-handover-receive ()
  "This will pull the branch and update the local copy."
  (interactive)
  ;; Let's just delete the branch anyway.
  (when (length (shell-command-to-string (concat "git show-ref --quiet refs/heads/" *branch-name*)))
    (shell-command (concat "git branch -D " *branch-name*)))
  
  (run-git-handover-commands
    receive-commands
    (format "%s" (concat "Session " *branch-name* " received."))))

(defun git-handover-finish ()
  "This will finish the mob session."
  (interactive)
  (when (in-mob-session-p)
    (run-git-handover-commands finish-commands)
    (git-handover-cancel)))

