-*- mode: red; compile-command: "./red test-script.red"; eval: (setq tab-width 2)  -*-

Red [
  title:    "A minimal Red test script"
  author:   "Ray Perry"
]

; This is a test comment.

comment {
  This is a test of the dumb version of this mode. This takes
  any word that's in Red and highlights it. It's not the best but at
  least it's something.
}

prefix: "Hello,"
message: "world."

another-test: {
  This is another test.
}

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
