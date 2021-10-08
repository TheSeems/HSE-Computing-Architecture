#ifndef COMPARCH_HOMEWORK_FIRST_DOCUMENTARY_H
#define COMPARCH_HOMEWORK_FIRST_DOCUMENTARY_H

#include <cstdio>

struct documentary {
  // Длительность документального фильма
  int duration;

  // Общие поля для всех жанров фильмов
  char *title;
  int year;
};

/**
 * Функционал ввода/вывода данных о мультфильме
 */

// Ввод из файла
void In(documentary &documentary, FILE *input);
// Ввод случайными значениями
void inStochastic(documentary &documentary);

// Вывод
void Out(documentary &documentary, FILE *output);

#endif //COMPARCH_HOMEWORK_FIRST_DOCUMENTARY_H
