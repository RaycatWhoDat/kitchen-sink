#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

const int USER_ID_LENGTH = 10;

int isvalid(char* input)
{
  size_t index;
  int is_valid = 1;
  for (index = 0; index < USER_ID_LENGTH; index++) {
    char current_char = input[index];
    switch (index) {	
      case 2:
      case 3:
      case 4:
        if (!isalpha(current_char)) is_valid = 0;
        break;
      default:
        if (!isdigit(current_char)) is_valid = 0;
        break;
    }
    return is_valid;
  }
}

int main() {
  char user_id[USER_ID_LENGTH] = "42NJD03193";
  printf("User ID is %s.\n", isvalid(user_id) ? "valid" : "invalid");
}
