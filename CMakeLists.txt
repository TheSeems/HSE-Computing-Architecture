cmake_minimum_required(VERSION 3.10.2)
project(comparch_homework_second)

set(CMAKE_CXX_STANDARD 14)

add_executable(comparch_homework_second src/main.cpp src/film/film.h src/film/feature/feature.h src/film/cartoon/cartoon.h src/film/documentary/documentary.h src/film/film.cpp src/film/feature/feature.cpp src/film/cartoon/cartoon.cpp src/film/documentary/documentary.cpp src/utils/random/random.cpp src/utils/random/random.h src/utils/io/io.cpp src/utils/io/io.h src/container/container.cpp src/container/container.h)
