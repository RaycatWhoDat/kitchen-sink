;;; -*- lexical-binding: t; -*-
;;; clubhouse.el --- Interact with Clubhouse through its API.

;; Author: Ray Perry
;; URL: https://github.com/RayMPerry/clubhouse.el
;; Created: 8/1/2020
;; Version: 0.1.0

(require 'cl)
(require 'json)
(require 'request)

;;;###autoload
(progn
  (defgroup clubhouse
    nil
    "Clubhouse"
    :group 'external)

  (defcustom clubhouse-api-token
    ""
    "Key used for interacting with the Clubhouse API."
    :group 'clubhouse
    :type 'string))

(defconst clubhouse-base-url
  "https://api.clubhouse.io/api/v3"
  "The base API URL.")

(defconst clubhouse-projects
  '((2 . "API Server") (3 . "Infrastructure") (4 . "Web App"))
  "Alist containing all projects in the form of (project-id . project-name).")

(defconst clubhouse-story-types
  '("feature" "bug" "chore")
  "List containing all possible story types.")

(defun clubhouse-create-story (title description &optional project-id type)
  "Create a new Clubhouse story, provided the API key is set."
  (interactive "sTitle: \nsDescription (C-q C-j to add a new line): ")

  (setq clubhouse-story-title title)
  (setq clubhouse-story-description description)

  (setq clubhouse-story-project-id
    (or
      project-id
      (car (rassoc
             (completing-read
               "Project: "
               (cl-loop
                 for (project-id . project-name) in clubhouse-projects
                 collect project-name))
           clubhouse-projects))))
    
  (setq clubhouse-story-type
    (or
      type
      (completing-read
        "Story Type: "
        clubhouse-story-types)))
    
  (request
    (concat "https://api.clubhouse.io/api/v3" "/stories")
    :type "POST"
    :headers `(("Content-Type" . "application/json")
                ("Clubhouse-Token" . ,clubhouse-api-token))
    :data (json-encode
            `(("description" . ,clubhouse-story-description)
               ("name" . ,clubhouse-story-title)
               ("project_id" . ,clubhouse-story-project-id)
               ("story_type" . ,clubhouse-story-type)))
    :parser 'json-read
    :complete (lambda (&rest _) (message "Ticket created!"))))

;; TODO: Add label and epic support
;; ("labels" (("id" . 273) ("name" . "Needs Grooming")))))
