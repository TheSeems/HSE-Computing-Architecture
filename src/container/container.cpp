//
// Created by me on 08.10.2021.
//

#include <cstdlib>
#include "container.h"

void Init(container &container) {
  container.array = new film[CONTAINER_MAX_SIZE];
  container.size = 0;
}

void Clear(container &container) {
  delete[] container.array;
  Init(container);
}

void In(container &container, FILE *input) {
  while (!feof(input)) {
    if (container.size >= CONTAINER_MAX_SIZE) {
      printf("Out of container's capacity. Consider providing less amount entries.");
      exit(2);
    }

    film film{};
    In(film, input);

    container.array[container.size++] = film;
  }
}

void InStochastic(container &container, int size) {
  if (size > CONTAINER_MAX_SIZE) {
    printf("Out of container's capacity. Consider requesting less amount of random entries.");
    exit(2);
  }

  for (int i = 0; i < size; i++) {
    film film{};
    inStochastic(film);

    container.array[container.size++] = film;
  }
}

void Out(container &container, FILE *output) {
  for (int i = 0; i < container.size; i++) {
    fprintf(output, "%d. ", i + 1);

    film current = container.array[i];
    if (current.genre == film::FEATURE) {
      Out(current.feature, output);
    } else if (current.genre == film::CARTOON) {
      Out(current.cartoon, output);
    } else if (current.genre == film::DOCUMENTARY) {
      Out(current.documentary, output);
    }

    fprintf(output, "\n");
  }
}

void Sort(container &container) {
  for (int i = 0; i < container.size; i++) {
    for (int j = i; j < container.size; j++) {
      double first = YearOverTitleSymbols(container.array[i]);
      double second = YearOverTitleSymbols(container.array[j]);

      if (second > first) {
        film temp = container.array[i];
        container.array[i] = container.array[j];
        container.array[j] = temp;
      }
    }
  }
}