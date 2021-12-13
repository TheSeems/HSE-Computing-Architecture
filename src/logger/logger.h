#ifndef HSE_COMPUTING_ARCHITECTURE_LOGGER_H
#define HSE_COMPUTING_ARCHITECTURE_LOGGER_H

#include <istream>
#include <mutex>
#include <atomic>
#include <iostream>
#include <cstring>
#include <sstream>
#include <thread>

namespace salon {
  class Logger {
  public:
    template<typename T, typename... Ts>
    void log(T &&arg, Ts &&... args) const;

    template<typename... Ts>
    void operator()(Ts &&... args) const {
        log(std::forward<Ts>(args)...);
    }
  };

  const Logger logger;
}

template<typename T, typename... Ts>
void salon::Logger::log(T &&arg, Ts &&... args) const {
    // Getting current time
    auto time = new time_t(std::time(nullptr));
    std::tm current_time = *std::localtime(time);

    // Building up a time string
    char time_buffer[100];
    strftime(time_buffer, sizeof(time_buffer), "[%Y-%m-%d.%X]", &current_time);

    // Writing built line to stream
    std::stringstream stream;

    stream << "[Thread" << std::this_thread::get_id() << "] ";
    stream << time_buffer << ' ';
    stream << std::forward<T>(arg);
    ((stream << ' ' << std::forward<Ts>(args)), ...);
    stream << '\n';

    // Atomically write line
    std::cout << stream.str();

    delete time;
}

#endif //HSE_COMPUTING_ARCHITECTURE_LOGGER_H
