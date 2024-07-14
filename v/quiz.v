import readline { read_line }

struct Question {
	text   string
	answer string
}

fn main() {
	mut questions := []Question{}
	mut correct_answers := 0

	questions << Question{'This is a test. What is the answer?', 'A'}
	questions << Question{'This is another test. Why is the answer?', 'B'}
	questions << Question{'This is the final test. How is the answer?', 'C'}

	for question in questions {
		println(question.text)
		mut valid_answer := false
		for !valid_answer {
			answer := read_line('Please enter your answer (A, B, C, etc.): ')!.trim_space().to_upper()
			if answer.len == 1 && answer[0] in [`A`, `B`, `C`] {
				valid_answer = true
				if answer[0] == question.answer[0] {
					correct_answers++
				}
			} else {
				println('Invalid input. Please enter a valid answer (A, B, C, etc.).')
			}
		}
	}

	println('${correct_answers} out of ${questions.len} correct')
	percentage := (f32(correct_answers) / questions.len) * 100
	println('Percentage: ${percentage:.2f}%')
}
