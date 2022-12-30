package main

import rl "vendor:raylib"
import "core:fmt"

main :: proc() {
    window := create_window(screenWidth, screenHeight)
    defer close_window(&window)

    

    initGameState()
    
    for !rl.WindowShouldClose()
    {
        drawState()
    }
}