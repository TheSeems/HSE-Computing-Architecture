#ifndef COMPARCH_HOMEWORK_FIRST_FILM_H
#define COMPARCH_HOMEWORK_FIRST_FILM_H

#include <cstdio>

class Film {
protected:
  int year;
  const char *title;

public:
  Film(const char *title, int year);

  /**
   * Ввод из файла
   * @param input файл, с которого требуется ввести данные
   */
  static Film *In(FILE *input);

  /**
   * Ввод стохастическими данными (рандомом)
   */
 static Film *InStochastic();

  /**
   * Вывод
   */
  virtual void Out(FILE *output) = 0;

  /**
   * Общая для всех альтернатив функция:
   * частное от деления года выхода фильма на количество символов в названии
   *
   * Играет роль ключа для сортировки
   * @return ключ для сортировки - год, деленный на количество символов в названии
   */
  double GetSortKey();
};

#endif //COMPARCH_HOMEWORK_FIRST_FILM_H
