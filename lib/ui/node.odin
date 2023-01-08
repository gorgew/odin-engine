package ui

import rl "vendor:raylib"
import mu "lib:microui"
Node :: struct {
    x, y: i32,
}

get_screen_height :: proc() -> i32 {
    return rl.GetScreenHeight()
}

get_screen_width :: proc() -> i32 {
    return rl.GetScreenWidth()
}

TopLeftCornerNode :: proc() -> Node {
    return Node{0, 0}
}

BottomLeftCornerNode :: proc() -> Node {
    return Node{0, get_screen_height()}
}

TopRightCornerNode :: proc() -> Node {
    return Node{get_screen_width(), 0}
}

BottomRightCornerNode :: proc() -> Node {
    return Node{get_screen_width(), get_screen_height()}
}

CentralNode :: proc() -> Node {
    return Node {get_screen_width() / 2, get_screen_height() / 2}
}

TopMidpointNode :: proc() -> Node {
    return Node {get_screen_width() / 2, 0}
}

BottomMidpointNode :: proc() -> Node {
    return Node {get_screen_width() / 2, get_screen_height()}
}

LeftMidpointNode :: proc() -> Node {
    return Node {0, get_screen_height() / 2}
}

RightMidpointNode :: proc() -> Node {
    return Node {get_screen_width(), get_screen_height() / 2}
}

from_node :: proc(top_left: Node, bottom_right: Node) -> mu.Rect {
    return mu.Rect{top_left.x, top_left.y, bottom_right.x - top_left.x, bottom_right.y - top_left.y}
}

center :: proc (rect: mu.Rect, node: Node) -> mu.Rect {
    x := node.x - rect.w / 2
    y := node.y - rect.h / 2
    return mu.Rect{x, y, rect.w, rect.h}
}

midpoint :: proc (n1: Node, n2: Node) -> Node {
    x := (n1.x + n2.x) / 2
    y := (n2.y + n2.y) / 2
    return Node{x, y}
}
