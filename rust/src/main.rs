use std::io::Result;
use std::fs::read_dir;
use std::path::Path;

fn print_files(directory: &Path) -> Result<()> {
    for entry in read_dir(directory)? {
        let entry = entry?;
        println!("{:?}", entry.path());
        // let entryPath = Path::new(&entry);
        // if entryPath.is_dir() { print_files(entryPath); }
    }
    Ok(())
}

fn main() {
    assert!(print_files(Path::new("../")).is_ok());
}
