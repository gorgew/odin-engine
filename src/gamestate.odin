package main

import rl "vendor:raylib"

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
game_state_table := [len(GameState)]StateProc{}

@(private)
game_state := GameState.ExploreDungeon

enterGameState :: proc(state : ^State) {
    game_state = GameState.ExploreDungeon
    game_state_table[game_state].enter(state)
}

exitGameState :: proc(^State) {

}

drawGameState :: proc() {
    game_state_table[game_state].draw()
}

enterExploreDungeon :: proc(^State) {

}

exitExploreDungeon :: proc(^State) {

}

pos := rl.Vector2{10, 10}
drawExploreDungeon :: proc() {

    //rl.ClearBackground(rl.RAYWHITE)
    rl.DrawText("Congrats! You created your first window!", 190, 200, 20, rl.LIGHTGRAY)
    rl.DrawCircleV(pos, 20.0, rl.MAGENTA)
}

initGameState :: proc() {
    top_state_table[State.Game] = {enterGameState, exitGameState, drawGameState}

    game_state_table[GameState.ExploreDungeon] = {enterExploreDungeon, exitExploreDungeon, drawExploreDungeon}
}