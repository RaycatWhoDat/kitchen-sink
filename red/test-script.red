-*- compile-command: "./red test.red"; eval: (setq tab-width 2)  -*-

Red [
  title:    "A minimal Red test script"
  author:   "Ray Perry"
  needs:    view
]

; This is a test comment.

prefix: "Hello,"
message: "world."

another-test: {This is another test.}

hello-world: function [
  "This repeats 'Hello, world.' ITERATIONS times."
  iterations [integer!] "The number of times 'Hello, world.' should be repeated."
][
  iterations: either [iterations][5]
  while [iterations > 0][
    print [prefix message]
    iterations: iterations - 1
  ]
]

call/console "ls"

view [
  below
  base
  button
  field
]