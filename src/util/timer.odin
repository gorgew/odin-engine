package util
import rl "vendor:raylib"

Timer :: struct {
    time: f32,
}

tick :: proc(timer: ^Timer) {
    if timer.time < 0 {
        return
    }
    timer.time -= rl.GetFrameTime()
}

is_done :: proc(timer: ^Timer) -> bool {
    
    return timer.time <= 0.0
}