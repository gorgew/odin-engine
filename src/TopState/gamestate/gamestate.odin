package gamestate

import rl "vendor:raylib"
import mu "lib:microui"
import "core:fmt"
import "core:strings"
import "lib:state"
import "lib:animation"
import "../"

GameState :: enum {
    ExploreDungeon,
    Combat,
}

GameStateProc :: struct {
    enter: proc(),
    exit: proc(),
    tick: proc(),
    draw: proc(),
    draw_ui: proc(),
}

@(private)
game_state_table := state.get(GameState, state.StateProc)

@(private)
game_state := GameState.ExploreDungeon

enter :: proc() {
    game_state = GameState.ExploreDungeon
    game_state_table[game_state].enter()

    load_assets()
    init_game()
}

exit :: proc() {

}

draw :: proc() {
    game_state_table[game_state].draw()
}

draw_ui :: proc(ctx: ^mu.Context) {
    
}

tick :: proc() {
    game_state_table[game_state].tick()
}

init :: proc() {
    state.get(TopState.State, state.StateProc)[TopState.State.Game] = {enter, exit, tick, draw, draw_ui}

    game_state_table[GameState.ExploreDungeon] = {enterExploreDungeon, exitExploreDungeon, tickExploreDungeon, drawExploreDungeon, drawUIExploreDungeon}
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

init_game :: proc() {

}