#[no_mangle]
pub extern fn add(num1: f32, num2: f32) -> f32 { num1 + num2 }

#[no_mangle]
pub extern fn subtract(num1: f32, num2: f32) -> f32 { num1 - num2 }

#[no_mangle]
pub extern fn multiply(num1: f32, num2: f32) -> f32 { num1 * num2 }

#[no_mangle]
pub extern fn divide(num1: f32, num2: f32) -> f32 { num1 / num2 }

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
