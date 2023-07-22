package menu

import rl "vendor:raylib"
import mu "lib:microui"
import "core:fmt"
import "core:strings"
import "lib:assets"
import "lib:state"
import "lib:ui"
import "../../config"
import "lib:animation"
import "../"

enter :: proc() {
    init_game_objects()
}

exit :: proc() {

}

draw :: proc() {

}

draw_ui :: proc(ctx: ^mu.Context) {
    //ui.all_windows(ctx)
    draw_menu( ctx)
}


tick :: proc() {
    
}

init :: proc() {
    TopState.top_state_table[TopState.State.Menu] = {enter, exit, tick, draw, draw_ui}
}

@(private)
draw_menu :: proc(ctx: ^mu.Context) {
    @static opts := mu.Options{.NO_CLOSE}
    //@static opts := mu.Options{.NO_CLOSE, .NO_RESIZE}
    if mu.window(ctx, "Demo Window", ui.center(ui.from_node(ui.TopLeftCornerNode(), ui.BottomMidpointNode()), ui.CentralNode()), opts) {
        mu.layout_row(ctx, {86, -110, -1})
        mu.label(ctx, "New Game:")
        if .SUBMIT in mu.button(ctx, "New Game") { TopState.transition(TopState.State.Game)  }

        mu.layout_height_relative(ctx, {-1}, 0.1)
        mu.image(ctx, &assets.Textures[assets.Texture.gabe_run], opts)
        mu.layout_height_relative(ctx, {200}, 0.1)
        mu.animation(ctx, &anim, opts)
    }
    
}
anim: animation.AnimObj
@(private)
init_game_objects :: proc() {
    anim = animation.get("gabe_run", assets.Animations, rl.Rectangle{10, 10, 100, 100})
}
