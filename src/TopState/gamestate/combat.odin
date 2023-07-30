package gamestate

import rl "vendor:raylib"
import mu "lib:microui"
import "lib:assets"
import "lib:animation"
import "lib:state"
import "core:fmt"
import "lib:ui"
import "lib:ui/demo"
import "lib:ui/node"

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
    drawBG(ctx)
    drawTurnBar(ctx)
    drawProfile(ctx)
    drawSkillBar(ctx)
    drawCharacters(ctx)
}

drawBG :: proc(ctx: ^mu.Context) {
    @static bgOpts := mu.Options{.NO_CLOSE, .NO_RESIZE, .NO_INTERACT, .NO_TITLE}
    if mu.window(ctx, "Scaled bounds", 
        node.to_rect_aspect(node.TopLeftCornerNode(), node.BottomRightCornerNode(),
    node.SIXTEEN_BY_NINE), 
    bgOpts) {}
}
drawTurnBar :: proc(ctx: ^mu.Context) {
    @static opts := mu.Options{.NO_CLOSE, .NO_RESIZE,.NO_TITLE}
    @static top_left := node.Node{0.0, 0.0}
    @static bot_right := node.Node{0.66, 0.1}
    @static center := node.Node{0.5, 0.1}
    if mu.window(ctx, "TurnBar", 
            node.to_rect_aspect(
                node.center(top_left, bot_right, center), 
            node.SIXTEEN_BY_NINE),
        opts) {
    }
}

drawProfile :: proc(ctx: ^mu.Context) {
    @static opts := mu.Options{.NO_CLOSE, .NO_RESIZE,.NO_TITLE}
    @static top_left := node.Node{0.0, 0.0}
    @static bot_right := node.Node{2.5 / 16.0, 2.5 / 9.0}
    @static center := node.Node{0.2, 0.85}
    if mu.window(ctx, "Profile", 
            node.to_rect_aspect(
                node.center(top_left, bot_right, center), 
            node.SIXTEEN_BY_NINE),
        opts) {
    }
}

drawSkillBar :: proc(ctx: ^mu.Context) {
    @static opts := mu.Options{.NO_CLOSE, .NO_RESIZE,.NO_TITLE}
    @static top_left := node.Node{0.0, 0.0}
    @static bot_right := node.Node{0.4, 0.2}
    @static center := node.Node{0.5, 0.9}
    if mu.window(ctx, "SkillBar", 
            node.to_rect_aspect(
                node.center(top_left, bot_right, center), 
            node.SIXTEEN_BY_NINE),
        opts) {
    }
}

drawCharacters :: proc(ctx: ^mu.Context) {
    @static opts := mu.Options{.NO_CLOSE, .NO_RESIZE}
    @static top_left := node.Node{0.0, 0.0}
    @static bot_right := node.Node{2.0 / 16.0, 2.0 / 9.0}
    col1 :: 0.4
    col2 :: 0.25
    col3 :: 0.6
    col4 :: 0.75
    row1 :: 0.3
    row2 :: 0.6
    @static center1 := node.Node{col1, row1}
    if mu.window(ctx, "Character1", 
            node.to_rect_aspect(
                node.center(top_left, bot_right, center1), 
            node.SIXTEEN_BY_NINE),
        opts) {
    }
    @static center2 := node.Node{col1, row2}
    if mu.window(ctx, "Character2", 
            node.to_rect_aspect(
                node.center(top_left, bot_right, center2), 
            node.SIXTEEN_BY_NINE),
        opts) {
    }
    @static center3 := node.Node{col2, row2}
    if mu.window(ctx, "Character3", 
            node.to_rect_aspect(
                node.center(top_left, bot_right, center3), 
            node.SIXTEEN_BY_NINE),
        opts) {
    }
    @static center4 := node.Node{col2, row1}
    if mu.window(ctx, "Character4", 
            node.to_rect_aspect(
                node.center(top_left, bot_right, center4), 
            node.SIXTEEN_BY_NINE),
        opts) {
    }
    @static center5 := node.Node{col3, row1}
    if mu.window(ctx, "Enemy1", 
            node.to_rect_aspect(
                node.center(top_left, bot_right, center5), 
            node.SIXTEEN_BY_NINE),
        opts) {
    }
    @static center6 := node.Node{col3, row2}
    if mu.window(ctx, "Enemy2", 
            node.to_rect_aspect(
                node.center(top_left, bot_right, center6), 
            node.SIXTEEN_BY_NINE),
        opts) {
    }
    @static center7 := node.Node{col4, row2}
    if mu.window(ctx, "Enemy3", 
            node.to_rect_aspect(
                node.center(top_left, bot_right, center7), 
            node.SIXTEEN_BY_NINE),
        opts) {
    }
    @static center8 := node.Node{col4, row1}
    if mu.window(ctx, "Enemy4", 
            node.to_rect_aspect(
                node.center(top_left, bot_right, center8), 
            node.SIXTEEN_BY_NINE),
        opts) {
    }
}
