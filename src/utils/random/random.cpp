//
// Created by me on 08.10.2021.
//

#include "random.h"
#include <cstdlib>
#include <ctime>

const char* NUMS_AND_CHARS = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789";
const int NUMS_AND_CHARS_LENGTH = 62;

// Возвращает псевдослучайное целое число в интервале
// [from; to) - то есть исключая правую границу
int RandomInt(int from, int to) {
  return rand() % (to - from) + from;
}

char *RandomString(int length) {
  char *random = new char[length];
  for (int i = 0; i < length; i++) {
    random[i] = NUMS_AND_CHARS[RandomInt(0, length)];
  }

  return random;
}

void Randomize() {
  srand(time(nullptr));
}