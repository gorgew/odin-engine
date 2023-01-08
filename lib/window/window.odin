package window

import rl "vendor:raylib"

Window :: struct {
    width, height: i32,
}

window : Window

create:: proc(width: i32, height: i32) {
    rl.SetConfigFlags({.WINDOW_RESIZABLE})
    rl.InitWindow(width, height, "game")
    rl.SetTargetFPS(60)
    
    window = Window{width, height}
}

close:: proc() {
    rl.CloseWindow();
}