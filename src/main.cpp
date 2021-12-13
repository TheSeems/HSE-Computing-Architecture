#include <thread>
#include <vector>
#include <functional>
#include "logger/logger.h"
#include "salon/salon.h"
#include "barber/barber.h"

void promptInVisitors(std::vector<Visitor *> &visitors) {
    int count_of_visitors = -1;
    while (count_of_visitors <= 0) {
        std::cout << "Please, enter in count of visitors" << std::endl;
        std::cin >> count_of_visitors;
        if (count_of_visitors <= 0) {
            std::cout << "Please, enter in a positive integer" << std::endl;
        }
    }

    visitors.resize(count_of_visitors, nullptr);
    for (int i = 0; i < count_of_visitors; ++i) {
        std::cout << "Please, enter in new visitor's name (" << (i + 1) << "/" << count_of_visitors << ")" << std::endl;
        visitors[i] = new Visitor(i + 1);
        std::cin >> visitors[i]->name;
    }
}

int main() {
    // Make visitors
    std::vector<Visitor *> visitors;
    promptInVisitors(visitors);

    // Making new barber with initial count of visitors
    Barber barber(visitors.size());

    // Make threads for visitors
    for (auto &visitor: visitors) {
        std::thread visitor_thread([&visitor]() {
          visitor->run();
        });

        visitor_thread.detach();
    }

    // Make thread for barber
    std::thread barber_thread([&barber, &visitors]() {
      barber.run();

      // After work utilize resources for visitors
      for (auto &item: visitors) {
          delete item;
      }
    });

    // Push visitors to barber (salon)
    for (auto &visitor: visitors) {
        barber.push(visitor);
    }

    // Run barber's thread
    barber_thread.join();

    std::cout << std::flush;
    return 0;
}