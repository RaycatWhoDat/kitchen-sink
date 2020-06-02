.PHONY: all janet cpp

all: janet cpp

janet:
	gcc -std=c99 -Wall -Werror -O2 -fPIC -shared janet.c -o libjanet.so -lm -ldl -lrt -lpthread

cpp: janet-testing.cpp
	clang++ -std=c++17 -Wall -Wextra -g -L. -ljanet -fsanitize=address,undefined -o testing janet-testing.cpp
