struct Memory {
    data: [u8; 8]
}

impl Memory {
    fn get_data(&self) -> [u8; 8] { self.data }
    
    fn get_integer_value(&self) -> u8 {
        let mut value = 0;
        for (index, item) in self.data.iter().enumerate() {
            value += item << (7 - index)
        }
        value
    }

    fn set_integer_value(&mut self, number: u8) {
        let mut count = number;
        for index in 0..=7 {
            let place = 1 << (7 - index);
            let result = (count >= place) as u8;
            self.data[index] = result;
            if result == 1 { count -= place; }
        }
    }
}

fn main() {
    let mut memory = Memory {
        data: [0, 0, 0, 0, 0, 0, 0, 0]
    };

    memory.set_integer_value(123);
    
    println!("{:?}", memory.get_data());
    println!("{:?}", memory.get_integer_value());
}
