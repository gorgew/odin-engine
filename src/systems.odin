package main

import "./config"
import "lib:ui"
import "lib:window"
import "lib:state"
import "./topstate/gamestate"
import "./topstate/menu"
import "./topstate"

load_systems :: proc() {
    window.create(config.screenWidth, config.screenHeight)
    ui.load()
    load_states()
    TopState.init_state()
}

close_systems :: proc() {
    window.close()
    ui.close()
}

load_states :: proc() {
    menu.init()
    gamestate.init()
}