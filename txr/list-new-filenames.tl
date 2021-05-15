(each-match (@(as name `@base.txt`) (glob "./fake-files/*.txt")
              @(@num (fmt "~,04a")) 1)
  (pprinl `@base-@num.txt`))

