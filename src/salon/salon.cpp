#include "salon.h"

Salon::Salon(std::mutex &barber_mutex) :
    m_barber_mutex(barber_mutex),
    m_visitors(),
    m_queue_mutex() {
}

void Salon::push(Visitor *visitor) {
    std::lock_guard<std::mutex> lock_guard(m_queue_mutex);
    m_visitors.push(visitor);
    m_barber_mutex.unlock();
}

Visitor *Salon::pop() {
    std::lock_guard<std::mutex> lock_guard(m_queue_mutex);
    auto *result = m_visitors.front();
    m_visitors.pop();

    return result;
}

bool Salon::empty() {
    std::lock_guard<std::mutex> lock_guard(m_queue_mutex);
    return m_visitors.empty();
}