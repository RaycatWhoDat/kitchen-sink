-*- compile-command: "./red test.red"; eval: (setq tab-width 2)  -*-

Red [
  title:  "A minimal Red test script"
  author: "Ray Perry"
  needs: view
]

prefix: "Hello,"
message: "world."

hello-world: function [
  "This repeats 'Hello, world.' ITERATIONS times."
  iterations [integer!] "The number of times 'Hello, world.' should be repeated."
][
  iterations: either /default [iterations][5]
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
