use macroquad::prelude::*;

fn conf() -> Conf {
    Conf {
        window_title: String::from("Macroquad Testing"),
        window_width: 1260,
        window_height: 768,
        fullscreen: false,
        ..Default::default()
    }
}

fn update(_dt: &f32) {}

fn draw() {
    clear_background(BLACK);
    
    draw_line(40.0, 40.0, 100.0, 200.0, 2.0, BLUE);
    draw_rectangle(screen_width() / 2.0 - 60.0, 100.0, 120.0, 60.0, GREEN);
    draw_circle(screen_width() - 30.0, screen_height() - 30.0, 15.0, YELLOW);
    draw_text("Hello, Macroquad!", 20.0, 20.0, 30.0, DARKGRAY);
}

#[macroquad::main(conf)]
async fn main() {
    loop {
        let dt = get_frame_time();

        if is_key_pressed(KeyCode::Escape) { break }
        
        update(&dt);
        draw();

        next_frame().await
    }
}
