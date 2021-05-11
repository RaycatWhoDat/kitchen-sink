(defstruct random-item nil name order)

(defvar numbers (range 1 5))
(each ((number (take 20 (repeat numbers))))
  (prinl number))

(defvar fruits '("Apple" "Banana" "Cherry" "Date" "Fig"))
(each ((fruit (take 20 (repeat fruits))))
  (prinl fruit))

(each ((item (take 20 (repeat (mapcar
                                (lambda (item) (new random-item name (car item) order (cadr item)))
                                (zip fruits numbers))))))
  (format t "~s: ~s\n" item.name item.order))

