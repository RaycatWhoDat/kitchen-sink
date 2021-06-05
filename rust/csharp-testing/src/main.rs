enum UserType {
    Guest,
    Customer,
    Admin
}

struct User<'a> {
    name: String,
    r#type: &'a UserType
}

fn main() {
    let all_users = [
        ("Adam", UserType::Guest),
        ("Ben", UserType::Customer),
        ("Charlie", UserType::Admin)
    ];

    for (user_name, user_type) in all_users.iter() {
        let user = User {
            name: user_name.to_string(),
            r#type: user_type
        };
        
        println!("{}", user.name);
    }
}
