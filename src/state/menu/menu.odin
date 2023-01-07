package menu

import rl "vendor:raylib"
import mu "lib:microui"
import "../"
import "../../ui"
import "../../config"

enter :: proc() {

}

exit :: proc() {

}

draw :: proc() {

}

draw_ui :: proc(ctx: ^mu.Context) {
    ui.all_windows(ctx)
    //draw_menu( ctx)
}


tick :: proc() {
    
}

init :: proc() {
    state.top_state_table[state.State.Menu] = {enter, exit, tick, draw, draw_ui}
}

@(private)
draw_menu :: proc(ctx: ^mu.Context) {
    @static opts := mu.Options{.NO_CLOSE, .NO_RESIZE}
    if mu.window(ctx, "Demo Window", ui.center(ui.from_node(ui.TopLeftCornerNode(), ui.BottomMidpointNode()), ui.CentralNode()), opts) {
        mu.layout_row(ctx, {86, -110, -1})
        mu.label(ctx, "New Game:")
        if .SUBMIT in mu.button(ctx, "New Game") { state.transition(state.State.Game)  }
    }
    
}