package main

State :: enum {
    Start,
    Menu,
    Game,
}

StateProc :: struct {
    enter: proc(^State),
    exit: proc(^State),
    draw: proc(),
}

//Top level state transition table
@(private)
top_state_table := [len(State)]StateProc{}

//Top level state
@(private)
top_state := State.Game

initState :: proc() {
    initGameState()
    top_state_table[top_state].enter(&top_state)
}

drawState :: proc() {
    top_state_table[top_state].draw()
}