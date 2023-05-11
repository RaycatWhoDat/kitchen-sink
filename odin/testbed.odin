package main

import "core:fmt"

UserType :: enum {Guest, Customer, Admin}

User :: struct {
  name: string,
  type: UserType
}

main :: proc () {
  all_users := [?]User {
    {"Adam", UserType.Guest},
    {"Ben", UserType.Customer},
    {"Charlie", UserType.Admin}
  }

  for user in all_users {
    fmt.println(user)
  }
}
