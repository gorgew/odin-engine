package gamestate

import rl "vendor:raylib"
import mu "lib:microui"
import "lib:assets"
import "lib:animation"
import "lib:state"
import "core:fmt"
import "lib:ui"
import "lib:ui/demo"

CombatState :: enum {
    NewTurn,
    PlayerTurn,
    PlayerSkillSelected,
    EnemyTurn,
    SkillResolves,
    AnimationPlay,
}

Entity :: struct {
	id:   u64,
	name: string,

	variant: union{^Frog},
}

Frog :: struct {
	using entity: Entity,
	volume: f32,
	jump_height: i32,
}


new_entity :: proc($T: typeid) -> ^T {
	e := new(T)
	e.variant = e
	return e
}

blah :: proc( I: int) {
    y := I + 1
}

@(private)
enterCombat :: proc() {

}

@(private)
exitCombat :: proc() {

}

@(private)
tickCombat :: proc() {
    animation.tick(&anim)
}

@(private)
drawCombat :: proc() {
    //rl.ClearBackground(rl.RAYWHITE)
    rl.DrawText("Combat", 190, 200, 20, rl.LIGHTGRAY)

    pos := rl.Vector2{10, 10}
    rl.DrawCircleV(pos, 20.0, rl.MAGENTA)
    animation.draw_box(&anim)
    //rl.DrawTexture(textures[texture.gabe_run], 150, 400, rl.WHITE);
    //rl.DrawTexturePro()
}

drawUICombat :: proc(ctx: ^mu.Context) {
    demo.draw_menu(ctx)
}
