use std::io::Error;
use std::io::Result;
use std::fs::read_dir;
use std::path::Path;

#[allow(unused_imports)]
fn main() -> Result<(), Error> {
    let DIRECTORY_PATH = Path::new("..");
    let mut entries = read_dir(DIRECTORY_PATH)
        .map(|res| res.map(|entry| entry.path()))
        .collect::<Result<_, Error>>();

    for entry in entries {
        println!("{}", entry);
    }
}    
