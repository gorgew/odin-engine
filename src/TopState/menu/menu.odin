package menu

import rl "vendor:raylib"
import mu "lib:microui"
import "core:fmt"
import "core:strings"
import "lib:state"
import "lib:ui"
import "../../config"
import "lib:animation"
import "../"

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
        mu.image(ctx, &textures[texture.gabe_run], opts)
        mu.layout_height_relative(ctx, {200}, 0.1)
        mu.animation(ctx, &anim, opts)
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
    add_animations()
    init_game_objects()
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

@(private)
animations := make(animation.Animation_Map)

@(private)
add_animations :: proc() {
    animation.add_from_spritesheet(&animations, "gabe_run", &textures[texture.gabe_run], .125, 1, 7, 24, 24, 7, 0.0, 0.0, true)
}

anim: animation.AnimObj

@(private)
init_game_objects :: proc() {
    anim = animation.get("gabe_run", animations, rl.Rectangle{10, 10, 100, 100})
}
