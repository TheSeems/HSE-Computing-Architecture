#include "visitor.h"

Visitor::Visitor(int id) : id(id) {
    m_sleep_mutex.lock();
    m_haircut_mutex.lock();
};

void Visitor::run() {
    m_sleep_mutex.lock();

    salon::logger("Visitor", getDisplay(), "wakes up");
    m_haircut_mutex.lock();

    salon::logger(getDisplay(), "is now happy with their haircut");
}

void Visitor::awake() {
    m_sleep_mutex.unlock();
}

void Visitor::done() {
    m_haircut_mutex.unlock();
}

std::string Visitor::getDisplay() const {
    return name + "(" + std::to_string(id) + ")";
}
