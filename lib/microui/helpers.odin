package microui
import rl "vendor:raylib"

mu_rect_to_rl :: proc(rect: Rect) -> rl.Rectangle {
    return rl.Rectangle{f32(rect.x), f32(rect.y), f32(rect.w), f32(rect.h)}
}

rl_rect_to_mu :: proc(rect: rl.Rectangle) -> Rect{
    return Rect{i32(rect.x), i32(rect.y), i32(rect.width), i32(rect.height)}
}
