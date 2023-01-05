package state
import rl "vendor:raylib"
import ui "../ui"

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

top_state_table := [len(State)]StateProc{}

//Top level state
@(private)
top_state := State.Game

init :: proc() {
    top_state_table[top_state].enter(&top_state)
}

draw :: proc() {
    rl.BeginDrawing()
    @static bg_color := rl.BLUE
    rl.ClearBackground(bg_color)
    defer rl.EndDrawing()

    top_state_table[top_state].draw()
    ui.begin()
    //ui.all_windows(ui.get_ctx())
    ui.end()
    ui.render()
}