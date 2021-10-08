#ifndef COMPARCH_HOMEWORK_FIRST_FEATURE_H
#define COMPARCH_HOMEWORK_FIRST_FEATURE_H

#include <cstdio>

struct feature {
  // Режисер игрового фильма
  char *director;

  // Общие поля для всех жанров фильмов
  char *title;
  int year;
};

/**
 * Функционал ввода/вывода данных об игровом фильме
 */

// Ввод из файла
void In(feature &feature, FILE *input);
// Ввод случайными значениями
void inStochastic(feature &feature);

// Вывод
void Out(feature &feature, FILE *output);

#endif //COMPARCH_HOMEWORK_FIRST_FEATURE_H
