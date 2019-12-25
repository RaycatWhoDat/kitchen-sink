#include <iostream>

template<typename... Args>
bool all(Args... args) {
  return (... && args);
}

template<typename... Args>
bool some(Args... args) {
  return (... || args);
}

int main() {
  std::cout
      << std::boolalpha 
      << (all(true, false, true) || some(true, false, true))
      << std::endl;
}

// Local Variables:
// compile-command: "g++ -std=c++17 -o folding folding.cpp && ./folding"
// End:
