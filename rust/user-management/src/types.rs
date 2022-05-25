#[allow(dead_code)]
#[derive(Clone, Debug)]
pub struct PhoneNumber {
    area_code: String,
    number: String
}

impl PhoneNumber {
    pub fn new(area_code: &str, number: &str) -> Self {
        PhoneNumber {
            area_code: area_code.to_string(),
            number: number.to_string()
        }
    }
}

#[derive(Debug)]
pub struct User {
    pub user_name: String,
    pub first_name: String,
    pub last_name: String,
    pub phone_number: PhoneNumber
}

impl User {
    pub fn new(first_name: &str, last_name: &str, user_name: &str, phone_number: PhoneNumber) -> Self {
        User {
            first_name: first_name.to_string(),
            last_name: last_name.to_string(),
            user_name: user_name.to_string(),
            phone_number
        }
    }
}
