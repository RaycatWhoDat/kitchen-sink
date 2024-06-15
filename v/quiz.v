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
		answer := read_line('')!.trim_space().to_upper()[0]

		if answer == question.answer[0] {
			correct_answers++
		}
		1
	}

	println('${correct_answers} out of ${questions.len} correct')
	percentage := (f32(correct_answers) / questions.len) * 100
	println('Percentage: ${percentage:.2f}%')
}
