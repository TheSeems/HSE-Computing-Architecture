#ifndef HSE_COMPUTING_ARCHITECTURE_VISITOR_H
#define HSE_COMPUTING_ARCHITECTURE_VISITOR_H

#include "logger/logger.h"
#include <mutex>

class Visitor {
private:
  // Sleep mutex (for Visitor to sleep)
  std::mutex m_sleep_mutex;

  // Haircut mutex (for Visitor to get a haircut)
  std::mutex m_haircut_mutex;

public:
  // Visitor's id
  int id;

  // Visitor's name
  std::string name;

  // Construct a Visitor by id
  explicit Visitor(int);

  // Start up a visitor
  void run();

  // Awake visitor (when ready for a haircut)
  void awake();

  // Done with this visitor
  void done();

  // Get display string for the visitor
  [[nodiscard]] std::string getDisplay() const;
};

#endif //HSE_COMPUTING_ARCHITECTURE_VISITOR_H
