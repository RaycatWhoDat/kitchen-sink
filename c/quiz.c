#include <stdio.h>
#include <string.h>
#include <ctype.h>

struct Question
{
  char questionAnswer;
  char questionText[50];
};

int main()
{
  int index;
  int correctAnswers = 0;
  struct Question questions[3];
  char guesses[3];

  strcpy(questions[0].questionText, "This is a test. What is the answer?");
  questions[0].questionAnswer = 'A';

  strcpy(questions[1].questionText, "This is another test. Why is the answer?");
  questions[1].questionAnswer = 'B';
  
  strcpy(questions[2].questionText, "This is the final test. How is the answer?");
  questions[2].questionAnswer = 'C';
  
  int numberOfQuestions = sizeof(questions) / sizeof(struct Question);

  for (index = 0; index < numberOfQuestions; index++) {
    printf("%s\n", questions[index].questionText);
    scanf(" %c", &guesses[index]);
    if (toupper(guesses[index]) == questions[index].questionAnswer) {
      correctAnswers++;
    }
  }

  printf("%i out of %i correct\n", correctAnswers, numberOfQuestions);
  printf("Percentage: %.2f%%\n", 100.0 * correctAnswers / numberOfQuestions);
  
  return 0;
}

// Local Variables:
// compile-command: "gcc -o quiz quiz.c && ./quiz"
// End:
