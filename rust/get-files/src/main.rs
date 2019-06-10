use std::io::Result;
use std::fs::read_dir;
use std::path::Path;

fn print_files(directory: &Path) -> Result<()> {
    // let ignored_paths = [
    //     ".git",
    //     "love",
    //     "target",
    //     "dist",
    //     ".dub",
    //     "node_modules"
    // ];
    
    for entry in read_dir(directory)? {
        let entry = &entry?;
        println!("{:?}", entry.path());

        if Path::new(&entry.path()).is_dir() {
            // Path::new(&entry.path()).to_str().unwrap().contains("target") {
            assert!(print_files(Path::new(&entry.path())).is_ok());
        }
    }
    Ok(())
}

fn main() {
    assert!(print_files(Path::new("../..")).is_ok());
}
