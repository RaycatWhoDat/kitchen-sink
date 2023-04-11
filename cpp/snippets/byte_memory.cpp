#include <iostream>
#include <cstring>

struct Memory
{
  unsigned short int data[8];

  Memory(unsigned short int _data[8]) {
    for (int index = 0; index < 8; index++) {
      data[index] = _data[index];
    }
  }
  
  unsigned short int get_integer_value()
  {
    unsigned short int result = 0;
    for (int index = 0; index < 8; index++) {
      result += (data[index] << (7 - index));
    }
    return result;
  }
  
  void set_integer_value(unsigned short int number)
  {
    unsigned short int place, result;
    unsigned short int count = number;
    for (int index = 0; index < 8; index++) {
      place = 1 << (7 - index);
      result = count >= place ? 1 : 0;
      data[index] = result;
      if (result == 1) {
        count -= place;
      }
    }
  }
};

int main() {
  unsigned short int memory_data[] = { 0, 0, 0, 0, 0, 0, 0, 0 };

  Memory memory = Memory(memory_data);
  
  memory.set_integer_value(128);
  
  for (auto& value : memory.data) {
    std::cout << value;
  }
  
  std::cout << std::endl;

  std::cout << memory.get_integer_value() << std::endl;
  
  return 0;
}

