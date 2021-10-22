#ifndef COMPARCH_HOMEWORK_FIRST_CONTAINER_H
#define COMPARCH_HOMEWORK_FIRST_CONTAINER_H

#include "../film/film.h"

// Максимальная длина массива для контейнера
const int CONTAINER_MAX_SIZE = 10'000;

class Container {
private:
  // Текущий размер контейнера
  int size{0};
  // Массив фильмов, содержащихся в контейрене
  Film* *array{new Film*[CONTAINER_MAX_SIZE]};

public:
  Container();
  ~Container();
  Film*& operator[](int);

  void Clear();
  void In(FILE *input);
  void InStochastic(int size);

  void Out(FILE *output);
  void Sort();
};

#endif //COMPARCH_HOMEWORK_FIRST_CONTAINER_H
