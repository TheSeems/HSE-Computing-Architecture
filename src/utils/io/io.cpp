//
// Created by me on 08.10.2021.
//

#include "io.h"

int ReadInt(FILE *file) {
  int value;
  fscanf(file, "%d", &value);
  return value;
}

char *ReadString(FILE *file) {
  char *result = new char[STRING_MAX_LENGTH];
  fscanf(file, "%s", result);
  return result;
}