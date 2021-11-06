#!/bin/bash

cd ../
export PYTHONPATH=$PYTHONPATH:`pwd`
SOLUTION="./src/main.py"
DETERMINISTIC_FOLDER=deterministic
RANDOM_FOLDER=random

for test in 1 2 incorrect_0 incorrect_1 incorrect_2; do
  printf "===========\n"
  printf "DETERMINISTIC %s\n" $test
  printf "===========\n"

  $SOLUTION -f test/$DETERMINISTIC_FOLDER/$test/input.txt output/$DETERMINISTIC_FOLDER/$test/output1.txt output/$DETERMINISTIC_FOLDER/$test/output2.txt
  printf "\n\n"
done
for test in 1 2 3; do
  printf "===========\n"
  printf "RANDOM %s\n" $test
  printf "===========\n"

  sh test/$RANDOM_FOLDER/$test/run.sh

  printf "\n\n"
done