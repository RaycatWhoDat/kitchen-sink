use std::{fs, io};

#[allow(unused_imports)]
fn main() -> io::Result<()> {
    let mut entries = fs::read_dir(".")?
        .map(|result| result.map(|entry| entry.path()))
        .collect::<Result<Vec<_>, io::Error>>()?;

    entries.sort();
    
    for entry in entries {
        println!("{:?}", entry);
    }

    Ok(())
}
