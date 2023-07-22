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
    timer: util.Timer,
    loop: bool,
}

AnimObj :: struct {
    anim: ^Animation,
    timer: util.Timer,
    output: rl.Rectangle,
    index: int,
    done: bool,
}

Animation_Map :: map[string]Animation

get :: proc(name: string, anim_map: Animation_Map, output:= rl.Rectangle{0, 0, 100, 100}) -> AnimObj {
    assert(name in anim_map)
    anim := &anim_map[name]
    return AnimObj{
        anim,
        util.Timer{anim.frames[0].time},
        output,
        0,
        false,
    }
}

add :: proc(anim_map: ^Animation_Map, anim_name: string, 
    texture: ^rl.Texture2D, frames: []Frame, loop := false) {
    
    assert(anim_map != nil)
    assert(texture != nil)
    assert(frames != nil)

    anim_map[anim_name] = Animation{texture, frames, util.Timer{frames[0].time}, loop}
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

draw_box :: proc(anim: ^AnimObj) {
    source := anim.anim.frames[anim.index].texcoords
    rl.DrawTexturePro(anim.anim.texture^, source, anim.output, rl.Vector2{0, 0}, 0.0, rl.WHITE)
}

tick :: proc(anim: ^AnimObj) {
    if anim.done {
        return;
    }

    util.tick(&anim.timer)
    if util.is_done(&anim.timer) {
        anim.index = anim.index + 1
        anim.timer.time = anim.anim.frames[anim.index].time
        check_done(anim)
    }
}

@(private)
check_done :: proc(anim: ^AnimObj) {
    if anim.index != len(anim.anim.frames) - 1{
        return
    }
    
    if anim.anim.loop {
        anim.index = 0
    }
    else {
        anim.done = true
    }
}