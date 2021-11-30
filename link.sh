#!/bin/sh
# Во избежание возможного кеширования
rm -r build/

mkdir build
./nasm -f elf64 src/main.asm -o build/solution.o
ld ./build/solution.o -o ./build/solution
