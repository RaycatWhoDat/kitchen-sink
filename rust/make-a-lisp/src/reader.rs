struct Reader {
    input: String,
    position: usize
}

impl Reader {
    fn peek(self) -> String { self.input[0] }
    fn next(&mut self) {
        let character = peek();
        self.position += 1;
        character
    }
}
