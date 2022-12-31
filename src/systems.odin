package main
import "./ui"
import "./window"
import "./state"
import "./state/gamestate"

load_systems :: proc() {
    window.create(screenWidth, screenHeight)
    ui.load()
    load_states()
    state.init()
}

close_systems :: proc() {
    window.close()
    ui.close()
}

@(private)
load_states :: proc() {
    gamestate.init()
}