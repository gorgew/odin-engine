package node

import rl "vendor:raylib"
import mu "lib:microui"
Node :: struct {
    x, y: f32,
}

SIXTEEN_BY_NINE :: 16.0 / 9.0

TopLeftCornerNode :: proc() -> Node {
    return Node{0, 0}
}

BottomLeftCornerNode :: proc() -> Node {
    return Node{0, 1.0} 
}

TopRightCornerNode :: proc() -> Node {
    return Node{1.0, 0}
}

BottomRightCornerNode :: proc() -> Node {
    return Node{1.0, 1.0}
}

CentralNode :: proc() -> Node {
    return Node {0.5, 0.5}
}

TopMidpointNode :: proc() -> Node {
    return Node {0.5, 0}
}

BottomMidpointNode :: proc() -> Node {
    return Node {0.5, 1.0}
}

LeftMidpointNode :: proc() -> Node {
    return Node {0, 0.5}
}

RightMidpointNode :: proc() -> Node {
    return Node {1.0, 0.5}
}

to_rect :: proc(top_left: Node, bottom_right: Node) -> mu.Rect {
    scaled_top_left_x := i32(f32(get_screen_width()) * top_left.x)
    scaled_top_left_y := i32(f32(get_screen_height()) * top_left.y)
    scaled_bottom_right_x  := i32(f32(get_screen_width()) * bottom_right.x)
    scaled_bottom_right_y := i32(f32(get_screen_height()) * bottom_right.y)
    return mu.Rect{scaled_top_left_x, 
        scaled_top_left_y, 
        scaled_bottom_right_x - scaled_top_left_x, 
        scaled_bottom_right_y - scaled_top_left_y}
}

//Scale based off of height
to_rect_aspect :: proc(top_left: Node, bottom_right: Node, aspect: f32) -> mu.Rect {
    screen_height := f32(get_screen_height())
    screen_width := f32(get_screen_width())
    curr_ratio := screen_width / screen_height

    scaled_screen : mu.Rect
    if (curr_ratio > aspect) {
        scaled_width := aspect * screen_height
        scaled_screen =  mu.Rect{
            x = i32((screen_width - scaled_width) / 2.0),
            y = 0,
            w = i32(scaled_width),
            h = i32(screen_height),
        }
    }
    else {
        scaled_height := screen_width / aspect
        scaled_screen = mu.Rect{
            x = 0.0,
            y = i32((screen_height - scaled_height) / 2.0),
            w = i32(screen_width),
            h = i32(scaled_height),
        }
    }

    node_width := get_node_pair_width(top_left, bottom_right)
    node_height := get_node_pair_height(top_left, bottom_right)

    return mu.Rect{
        x = i32(top_left.x * f32(scaled_screen.w) + f32(scaled_screen.x)),
        y = i32(top_left.y * f32(scaled_screen.h) + f32(scaled_screen.y)),
        w = i32(f32(scaled_screen.w) * node_width),
        h = i32(f32(scaled_screen.h) * node_height),
    }
}

center :: proc (top_left: Node, bottom_right: Node, center: Node) -> (Node, Node) {
    width := get_node_pair_width(top_left, bottom_right)
    height := get_node_pair_height(top_left, bottom_right)

    return Node{
                center.x - width / 2.0,
                center.y - height / 2.0,
            }, 
            Node{
                center.x + width / 2.0,
                center.y + height / 2.0,
            }
}

anchor_right_corner :: proc(top_left: Node, bottom_right: Node, x: f32, y: f32) -> (Node, Node) {
    width := get_node_pair_width(top_left, bottom_right)
    height := get_node_pair_height(top_left, bottom_right)

    return Node{
                x, 
                y,
            },
            Node {
                x + width,
                y + width,
            }
}

midpoint :: proc (n1: Node, n2: Node) -> Node {
    x := (n1.x + n2.x) / 2
    y := (n2.y + n2.y) / 2
    return Node{x, y}
}

scale :: proc(n: Node, scale: f32) -> Node {
    return Node{scale * n.x, scale * n.y}
}

get_screen_height :: proc() -> i32 {
    return rl.GetScreenHeight()
}

get_screen_width :: proc() -> i32 {
    return rl.GetScreenWidth()
}

get_node_pair_width :: proc(top_left: Node, bottom_right: Node) -> f32 {
    return  bottom_right.x - top_left.x
}

get_node_pair_height :: proc(top_left: Node, bottom_right: Node) -> f32 {
    return  bottom_right.y - top_left.y
}