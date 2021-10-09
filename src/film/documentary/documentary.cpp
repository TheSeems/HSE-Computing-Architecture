#include "documentary.h"
#include "../../utils/io/io.h"

#include "../../utils/random/random.h"
#include <cstdio>

void In(documentary &documentary, FILE *file) {
  documentary.title = ReadString(file);
  documentary.year = ReadIntIn(file, 1970, 3022, "Incorrect year provided: expected a number between 1970, 3022");
  documentary.duration = ReadIntIn(file, 45, 3600, "Incorrect duration provided: expected a number between 45, 3600");
}

void inStochastic(documentary &documentary) {
  documentary.title = RandomString(RandomInt(1, 51));
  documentary.year = RandomInt(1970, 3022);
  documentary.duration = RandomInt(45, 3600);
}

void Out(documentary &documentary, FILE *output) {
  fprintf(output, "Documentary{title=%s,year=%d,duration=%d)", documentary.title, documentary.year, documentary.duration);
}