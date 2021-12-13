#ifndef HSE_COMPUTING_ARCHITECTURE_SALON_H
#define HSE_COMPUTING_ARCHITECTURE_SALON_H

#include "visitor/visitor.h"
#include <vector>
#include <queue>
#include <shared_mutex>

class Salon {
private:
  // Salon's queue
  std::queue<Visitor *> m_visitors;

  // Mutex for synchronous salon's queue
  std::mutex m_queue_mutex;

  // Mutex for Barber
  std::mutex &m_barber_mutex;

public:
  explicit Salon(std::mutex &barber_mutex);

  // Push visitor to salon's queue
  void push(Visitor *);

  // Pop visitor from salon's queue
  Visitor *pop();

  // Check whether salon's queue is empty
  bool empty();
};

#endif //HSE_COMPUTING_ARCHITECTURE_SALON_H
