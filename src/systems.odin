package main

import "./config"
import "./ui"
import "./window"
import "./state"
import "./state/gamestate"
import "./state/menu"

load_systems :: proc() {
    window.create(config.screenWidth, config.screenHeight)
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
    menu.init()
    gamestate.init()
}