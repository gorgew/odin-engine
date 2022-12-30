package main

import rl "vendor:raylib"

Window :: struct {
    width, height: i32,
}

create_window :: proc(width: i32, height: i32) -> Window {
    rl.InitWindow(width, height, "game")
    rl.SetTargetFPS(60)
    return Window{width, height}
}