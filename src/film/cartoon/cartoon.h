#ifndef COMPARCH_HOMEWORK_FIRST_CARTOON_H
#define COMPARCH_HOMEWORK_FIRST_CARTOON_H

#include <cstdio>

struct cartoon {
  // Способ создания мультика
  enum type {
    DRAWING, PUPPET, PLASTICINE
  } type;

  // Общие поля для всех жанров фильмов
  char *title;
  int year;
};

/**
 * Функционал ввода/вывода данных о мультфильме
 */

// Ввод из файла
void In(cartoon &cartoon, FILE *input);
// Ввод случайными значениями
void inStochastic(cartoon &cartoon);

// Вывод
void Out(cartoon &cartoon, FILE *output);

#endif //COMPARCH_HOMEWORK_FIRST_CARTOON_H
