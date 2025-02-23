#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>

// Character stats
template <typename T> struct Stat {
  std::string name;
  T value;

  Stat(std::string n, T v) : name(n), value(v) {}
};

// Game character class
class Character {
private:
  std::string name;
  std::vector<Stat<int>> stats;

public:
  Character(std::string n) : name(n) {
    stats.push_back(Stat<int>("Health", 100));
    stats.push_back(Stat<int>("Strength", 10));
  }

  void takeDamage(int amount) {
    for (auto &stat : stats) {
      if (stat.name == "Health") {
        stat.value -= amount;
        if (stat.value <= 0) {
          throw std::runtime_error("Character defeated!");
        }
        std::cout << name << " took " << amount << " damage.\n";
        return;
      }
    }
  }

  void displayStats() const {
    std::cout << "Stats for " << name << ":\n";
    for (const auto &stat : stats) {
      std::cout << stat.name << ": " << stat.value << "\n";
    }
  }
};

int main() {
  try {
    Character hero("Hero");
    hero.displayStats();
    hero.takeDamage(30);
    hero.displayStats();
    hero.takeDamage(80); // Should throw exception
  } catch (const std::runtime_error &e) {
    std::cerr << "Error: " << e.what() << std::endl;
  }
  return 0;
}
