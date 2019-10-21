module main

[live]
fn print_messages() {
    areas := ['game', 'web', 'tools', 'science', 'systems', 'embedded', 'drivers', 'GUI', 'mobile']
    for area in areas {
      println('Hello, $area developers!')
    }
}

fn main() {
   print_messages()
}	
