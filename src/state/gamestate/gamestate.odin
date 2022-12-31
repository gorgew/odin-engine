package gamestate

import rl "vendor:raylib"
import "../"
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

    //rl.ClearBackground(rl.RAYWHITE)
    rl.DrawText("Congrats! You created your first window!", 190, 200, 20, rl.LIGHTGRAY)
    rl.DrawCircleV(pos, 20.0, rl.MAGENTA)
}

init :: proc() {
    state.top_state_table[state.State.Game] = {enter, exit, draw}

    game_state_table[GameState.ExploreDungeon] = {enterExploreDungeon, exitExploreDungeon, drawExploreDungeon}
}