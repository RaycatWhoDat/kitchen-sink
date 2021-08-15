#lang racket/base

(for ([item (open-input-file "../d/MOCK_DATA.csv")])
  (display item))
