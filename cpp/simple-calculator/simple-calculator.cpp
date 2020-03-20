#include <iostream>
#include <vector>
#include <string>

int main() {
  std::string input;
  std::vector<int> numbers;
  
  std::cout << "Enter a list of numbers separated by spaces: " << std::endl;
  std::getline(std::cin, input);

  for (const char &character : input) {
    try {
      std::string number_string(character, 1);
      numbers.push_back(std::stod(number_string));
      std::cout << number_string << std::endl;
    } catch (const std::exception& error) {
      std::cout << "Something broke: " << error.what() << std::endl;
    }
  }
}

// Local Variables:
// compile-command: "clang++ -std=c++17 -stdlib=libc++ -Wall -Wextra -fsanitize=address,undefined -g ./simple-calculator.cpp"
// End:
