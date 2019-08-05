#!/usr/bin/env txr

(each ((line (file-get-lines "MOCK_DATA.csv")))
      (prinl line))
