#include <stdio.h>
#include <string.h>
#include <ctype.h>

struct Question {
  char questionAnswer;
  char questionText[50];
};

int main() {
  int index;
  int correctAnswers = 0;
  struct Question questions[2];
  char guesses[2];

  strcpy(questions[0].questionText, "This is a test. What is the answer?");
  questions[0].questionAnswer = 'A';

  strcpy(questions[1].questionText, "This is another test. Why is the answer?");
  questions[1].questionAnswer = 'B';
  
  size_t numberOfQuestions = sizeof(questions) / sizeof(struct Question);

  for (index = 0; index < numberOfQuestions; index++) {
    printf("%s\n", questions[index].questionText);
    scanf(" %c", &guesses[index]);
    if (toupper(guesses[index]) == questions[index].questionAnswer) {
      correctAnswers++;
    }
  }

  printf("%i out of %li correct\n", correctAnswers, numberOfQuestions);
  printf("Percentage: %ld%%\n", (correctAnswers / numberOfQuestions) * 100);
  
  return 0;
}

// Local Variables:
// compile-command: "gcc -o quiz quiz.c && ./quiz"
// End:
