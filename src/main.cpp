#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <ctime>

#include "container/container.h"
#include "utils/random/random.h"

void SendIncorrectUsage() {
  printf("Incorrect usage.\n"
         "  Expected:\n"
         "     command -f input_file output_file_1 output_file_2\n"
         "  Or:\n"
         "     command -n size output_file_1 output_file_2\n");
}

void SendIncorrectQualifier() {
  printf("Incorrect qualifier value.\n"
         "  Expected:\n"
         "     command -f input_file output_file_1 output_file_2\n"
         "  Or:\n"
         "     command -n size output_file_1 output_file_2\n");
}

void SendIncorrectSize(int size) {
  printf("Incorrect size provided: %d. Expected incorrect_0 < size <= %d\n", size, CONTAINER_MAX_SIZE);
}

void ViaFile(container &container, const char *name) {
  FILE *file = fopen(name, "rw");
  In(container, file);
  fclose(file);
}

void ViaStochastic(container &container, const int size) {
  if ((size < 1) || (size > 10000)) {
    SendIncorrectSize(size);
    exit(3);
  }

  Randomize();
  InStochastic(container, size);
}

void SortWithContainer(container &container, const char *input, const char *output) {
  FILE *outFile1 = fopen(input, "w+");
  fprintf(outFile1, "Input container:\n");
  Out(container, outFile1);

  FILE *outFile2 = fopen(output, "w+");
  Sort(container);
  fprintf(outFile2, "Sorted container:\n");
  Out(container, outFile2);

  Clear(container);
  fclose(outFile1);
  fclose(outFile2);
}

int main(int argc, char *argv[]) {
  if (argc != 5) {
    SendIncorrectUsage();
    return 1;
  }

  clock_t start, stop;
  start = clock();
  printf("Start\n");

  container container{};
  Init(container);

  if (!strcmp(argv[1], "-f")) {
    ViaFile(container, argv[2]);
  } else if (!strcmp(argv[1], "-n")) {
    ViaStochastic(container, atoi(argv[2]));
  } else {
    SendIncorrectQualifier();
    return 2;
  }

  SortWithContainer(container, argv[3], argv[4]);

  stop = clock();
  printf("Stop\n");
  printf("Time elapsed %f s", double(stop - start) / CLOCKS_PER_SEC);
  return 0;
}