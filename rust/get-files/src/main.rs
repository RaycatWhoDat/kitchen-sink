// (compile "cargo run ..")

use std::env::args;
use std::fs::read_dir;
use std::io::Result;
use std::path::{Path, PathBuf};
use std::string::String;

const TWO_SPACES: usize = 2;

fn get_files(
    directory_path: &PathBuf,
    callback: &dyn Fn(&String, &str) -> (),
    traversal_level: usize,
) -> Result<()> {
    let ignored_paths = ["node_modules", ".git", "target", "dist", "dub", "love"];

    let mut entries = read_dir(directory_path)?
        .map(|entry| entry.unwrap().path())
        .collect::<Vec<_>>();

    entries.sort();

    let indentation = " ".repeat(traversal_level * TWO_SPACES);

    for entry in entries {
        let last_path_component = entry.iter().last().unwrap();
        let formatted_path = last_path_component.to_str().unwrap();

        if ignored_paths.contains(&formatted_path) { continue; }

        callback(&indentation, formatted_path);

        if Path::new(&entry).is_dir() {
            get_files(&entry, callback, traversal_level + 1).ok();
        }
    }

    Ok(())
}

fn main() -> Result<()> {
    let directory_path = PathBuf::from(args().last().unwrap_or(".".to_string()));
    let print_item = |indentation: &String, item: &str| println!("{}{}", indentation, item);

    get_files(&directory_path, &print_item, 0)
}
