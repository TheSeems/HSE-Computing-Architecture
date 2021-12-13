#include "barber.h"

Barber::Barber(int count_of_visitors) :
    m_barber_mutex(),
    m_salon(m_barber_mutex),
    m_count_of_visitors(count_of_visitors) {
    m_barber_mutex.lock();
}

void Barber::push(Visitor *visitor) {
    m_salon.push(visitor);
}

void Barber::run() {
    for (int i = 0; i < m_count_of_visitors; ++i) {
        if (m_salon.empty()) {
            // Locking and waiting for queue to fill
            salon::logger("Barber is waiting for visitors...");
            m_barber_mutex.lock();
        }

        // Try lock barber waiting for the queue
        m_barber_mutex.try_lock();
        assert(!m_salon.empty());

        // Get and then serve a visitor
        auto *new_visitor = m_salon.pop();
        salon::logger("Barber greets new visitor", new_visitor->getDisplay());
        new_visitor->awake();

        salon::logger("Barber cuts visitor with id", new_visitor->getDisplay());
        std::this_thread::sleep_for(std::chrono::milliseconds(100));

        new_visitor->done();
        salon::logger("Visitor", new_visitor->getDisplay(), "is served well");
    }
}