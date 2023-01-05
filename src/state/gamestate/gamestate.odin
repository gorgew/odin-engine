package gamestate

import rl "vendor:raylib"
import "core:fmt"
import "core:strings"
import "../"
import "../../animation"

GameState :: enum {
    ExploreDungeon,
    Combat,
}

GameStateProc :: struct {
    enter: proc(^GameState),
    exit: proc(^GameState),
    draw: proc(),
    add_ui: proc(),
}

@(private)
game_state_table := [len(GameState)]state.StateProc{}

@(private)
game_state := GameState.ExploreDungeon

enter :: proc(state : ^state.State) {
    game_state = GameState.ExploreDungeon
    game_state_table[game_state].enter(state)

    load_assets()
}

exit :: proc(^state.State) {

}

draw :: proc() {
    game_state_table[game_state].draw()
}

enterExploreDungeon :: proc(^state.State) {

}

exitExploreDungeon :: proc(^state.State) {

}

pos := rl.Vector2{10, 10}

drawExploreDungeon :: proc() {

    animation.tick(&anim.animation)

    //rl.ClearBackground(rl.RAYWHITE)
    rl.DrawText("Congrats! You created your first window!", 190, 200, 20, rl.LIGHTGRAY)
    rl.DrawCircleV(pos, 20.0, rl.MAGENTA)
    animation.draw_box(&anim)
    rl.DrawTexture(textures[texture.gabe_run], 150, 400, rl.WHITE);
    //rl.DrawTexturePro()
}

init :: proc() {
    state.top_state_table[state.State.Game] = {enter, exit, draw}

    game_state_table[GameState.ExploreDungeon] = {enterExploreDungeon, exitExploreDungeon, drawExploreDungeon}
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
    animation.add_from_spritesheet(&animations, "gabe_run", &textures[texture.gabe_run], .5, 1, 7, 24, 24, 7, 0.0, 0.0, true)
}

anim: animation.Box

@(private)
init_game_objects :: proc() {
    anim = animation.Box{animations["gabe_run"], rl.Rectangle{10, 10, 100, 100}}
}