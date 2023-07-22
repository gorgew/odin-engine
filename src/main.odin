package main

import rl "vendor:raylib"
import "lib:ui"
import "./sys"
import "./topstate"
import "core:fmt"

main :: proc() {
    
    load_systems()
    defer close_systems()

    for !rl.WindowShouldClose()
    {
        ui.get_input()
        TopState.tick()
        TopState.draw()
    }
}