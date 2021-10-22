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

void ViaFile(Container &container, const char *name) {
  FILE *file = fopen(name, "rw");
  if (file == nullptr) {
    printf("File '%s' was not found or is not either readable or writable", name);
    exit(1);
  }

  container.In(file);
  fclose(file);
}

void ViaStochastic(Container &container, const int size) {
  if ((size < 1) || (size > 10000)) {
    SendIncorrectSize(size);
    exit(3);
  }

  Randomize();
  container.InStochastic(size);
}

void SortWithContainer(Container &container, const char *input, const char *output) {
  FILE *outFile1 = fopen(input, "w+");
  FILE *outFile2 = fopen(output, "w+");
  if (outFile1 == nullptr) {
    printf("File '%s' was not found or is not writable", input);
    exit(1);
  }
  if (outFile2 == nullptr) {
    printf("File '%s' was not found or is not writable", output);
    exit(1);
  }

  fprintf(outFile1, "Input container:\n");
  container.Out(outFile1);

  container.Sort();
  fprintf(outFile2, "Sorted container:\n");
  container.Out(outFile2);

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

  Container container;
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
  printf("Time elapsed %f s", double(stop - start) / CLOCKS_PER_SEC);
  return 0;
}