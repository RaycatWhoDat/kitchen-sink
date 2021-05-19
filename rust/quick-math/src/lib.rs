#[no_mangle]
pub fn add(first: f32, second: f32) -> f32 { first + second }

#[no_mangle]
pub fn subtract(first: f32, second: f32) -> f32 { first - second }

#[no_mangle]
pub fn multiply(first: f32, second: f32) -> f32 { first * second }

#[no_mangle]
pub fn divide(first: f32, second: f32) -> f32 { first / second }

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_all() {
        let result = divide(subtract(multiply(add(1, 2), 3), 1), 2);
        assert_eq!(result, 4);
    }
}

/*
 (progn
    (compile "cargo build")
    (copy-file "../target/debug/libquick_math.so" "../../../txr/lib/libquick_math.so" 't))
*/
