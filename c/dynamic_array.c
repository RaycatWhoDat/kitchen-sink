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
  int length;
  int offset;
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

int get_type(DYN_VALUE *dyn_value) {
  return dyn_value->type;
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
  DYN_ARRAY arr = { .length = 1, .offset = 0, .data = calloc(1, sizeof(DYN_VALUE)) };
  return arr;
}

void insert_into_array(DYN_ARRAY *arr, void *value, DYN_VALUE_TYPE type) {
  if (arr->offset + 1 >= arr->length) {
    arr->length *= 2;
    arr->data = realloc(arr->data, arr->length * sizeof(DYN_VALUE));
  }

  arr->data[arr->offset] = make_dynamic_value(value, type);
  arr->offset += 1;
}

void remove_from_array(DYN_ARRAY *arr) {
  if (arr->offset <= 0) return;
  
  arr->data[arr->offset] = make_dynamic_value(NULL, NONE);
  arr->offset -= 1;

  if (arr->offset < arr->length / 2) {
    arr->length /= 2;
    arr->data = realloc(arr->data, arr->length * sizeof(DYN_VALUE));
  }
}

void print_each(DYN_ARRAY *arr) {
  for (int i = 0; i < arr->length; i++) {
    if (get_type(&arr->data[i]) == NUMBER) {
      float *number_value = get_value(&arr->data[i]);
      printf("%f\n", *number_value);
    }
    
    if (get_type(&arr->data[i]) == STRING) {
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
  insert_into_array(&test_cases, test_strings[0], STRING);
  insert_into_array(&test_cases, test_strings[1], STRING);
  insert_into_array(&test_cases, &test_numbers[0], NUMBER);
  insert_into_array(&test_cases, &test_numbers[1], NUMBER);
  insert_into_array(&test_cases, test_strings[2], STRING);
  insert_into_array(&test_cases, &test_numbers[2], NUMBER);
  insert_into_array(&test_cases, test_strings[3], STRING);

  print_each(&test_cases);
  
  return 0;
}
