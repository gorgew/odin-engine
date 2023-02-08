package util
import rl "vendor:raylib"
import mu "lib:microui"

mu_rect_to_rl :: proc(rect: mu.Rect) -> rl.Rectangle {
    return rl.Rectangle{f32(rect.x), f32(rect.y), f32(rect.w), f32(rect.h)}
}
