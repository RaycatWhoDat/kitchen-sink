// (compile "cargo run ..")

use std::io;
use std::env::args;
use std::fs::read_dir;
use std::path::{Path, PathBuf};

const TWO_SPACES: usize = 2;

fn get_files(directory_path: &PathBuf, traversal_level: usize) -> io::Result<()> {
    let ignored_paths = ["node_modules", ".git", "target", "dist", "dub", "love"];

    let mut entries = read_dir(directory_path)?
        .map(|entry| entry.unwrap().path())
        .collect::<Vec<PathBuf>>();

    entries.sort();
    
    let indentation = " ".repeat(traversal_level * TWO_SPACES);
    
    for entry in entries {
        let formatted_path = entry.iter().last().unwrap();
        if ignored_paths.contains(&formatted_path.to_str().unwrap()) { continue; }
        println!("{}{:?}", indentation, formatted_path);
        if Path::new(&entry).is_dir() {
            get_files(&entry, traversal_level + 1).unwrap();
        }
    };

    Ok(())
}

fn main() -> io::Result<()> {
    let directory_path = PathBuf::from(args().last().unwrap_or(".".to_string()));
    get_files(&directory_path, 0)
}
