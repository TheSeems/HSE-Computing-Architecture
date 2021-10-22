#ifndef COMPARCH_HOMEWORK_FIRST_CARTOON_H
#define COMPARCH_HOMEWORK_FIRST_CARTOON_H

#include <cstdio>
#include "../film.h"

class Cartoon : public virtual Film {
public:
  // Способ создания мультика
  enum type {
    DRAWING, PUPPET, PLASTICINE
  };

  Cartoon(const char *title, int year, type type);

  static Film* In(const char *title, int year, FILE *input);

  static Film *InStochastic();

  void Out(FILE *output) override;

private:
  type type;
};

#endif //COMPARCH_HOMEWORK_FIRST_CARTOON_H
