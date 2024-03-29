package TopState
import rl "vendor:raylib"
import mu "lib:microui"
import "lib:ui"
import "lib:state"

State :: enum {
    Start,
    Menu,
    Game,
}

//Top level state transition table

top_state_table := state.get(State, state.StateProc)

//Top level state
@(private)
top_state := State.Game

init_state :: proc() {
    top_state_table[top_state].enter()
}

tick :: proc() {
    top_state_table[top_state].tick()
}

transition :: proc(state: State) {
    top_state_table[top_state].exit()
    top_state = state
    top_state_table[top_state].enter()
}

draw :: proc() {
    rl.BeginDrawing()
    @static bg_color := rl.BLUE
    rl.ClearBackground(bg_color)
    defer rl.EndDrawing()

    top_state_table[top_state].draw()
    ui.begin()
    //ui.all_windows(ui.get_ctx())
    top_state_table[top_state].draw_ui(ui.get_ctx())
    ui.end()
    ui.render()
}