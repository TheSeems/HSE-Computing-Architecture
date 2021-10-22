#ifndef COMPARCH_HOMEWORK_FIRST_FEATURE_H
#define COMPARCH_HOMEWORK_FIRST_FEATURE_H

#include <cstdio>
#include "../film.h"

class Feature: virtual public Film {
private:
  // Режисер игрового фильма
  const char *director;
public:
  Feature(const char *title, int year, const char *director);

  static Film* In(const char *title, int year, FILE *input);

  static Film* InStochastic();

  void Out(FILE *output) override;
};

#endif //COMPARCH_HOMEWORK_FIRST_FEATURE_H
