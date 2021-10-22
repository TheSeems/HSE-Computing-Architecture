#include <cstdlib>
#include "container.h"

Container::Container() = default;

Container::~Container() {
  delete[] array;
}

Film *&Container::operator[](int index) {
  return array[index];
}

void Container::In(FILE *input) {
  while (!feof(input)) {
    if (size >= CONTAINER_MAX_SIZE) {
      printf("Out of container's capacity. Consider providing less amount entries.");
      exit(2);
    }

    array[size++] = Film::In(input);
  }
}

void Container::InStochastic(int initialSize) {
  if (initialSize <= 0) {
    printf("Count of entries should be > 0");
    exit(0);
  }

  if (initialSize > CONTAINER_MAX_SIZE) {
    printf("Out of container's capacity. Consider requesting less amount of random entries.");
    exit(2);
  }

  for (int i = 0; i < initialSize; i++) {
    array[size++] = Film::InStochastic();
  }
}

void Container::Out(FILE *output) {
  for (int i = 0; i < size; i++) {
    fprintf(output, "%d. ", i + 1);

    array[i]->Out(output);
    fprintf(output, ", sort_key = %f\n", array[i]->GetSortKey());
  }
}

void Container::Sort() {
  for (int i = 0; i < size; i++) {
    for (int j = i; j < size; j++) {
      double first = array[i]->GetSortKey();
      double second = array[j]->GetSortKey();

      if (second > first) {
        Film* temp = array[i];
        array[i] = array[j];
        array[j] = temp;
      }
    }
  }
}
