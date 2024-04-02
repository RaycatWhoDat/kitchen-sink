#include <stdio.h>
#include <stdlib.h>

typedef enum {
  NONE = 0,
  NUMBER,
  STRING
} DYN_VALUE_TYPE;

typedef union {
  float *number_value;
  char *string_value;
} DYN_VALUE_DATA;

typedef struct {
  DYN_VALUE_TYPE type;
  DYN_VALUE_DATA value;
} DYN_VALUE;

typedef struct {
  int capacity;
  int length;
  DYN_VALUE *data;
} DYN_ARRAY;

DYN_VALUE make_dynamic_value(void *value, DYN_VALUE_TYPE type) {
  DYN_VALUE new_value;
  DYN_VALUE_DATA new_data;
  float *number_primitive;
  char *string_primitive;

  switch (type) {
  case NUMBER:
    number_primitive = value;
    new_data.number_value = number_primitive;
    new_value.type = NUMBER;
    break;
  case STRING:
    string_primitive = value;
    new_data.string_value = string_primitive;
    new_value.type = STRING;
    break;
  default:
    break;
  }

  new_value.value = new_data;
    
  return new_value;
}

void *get_value(DYN_VALUE *dyn_value) {
  switch (dyn_value->type) {
  case NUMBER:
    return dyn_value->value.number_value;
  case STRING:
    return dyn_value->value.string_value;
  default:
    return NULL;
  }
}

DYN_ARRAY make_dynamic_array() {
  DYN_ARRAY arr = { .capacity = 1, .length = 0, .data = calloc(1, sizeof(DYN_VALUE)) };
  return arr;
}

void insert_into_array(DYN_ARRAY *arr, void *value, DYN_VALUE_TYPE type) {
  arr->data[arr->length] = make_dynamic_value(value, type);
  arr->length += 1;

  if (arr->length >= arr->capacity) {
    arr->capacity *= 2;
    arr->data = realloc(arr->data, arr->capacity * sizeof(DYN_VALUE));
  }
}

void insert_number(DYN_ARRAY *arr, void *value) {
  insert_into_array(arr, value, NUMBER);
}

void insert_string(DYN_ARRAY *arr, void *value) {
  insert_into_array(arr, value, STRING);
}

void remove_value(DYN_ARRAY *arr) {
  if (arr->length <= 0) return;
  
  arr->data[arr->length] = make_dynamic_value(NULL, NONE);
  arr->length -= 1;

  if (arr->length < (arr->capacity / 2)) {
    arr->capacity /= 2;
    arr->data = realloc(arr->data, arr->capacity * sizeof(DYN_VALUE));
  }
}

void print_each(DYN_ARRAY *arr) {
  for (int i = 0; i < arr->length; i++) {
    if (arr->data[i].type == NONE) continue;
    
    printf("[%d] ", i);
    if (arr->data[i].type == NUMBER) {
      float *number_value = get_value(&arr->data[i]);
      printf("%f\n", *number_value);
    }
    
    if (arr->data[i].type == STRING) {
      char *string_value = get_value(&arr->data[i]);
      printf("%s\n", string_value);
    } 
  }
}

int main() {
  char *test_strings[] = {
    "This is the first test.",
    "This is the second test.",
    "This is the third test.",
    "This is the final test."
  };

  float test_numbers[] = { 1.0, 100.0, 100000.0 };

  DYN_ARRAY test_cases = make_dynamic_array();
  insert_string(&test_cases, test_strings[0]);
  insert_string(&test_cases, test_strings[1]);
  insert_number(&test_cases, &test_numbers[0]);
  insert_number(&test_cases, &test_numbers[1]);
  insert_string(&test_cases, test_strings[2]);
  insert_number(&test_cases, &test_numbers[2]);
  insert_string(&test_cases, test_strings[3]);
  remove_value(&test_cases);
  remove_value(&test_cases);
  insert_string(&test_cases, test_strings[0]);
  insert_string(&test_cases, test_strings[1]);
  remove_value(&test_cases);
  remove_value(&test_cases);
  remove_value(&test_cases);
  insert_string(&test_cases, test_strings[0]);
  insert_string(&test_cases, test_strings[1]);
  insert_string(&test_cases, test_strings[3]);
  insert_number(&test_cases, &test_numbers[0]);
  insert_number(&test_cases, &test_numbers[1]);
  insert_number(&test_cases, &test_numbers[2]);
  insert_number(&test_cases, &test_numbers[0]);
  insert_number(&test_cases, &test_numbers[1]);
  insert_number(&test_cases, &test_numbers[2]);
  insert_number(&test_cases, &test_numbers[0]);
  insert_number(&test_cases, &test_numbers[1]);
  insert_number(&test_cases, &test_numbers[2]);
  remove_value(&test_cases);
  remove_value(&test_cases);
  remove_value(&test_cases);
  remove_value(&test_cases);
  
  print_each(&test_cases);
  printf("\nTotal capacity of array: %d\n", test_cases.capacity);
  printf("Length of array: %d\n", test_cases.length);
  
  return 0;
}
