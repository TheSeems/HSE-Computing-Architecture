cmake_minimum_required(VERSION 3.16)
project(HSE_Computing_Architecture)

set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

set(CMAKE_CXX_STANDARD 17)

include_directories(src)

add_executable(HSE_Computing_Architecture
        src/barber/barber.cpp
        src/barber/barber.h
        src/logger/logger.h
        src/salon/salon.cpp
        src/salon/salon.h
        src/visitor/visitor.cpp
        src/visitor/visitor.h
        src/main.cpp)

target_link_libraries(HSE_Computing_Architecture PRIVATE Threads::Threads)