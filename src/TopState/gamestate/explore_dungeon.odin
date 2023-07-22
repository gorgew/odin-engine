package gamestate

import rl "vendor:raylib"
import mu "lib:microui"
import "lib:animation"

@(private)
enterExploreDungeon :: proc() {

}

@(private)
exitExploreDungeon :: proc() {

}

@(private)
tickExploreDungeon :: proc() {
    animation.tick(&anim)
}

@(private)
drawExploreDungeon :: proc() {
    //rl.ClearBackground(rl.RAYWHITE)
    rl.DrawText("Congrats! You created your first window!", 190, 200, 20, rl.LIGHTGRAY)

    pos := rl.Vector2{10, 10}
    rl.DrawCircleV(pos, 20.0, rl.MAGENTA)
    animation.draw_box(&anim)
    rl.DrawTexture(textures[texture.gabe_run], 150, 400, rl.WHITE);
    //rl.DrawTexturePro()
}

@(private)
drawUIExploreDungeon :: proc(ctx: ^mu.Context) {

}
