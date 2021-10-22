//
// Created by me on 08.10.2021.
//

#include <cstring>
#include <cstdlib>
#include "io.h"
#include "../../film/film.h"

int ReadIntIn(FILE *file, int from, int to, const char* error) {
  int value;
  fscanf(file, "%d", &value);

  if (value < from || value > to) {
    printf("%s", error);
    exit(1);
  }

  return value;
}

char *ReadString(FILE *file) {
  char *result = new char[STRING_MAX_LENGTH];
  fscanf(file, "%s", result);

  if (strlen(result) == 0) {
    printf("Incorrect title given: expected non-empty string");
    exit(1);
  }

  return result;
}