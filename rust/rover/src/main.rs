use std::collections::HashMap;

struct Grid {
    width: isize,
    height: isize,
}

#[derive(Debug, Hash, PartialEq, Eq)]
enum Direction {
    North,
    East,
    South,
    West
}

struct Rover {
    x_coordinate: isize,
    y_coordinate: isize,
    direction: Direction
}

fn make_grid(width: isize, height: isize) -> Grid {
    Grid { width, height }
}

impl Rover {
    fn get_current_position(&self) -> String {
        println!("Currently at {} {} facing {:?}...", self.x_coordinate, self.y_coordinate, self.direction);
        format!("{} {} {:?}", self.x_coordinate, self.y_coordinate, self.direction)
    }
    fn set_starting_position(&mut self, grid: &Grid, x_position: isize, y_position: isize, direction: Direction) {
        if x_position < 0 || x_position > grid.width || y_position < 0 || y_position > grid.height {
            self.x_coordinate = 0;
            self.y_coordinate = 0;
        } else {
            self.x_coordinate = x_position;
            self.y_coordinate = y_position;
        }

        self.direction = direction;
    }
    fn parse_instructions(&mut self, grid: &Grid, instructions: String) {
        let headings: HashMap<Direction, [isize; 2]> = HashMap::from([
            (Direction::North, [0, -1]),
            (Direction::East, [1, 0]),
            (Direction::South, [0, 1]),
            (Direction::West, [-1, 0])
        ]);
        
        for character in instructions.chars() {
            match character {
                'M' => {
                    let [x_delta, y_delta] = headings.get(&self.direction).unwrap();
                    let new_x_position = self.x_coordinate + x_delta;
                    let new_y_position = self.y_coordinate + y_delta;

                    if new_x_position >= 0 && new_x_position <= grid.height && new_y_position >= 0 && new_y_position <= grid.width {
                        println!("Moving forward...");
                        self.x_coordinate = new_x_position;
                        self.y_coordinate = new_y_position;
                    } 
                },
                'L' => {
                    println!("Turning left...");
                    self.direction = match self.direction {
                        Direction::North => Direction::West,
                        Direction::East => Direction::North,
                        Direction::South => Direction::East,
                        Direction::West => Direction::South
                    }
                },
                'R' => {
                    println!("Turning right...");
                    self.direction = match self.direction {
                        Direction::North => Direction::East,
                        Direction::East => Direction::South,
                        Direction::South => Direction::West,
                        Direction::West => Direction::North
                    }
                },
                _ => continue
            }
        }
    }
}

fn main() {
    let grid = make_grid(5, 5);
    let mut rover = Rover { x_coordinate: 0, y_coordinate: 0, direction: Direction::North };
    rover.set_starting_position(&grid, 1, 1, Direction::North);
    rover.get_current_position();
    rover.parse_instructions(&grid, String::from("LMLMLMLMM"));
    rover.get_current_position();
}
