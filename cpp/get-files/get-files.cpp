#include <string>
#include <iostream>
#include <filesystem>
using std::string;
namespace fs = std::filesystem;

int main() {
  string const DIRECTORY_PATH = "..";
  string ignored_paths[] = {".git", "love", "target", "node_modules"};
  
  for (auto& entry : fs::recursive_directory_iterator(DIRECTORY_PATH)) {
    bool should_skip = false;
    for (auto ignored_path : ignored_paths) {
      if (entry.path().string().find(ignored_path) != string::npos)
        should_skip = true;
    }
    if (should_skip) continue;
    std::cout << entry.path().lexically_relative(DIRECTORY_PATH) << std::endl;
  }
}

// Local Variables:
// compile-command: "clang++-9 -std=c++17 -stdlib=libc++ -Wall -Wextra -g -fsanitize=address,undefined -o get-files ./get-files.cpp && ./get-files"
// End:
