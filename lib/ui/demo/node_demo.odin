package demo

import "lib:assets"
import mu "lib:microui"
import "lib:ui"
import "lib:ui/node"

draw_menu :: proc(ctx: ^mu.Context) {
    @static bgOpts := mu.Options{.NO_CLOSE, .NO_RESIZE, .NO_INTERACT, .NO_TITLE}
    if mu.window(ctx, "Scaled bounds", 
        node.to_rect_aspect(node.TopLeftCornerNode(), node.BottomRightCornerNode(),
        1.0), 
        bgOpts) {}
    @static opts := mu.Options{.NO_CLOSE, .NO_RESIZE,}
    if mu.window(ctx, "Demo Window", 
            node.to_rect_aspect(
                node.center(node.TopLeftCornerNode(), node.CentralNode(), node.CentralNode()), 
            1.0),
        opts) {
    }
    sixth_node := node.Node{1.0 / 6.0, 1.0 / 6.0}
    if mu.window(ctx, "1", 
            node.to_rect_aspect(
                node.anchor_right_corner(node.TopLeftCornerNode(), sixth_node, 0, 0), 
            1.0),
        opts) {
    }
    if mu.window(ctx, "2", 
            node.to_rect_aspect(
                node.anchor_right_corner(node.TopLeftCornerNode(), sixth_node, 0, 1.0 / 6.0), 
            1.0),
        opts) {
    }
    if mu.window(ctx, "3", 
            node.to_rect_aspect(
                node.anchor_right_corner(node.TopLeftCornerNode(), sixth_node, 0, 1.0 / 3.0), 
            1.0),
        opts) {
    }
    if mu.window(ctx, "4", 
            node.to_rect_aspect(
                node.anchor_right_corner(node.TopLeftCornerNode(), sixth_node, 1.0 / 6.0, 0), 
            1.0),
        opts) {
    }
    if mu.window(ctx, "5", 
            node.to_rect_aspect(
                node.anchor_right_corner(node.TopLeftCornerNode(), sixth_node, 1.0 / 6.0, 1.0 / 6.0), 
            1.0),
        opts) {
    }
    if mu.window(ctx, "6", 
            node.to_rect_aspect(
                node.anchor_right_corner(node.TopLeftCornerNode(), sixth_node, 1.0 / 6.0, 1.0 / 3.0), 
            1.0),
        opts) {
    }
    if mu.window(ctx, "7", 
            node.to_rect_aspect(
                node.anchor_right_corner(node.TopLeftCornerNode(), sixth_node, 1.0 / 3.0, 0), 
            1.0),
        opts) {
    }
    if mu.window(ctx, "8", 
            node.to_rect_aspect(
                node.anchor_right_corner(node.TopLeftCornerNode(), sixth_node, 1.0 / 3.0, 1.0 / 6.0), 
            1.0),
        opts) {
    }
    if mu.window(ctx, "9", 
            node.to_rect_aspect(
                node.anchor_right_corner(node.TopLeftCornerNode(), sixth_node, 1.0 / 3.0, 1.0 / 3.0), 
            1.0),
        opts) {
    }
    
}

