import ui

const window_width = 200
const window_height = 40

@[heap]
struct App {
    mut:
    counter string = "0"
}

fn main() {
    mut app := &App{}
    window := ui.window(
        width: window_width
        height: window_height
        title: "GUI testing"
        layout: ui.row(
            spacing: 5
            margin_: 10
            widths: ui.stretch
            heights: ui.stretch
            children: [
                ui.textbox(
                    max_len: 20
                    read_only: true
                    is_numeric: true
                    text: &app.counter
                ),
                ui.button(
                    text: "Click me!"
                    on_click: app.btn_click
                )
            ]
        )
    )
    ui.run(window)
}

fn (mut app App) btn_click(btn &ui.Button) {
    app.counter = (app.counter.int() + 1).str()
}
