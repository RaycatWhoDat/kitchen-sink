struct RandomItem {
    name: String,
    order: i32
}

fn main() {
    let numbers = [1, 2, 3, 4, 5];
    numbers.iter().cycle().take(20).for_each(| item | println!("{:?}", item));

    let fruits = ["Apple", "Banana", "Cherry", "Date", "Fig"];
    fruits.iter().cycle().take(20).for_each(| fruit | println!("{}", fruit));

    fruits.iter()
        .zip(&numbers)
        .map(| (fruit, number) | RandomItem { name: fruit.to_string(), order: *number })
        .cycle()
        .take(20)
        .for_each(| item | println!("{}: {}", item.name, item.order));
}
