struct User {
    first_name: String,
    last_name: String,
    email: String
}

impl User {
    fn get_full_name(&self) -> String {
        format!("{} {}", &self.first_name, &self.last_name)
    }
    
    fn get_email(&self) -> &str {
        &self.email
    }
}

fn main() {
    let first_name = "New".to_string();
    let last_name = "User".to_string();
    let email = "newuser@gmail.com".to_string();
    
    let new_user = User {
        first_name,
        last_name,
        email
    };

    println!("{}", new_user.get_full_name());
    println!("{}", new_user.get_email());
}
