(defvar all-users (list '("Adam" 'guest) '("Ben" 'customer) '("Charlie" 'admin)))

(defstruct user nil name type)

(each ((user all-users))
  (pprinl (new user name [user 0] type [user 1]).name))
