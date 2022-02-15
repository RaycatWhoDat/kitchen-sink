package main

import "core:fmt"

main :: proc() {
	fmt.printf("Hello, World!\n")

	fmt.printf("Let's test collections.\n")

	test1 := []i32{1, 2, 3, 4, 5}
	test2 := []i32{6, 7, 8, 9, 10}

	for item in test1 { fmt.printf("%d\n", item) }
	for item in test2 { fmt.printf("%d\n", item) }
}
