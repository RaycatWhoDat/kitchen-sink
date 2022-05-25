pub mod types;

use types::*;

fn main() {
    let phone_number = PhoneNumber::new("847", "555-5555");
    let new_user = User::new("Ray", "Perry", "ray.perry", phone_number);
    
    println!("{:#?}", new_user);
}
