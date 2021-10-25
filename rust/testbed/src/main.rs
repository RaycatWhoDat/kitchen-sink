use std::iter::successors;

#[derive(Default)]
struct User {
    first_name: String,
    last_name: String,
    email: String
}

impl User {
    fn get_full_info(self) -> String {
        return format!("{} {} <{}>", self.first_name, self.last_name, self.email);
    }
}

fn main() {
    let user = User {
        first_name: String::from("Another"),
        last_name: String::from("Test"),
        email: String::from("test@example.com")
    };
    
    println!("{}", user.get_full_info());

    let fibonacci = successors(Some((1, 1)), |(prev, curr)| Some((*curr, *prev + *curr)));
    for (number, _) in fibonacci.take(10) {
        println!("{:#?}", number);
    }
}
