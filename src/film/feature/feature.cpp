#include "feature.h"
#include "../../utils/io/io.h"

#include "../../utils/random/random.h"
#include <cstdio>

void In(feature &feature, FILE *file) {
  feature.title = ReadString(file);
  feature.year = ReadIntIn(file, 1970, 3022, "Incorrect year provided: expected a number between 1970, 3022");
  feature.director = ReadString(file);
}

void inStochastic(feature &feature) {
  feature.title = RandomString(RandomInt(1, 51));
  feature.year = RandomInt(1970, 3022);
  feature.director = RandomString(RandomInt(1, 51));
}

void Out(feature &feature, FILE *output) {
  fprintf(output, "Feature{title=%s,year=%d,director=%s}", feature.title, feature.year, feature.director);
}