//
// Created by me on 08.10.2021.
//

#ifndef COMPARCH_HOMEWORK_FIRST_CONTAINER_H
#define COMPARCH_HOMEWORK_FIRST_CONTAINER_H

#include "../film/film.h"

// Максимальная длина массива для контейнера
const int CONTAINER_MAX_SIZE = 10'000;

struct container {
  // Текущий размер контейнера
  int size;

  // Массив фильмов, содержащихся в контейрене
  film *array;
};

void Init(container &c);

void Clear(container &c);

void In(container &c, FILE *input);

void InStochastic(container &c, int size);

void Out(container &c, FILE *output);

void Sort(container &c);

#endif //COMPARCH_HOMEWORK_FIRST_CONTAINER_H
