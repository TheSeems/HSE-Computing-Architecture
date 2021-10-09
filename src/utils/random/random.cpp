//
// Created by me on 08.10.2021.
//

#include "random.h"
#include <cstdlib>
#include <ctime>

// Возвращает псевдослучайное целое число в интервале
// [from; to) - то есть исключая правую границу
int RandomInt(int from, int to) {
  return rand() % (to - from) + from;
}

char *RandomString(int length) {
  char *random = new char[length];
  for (int i = 0; i < length; i++) {
    random[i] = NUMS_AND_CHARS[RandomInt(0, NUMS_AND_CHARS_LENGTH)];
  }

  return random;
}

void Randomize() {
  srand(time(nullptr));
}