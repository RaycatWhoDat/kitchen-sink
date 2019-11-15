;; -*- coding: utf-8; lexical-binding: t -*-

;; Yahtzee Scoring

(defun score-matches (dice)
  "Returns (NAME SCORE) based on the matching subset of rules."
  (let ((results (make-hash-table :test 'eql :size 6)))

    (dolist (die dice)
      (when (null (gethash die results))
        (puthash die 0 results))
      (puthash die (1+ (gethash die results)) results))
    
    (let ((pairs '())
           (trips '())
           (quads '()))
      (dotimes (index 6)
        (let* ((die (1+ index))
                (occurrences (gethash die results 0)))
          (pcase occurrences
            ('2 (setq pairs (nconc pairs (list die))))
            ('3 (setq trips (nconc trips (list die))))
            ('4 (setq quads (nconc quads (list die)))))))
      
      (cond
        ((= (length (remove-duplicates dice)) 1)
          (values "Yahtzee" 50))
        ((and (= (length trips) 1) (= (length pairs) 1))
          (values "Full House" (reduce '+ dice)))
        ((= (length quads) 1)
          (values "Four of a Kind" (* (car quads) 4)))
        ((= (length trips) 1)
          (values "Three of a Kind" (* (car trips) 3)))
        ((= (length pairs) 2)
          (values "Two Pair" (reduce '(lambda (die1 die2) (+ (* die1 2) (* die2 2))) pairs)))
        ((= (length pairs) 1)
          (values "One Pair" (* 2 (car pairs))))))))

(defun score-uniques (dice)
  "Returns (NAME SCORE) based on the non-matching subset of rules."
  (pcase (sort dice '<)
    ('(1 2 3 4 5) (values "Small Straight" 15))
    ('(2 3 4 5 6) (values "Large Straight" 20))
    (chance (values "Chance" (reduce '+ chance)))))

(defun score-dice (dice)
  "Returns (NAME SCORE) based on DICE, a list of 5 numbers between 1 and 6."
  (assert (listp dice) t
    "DICE needs to be a list.")
  (assert (= (length dice) 5) t
    "DICE needs to contain exactly 5 numbers.")
  (assert (every '(lambda (item) (and (>= item 1) (<= item 6))) dice) t
    "All numbers in DICE need to be between 1 and 6, inclusive.")

  (if (equal dice (remove-duplicates dice))
    (score-uniques dice)
    (score-matches dice)))



