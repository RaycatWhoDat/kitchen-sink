use std::iter::successors;

struct User {
    first_name: String,
    last_name: String,
    email: String
}

impl Default for User {
    fn default() -> Self {
        User {
            first_name: String::from("Test"),
            last_name: String::from("User"),
            email: String::from("test_user@gmail.com")
        }
    }
}

trait Printable {
    fn get_full_name(self) -> String;
    fn get_full_info(self) -> String;
}

impl Printable for User {
    fn get_full_name(self) -> String {
        return format!("{} {}", self.first_name, self.last_name);
    }

    fn get_full_info(self) -> String {
        return format!("{} {} <{}>", self.first_name, self.last_name, self.email);
    }
}

fn main() {
    let user = User {
        first_name: String::from("Another"),
        ..Default::default()
    };
    
    println!("{}", user.get_full_info());

    let fibonacci = successors(Some((1, 1)), |(prev, curr)| Some((*curr, *prev + *curr)));
    for (number, _) in fibonacci.take(10) {
        println!("{:#?}", number);
    }
}
