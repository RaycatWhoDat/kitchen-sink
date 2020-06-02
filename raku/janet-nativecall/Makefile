.PHONY: all janet

all: janet

janet:
	gcc -std=c99 -Wall -Werror -O2 -fPIC -shared janet.c -o libjanet.so -lm -ldl -lrt -lpthread
