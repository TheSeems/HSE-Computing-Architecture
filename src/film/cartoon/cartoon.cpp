#include "cartoon.h"

#include "../../utils/io/io.h"
#include "../../utils/random/random.h"
#include <cstdio>
#include <cstdlib>
#include <cstring>


char *Map(enum Cartoon::type type) {
  char *result = nullptr;
  if (type == Cartoon::DRAWING) {
    result = "DRAWING";
  } else if (type == Cartoon::PUPPET) {
    result = "PUPPET";
  } else if (type == Cartoon::PLASTICINE) {
    result = "PLASTICINE";
  }

  return result;
}

enum Cartoon::type Map(char *type) {
  if (strcmp(type, "DRAWING") == 0) {
    return Cartoon::DRAWING;
  } else if (strcmp(type, "PUPPET") == 0) {
    return Cartoon::PUPPET;
  } else if (strcmp(type, "PLASTICINE") == 0) {
    return Cartoon::PLASTICINE;
  } else {
    printf("Incorrect type of Cartoon film given: %s", type);
    exit(1);
  }
}

enum Cartoon::type Map(int typeNumber) {
  if (typeNumber == 1) {
    return Cartoon::DRAWING;
  } else if (typeNumber == 2) {
    return Cartoon::PUPPET;
  } else if (typeNumber == 3) {
    return Cartoon::PLASTICINE;
  } else {
    printf("Incorrect type number of Cartoon film generated by random: %d", typeNumber);
    exit(2);
  }
}


Film *Cartoon::InStochastic() {
  return new Cartoon(
      RandomString(RandomInt(1, 51)),
      RandomInt(1970, 3022),
      Map(RandomInt(1, 4)));
}

Film *Cartoon::In(const char *title, int year, FILE *input) {
  return new Cartoon(title, year, Map(ReadString(input)));
}

void Cartoon::Out(FILE *output) {
  fprintf(output, "Cartoon{title=%s,year=%d,type=%s}", title, year, Map(type));
}

Cartoon::Cartoon(const char *title, int year, enum Cartoon::type type) : Film(title, year), type(type) {}
