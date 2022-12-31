package main

import rl "vendor:raylib"
import "core:fmt"

main :: proc() {
    window := create_window(screenWidth, screenHeight)
    defer close_window(&window)

    load_ui()
    defer close_ui()

    initGameState()
    
    for !rl.WindowShouldClose()
    {
        get_ui_input()
        drawState()
    }
}