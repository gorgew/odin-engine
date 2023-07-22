package gamestate

import rl "vendor:raylib"
import mu "lib:microui"
import "core:fmt"
import "core:strings"
import "lib:state"
import "lib:animation"
import "lib:assets"
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

    init_game_objects()
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

anim: animation.AnimObj

@(private)
init_game_objects :: proc() {
    anim = animation.get("gabe_run", assets.Animations, rl.Rectangle{10, 10, 100, 100})
}

@(private)
init_game :: proc() {

}