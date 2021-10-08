#ifndef COMPARCH_HOMEWORK_FIRST_FILM_H
#define COMPARCH_HOMEWORK_FIRST_FILM_H

#include <cstdio>
#include "cartoon/cartoon.h"
#include "documentary/documentary.h"
#include "feature/feature.h"

struct film {
  // Общие жанры фильмов
  enum genre {
    FEATURE, CARTOON, DOCUMENTARY
  } genre;

  // Альтернативы
  union {
    struct feature feature;
    struct cartoon cartoon;
    struct documentary documentary;
  };
};

// Общая для всех альтернатив функция:
// частное от деления года выхода фильма на количество символов в названии
double YearOverTitleSymbols(film &film);

/**
 * Функционал ввода/вывода данных об игровом фильме
 */

// Ввод из файла
void In(film &film, FILE *input);
// Ввод случайными значениями
void inStochastic(film &film);

// Вывод
void Out(film &film, FILE *output);

#endif //COMPARCH_HOMEWORK_FIRST_FILM_H
