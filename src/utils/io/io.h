//
// Created by me on 08.10.2021.
//

#ifndef COMPARCH_HOMEWORK_FIRST_IO_H
#define COMPARCH_HOMEWORK_FIRST_IO_H

#include <cstdio>
#include "../../film/feature/feature.h"

const int STRING_MAX_LENGTH = 128;

int ReadIntIn(FILE *file, int from, int to, const char* error);

char *ReadString(FILE *file);

#endif //COMPARCH_HOMEWORK_FIRST_IO_H
