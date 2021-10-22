#include "documentary.h"
#include "../../utils/io/io.h"
#include "../../utils/random/random.h"
#include <cstdio>

Documentary::Documentary(const char *title, int year, int duration) : Film(title, year), duration(duration) {}

Film *Documentary::In(const char *title, int year, FILE *input) {
  int duration = ReadIntIn(input, 45, 3600,"Incorrect duration: expected an integer in [45, 3600]");
  return new Documentary(title, year, duration);
}

Film *Documentary::InStochastic() {
  return new Documentary(
      RandomString(RandomInt(1, 51)),
      RandomInt(1970, 3022),
      RandomInt(45, 3600));
}

void Documentary::Out(FILE *output) {
  fprintf(output, "Documentary{title=%s,year=%d,duration=%d)", title, year, duration);
}
