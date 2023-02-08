package animation

import rl "vendor:raylib"
import "lib:util"

/*
For 2d animations

*/


Frame :: struct {   
    time: f32,
    texcoords: rl.Rectangle,
}

Animation :: struct {
    texture: ^rl.Texture2D,
    frames: []Frame,
    index: int,
    timer: util.Timer,
    loop: bool,
    done: bool,
}

Box :: struct {
    animation: Animation,
    output: rl.Rectangle,
}

Animation_Map :: map[string]Animation

add :: proc(anim_map: ^Animation_Map, anim_name: string, 
    texture: ^rl.Texture2D, frames: []Frame, loop := false) {
    
    assert(anim_map != nil)
    assert(texture != nil)
    assert(frames != nil)

    anim_map[anim_name] = Animation{texture, frames, 0, util.Timer{frames[0].time}, loop, false}
}

add_from_spritesheet :: proc(anim_map: ^Animation_Map, anim_name: string, 
    texture: ^rl.Texture2D, frame_time: f32, rows: int, columns: int, x: int, y: int, frame_count: int, 
    offset_x : f32 = 0.0, offset_y : f32 = 0.0, loop := false) {

        offset := rl.Vector2{offset_x, offset_y}
        frames: [dynamic]Frame

        for i := 0; i < frame_count; i = i + 1 {
            offset.x += cast(f32) x
            check_next_row(texture, columns, &offset, x, y)
            append(&frames, Frame{frame_time, rl.Rectangle{offset.x, offset.y, cast(f32)x, cast(f32)y}})
        }

        add(anim_map, anim_name, texture, frames[:], loop)
    }

@(private) 
check_next_row :: proc(texture: ^rl.Texture2D, columns: int, offset: ^rl.Vector2, x: int, y: int) {
    if offset.x >= cast(f32) texture.width {
        offset.x = 0
        offset.y += cast(f32) y
    }
}

draw :: proc(animation: ^Animation, output_box: rl.Rectangle) {
    source := animation.frames[animation.index].texcoords
    rl.DrawTexturePro(animation.texture^, source, output_box, rl.Vector2{0, 0}, 0.0, rl.WHITE)
}

draw_box :: proc(box: ^Box) {
    draw(&box.animation, box.output)
}

tick :: proc(animation: ^Animation) {
    if animation.done {
        return;
    }

    util.tick(&animation.timer)
    if util.is_done(&animation.timer) {
        animation.index = animation.index + 1
        animation.timer.time = animation.frames[animation.index].time
        check_done(animation)
    }
}

@(private)
check_done :: proc(animation: ^Animation) {
    if animation.index != len(animation.frames) - 1{
        return
    }
    
    if animation.loop {
        animation.index = 0
    }
    else {
        animation.done = true
    }
}