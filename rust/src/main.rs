use std::fs::read_dir;
use std::path::Path;

fn print_files(directory_path: &str) {
    let current_directory = if directory_path.is_empty() {
        Path::new(directory_path);
    } else {
        Path::new("./");
    };

    for entry in read_dir(current_directory)? {
        let entry = entry?;
        println!("{:?}", entry.path());
    }
}

fn main() {
    print_files("../");
}
