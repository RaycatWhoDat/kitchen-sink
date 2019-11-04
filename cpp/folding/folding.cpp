#include <iostream>

template<typename... Args>
bool all(Args... args) { return (... && args); }

int main() {
  std::cout << all(true) << std::endl;
}

// Local Variables:
// compile-command: "g++ -std=c++17 -o folding folding.cpp && ./folding"
// End:
