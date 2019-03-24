use std::io::Result;
use std::fs::read_dir;
use std::path::Path;

fn print_files(directory: &Path) -> Result<()> {
    if directory.is_dir() {
        for entry in read_dir(directory)? {
            let entry = entry?;
            println!("{:?}", entry.path());
        }
    }
    Ok(())
}

fn main() {
    print_files(Path::new("../"));
}
