struct Memory {
    data: [u8; 8]
}

impl Memory {
    fn get_integer_value(&self) -> u8 {
        let mut value = 0;
        for (index, item) in self.data.iter().enumerate() {
            value += item << (8 - index - 1)
        }
        value
    }
}

fn main() {
    let mut memory = Memory {
        data: [0, 0, 0, 0, 0, 0, 0, 0]
    };

    memory.data[7] = 1;
    
    println!("{}", memory.get_integer_value());
}
