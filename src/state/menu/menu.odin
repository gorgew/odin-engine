package menu

import rl "vendor:raylib"
import mu "lib:microui"
import "core:fmt"
import "core:strings"
import "lib:state"
import "lib:ui"
import "../../config"

enter :: proc() {
    load_assets()
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
    state.top_state_table[state.State.Menu] = {enter, exit, tick, draw, draw_ui}
}

@(private)
draw_menu :: proc(ctx: ^mu.Context) {
    @static opts := mu.Options{.NO_CLOSE, .NO_RESIZE}
    if mu.window(ctx, "Demo Window", ui.center(ui.from_node(ui.TopLeftCornerNode(), ui.BottomMidpointNode()), ui.CentralNode()), opts) {
        mu.layout_row(ctx, {86, -110, -1})
        mu.label(ctx, "New Game:")
        if .SUBMIT in mu.button(ctx, "New Game") { state.transition(state.State.Game)  }

        mu.layout_row(ctx, {-1}, 100)
        mu.image(ctx, &textures[texture.gabe_run], opts)
    }
    
}

@(private)
texture :: enum {
    gabe_run,
}

@(private) textures := [len(texture)]rl.Texture2D{}

@(private)
load_assets :: proc() {
    load_textures()
}

@(private)
load_textures :: proc() {
    for tex in texture {
        str := get_path( "assets/", tex, ".png")
        fmt.println("Loaded texture at ", str)
        path := strings.clone_to_cstring(str)
        textures[tex] = rl.LoadTexture(path)
    }
}

@(private)
get_path :: proc(args: ..any) -> string {
    return fmt.aprint(args=args, sep="")
}
