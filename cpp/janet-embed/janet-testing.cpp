#include <iostream>
#include <fstream>
#include <sstream>
#include "janet.h"

int main() {
  janet_init();
  JanetTable *env = janet_core_env(NULL);

  std::ifstream janet_script("test-script.janet");
  std::stringstream script_stream;
  
  if (janet_script.is_open()) {
    script_stream << janet_script.rdbuf();
    janet_dostring(env, script_stream.str().c_str(), "main", NULL);
  } 

  janet_deinit();
  return 0;
}
