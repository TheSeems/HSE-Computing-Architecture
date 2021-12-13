#ifndef HSE_COMPUTING_ARCHITECTURE_BARBER_H
#define HSE_COMPUTING_ARCHITECTURE_BARBER_H

#include "visitor/visitor.h"
#include "salon/salon.h"
#include <mutex>
#include <thread>
#include <cassert>

class Barber {
private:
  // Salon associated with barber
  Salon m_salon;

  // Barber mutex (for barber to cut visitor)
  std::mutex m_barber_mutex;

  // Count of barber's visitors
  int m_count_of_visitors;

public:
  // Construct barber of visitors count
  explicit Barber(int count_of_visitors);

  // Push visitor via barber to barber's salon
  void push(Visitor *visitor);

  // Let barber start their work
  void run();
};

#endif //HSE_COMPUTING_ARCHITECTURE_BARBER_H
