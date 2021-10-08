#include "documentary.h"
#include "../../utils/io/io.h"

#include "../../utils/random/random.h"
#include <cstdio>

void In(documentary &documentary, FILE *file) {
  documentary.title = ReadString(file);
  documentary.year = ReadInt(file);
  documentary.duration = ReadInt(file);
}

void inStochastic(documentary &documentary) {
  documentary.title = RandomString(RandomInt(1, 51));
  documentary.year = RandomInt(1970, 2022);
  documentary.duration = RandomInt(45, 360);
}

void Out(documentary &documentary, FILE *output) {
  fprintf(output, "Documentary{title=%s,year=%d,duration=%d)", documentary.title, documentary.year, documentary.duration);
}