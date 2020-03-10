#include <iostream>
#include <vector>
#include <string>

int main() {
  std::string input;
  
  std::cout << "Enter a list of numbers separated by spaces: " << std::endl;
  std::getline(std::cin, input);

  for (const char &character : input) {
    std::cout << character << " ";
  }
  
  std::cout << "This is a test." << std::endl;
}

// Local Variables:
// compile-command: "clang++ -std=c++17 -stdlib=libc++ -Wall -Wextra -fsanitize=address,undefined -g ./simple-calculator.cpp"
// End:
