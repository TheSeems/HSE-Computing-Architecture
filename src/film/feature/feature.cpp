#include "feature.h"
#include "../../utils/io/io.h"
#include "../../utils/random/random.h"
#include <cstdio>

Film *Feature::In(const char *title, int year, FILE *input) {
  return new Feature(title, year, ReadString(input));
}

Film *Feature::InStochastic() {
  return new Feature(
      RandomString(RandomInt(1, 51)),
      RandomInt(1970, 3022),
      RandomString(RandomInt(1, 51)));
}

Feature::Feature(const char *title, int year, const char *director) : Film(title, year), director(director) {}

void Feature::Out(FILE *output) {
  fprintf(output, "Feature{title=%s,year=%d,director=%s}", title, year, director);
}
