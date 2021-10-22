#!/bin/bash

SOLUTION=./../cmake-build-debug/comparch_homework_second
DETERMINISTIC_FOLDER=deterministic
RANDOM_FOLDER=random

for test in 1 2 incorrect_0 incorrect_1 incorrect_2; do
  printf "===========\n"
  printf "DETERMINISTIC %s\n" $test
  printf "===========\n"

  $SOLUTION -f $DETERMINISTIC_FOLDER/$test/input.txt $DETERMINISTIC_FOLDER/$test/output1.txt $DETERMINISTIC_FOLDER/$test/output2.txt
  printf "\n\n"
done
for test in 1 2 3; do
  printf "===========\n"
  printf "RANDOM %s\n" $test
  printf "===========\n"

  sh $RANDOM_FOLDER/$test/run.sh

  printf "\n\n"
done