//
// Created by me on 08.10.2021.
//

#ifndef COMPARCH_HOMEWORK_FIRST_RANDOM_H
#define COMPARCH_HOMEWORK_FIRST_RANDOM_H

const char NUMS_AND_CHARS[] = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789";
const int NUMS_AND_CHARS_LENGTH = 62;


int RandomInt(int from, int to);

char *RandomString(int length);

void Randomize();

#endif //COMPARCH_HOMEWORK_FIRST_RANDOM_H
