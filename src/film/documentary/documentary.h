#ifndef COMPARCH_HOMEWORK_FIRST_DOCUMENTARY_H
#define COMPARCH_HOMEWORK_FIRST_DOCUMENTARY_H

#include <cstdio>
#include "../film.h"

class Documentary : virtual public Film {
private:
  // Длительность документального фильма
  int duration;

public:
  Documentary(const char *title, int year, int duration);

  static Film* In(const char *title, int year, FILE *input);

  static Film *InStochastic();

  void Out(FILE *output) override;
};

#endif //COMPARCH_HOMEWORK_FIRST_DOCUMENTARY_H
