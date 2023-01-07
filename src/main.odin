package main

import rl "vendor:raylib"
import "lib:ui"
import "lib:state"
import "./sys"
import "core:fmt"

main :: proc() {
    
    load_systems()
    defer close_systems()

    for !rl.WindowShouldClose()
    {
        ui.get_input()
        state.tick()
        state.draw()
    }
}