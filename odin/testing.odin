package main

import "core:fmt"

Handler :: proc (a, b: int)

Object :: struct {
  handler: Maybe(Handler)
}

main :: proc () {
  o := Object {
    proc (item1, item2: int) {
      fmt.println(item1 + item2)
    }
  }

  o.handler.(Handler)(1,2)
}

