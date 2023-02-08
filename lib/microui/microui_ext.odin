package microui

image :: proc(ctx: ^Context, texture: rawptr, opt: Options = {.ALIGN_CENTER}) -> (res: Result_Set) {
	id := get_id(ctx, uintptr(texture))
	r := layout_next(ctx)
	/* draw */
	//draw_control_frame(ctx, id, r, .BUTTON, opt)
	if texture != nil {
		
	}
    draw_image(ctx, texture, r)
	return
}

draw_image :: proc(ctx: ^Context, texture: rawptr, rect: Rect) {
	/* do clip command if the rect isn't fully contained within the cliprect */
	clipped := check_clip(ctx, rect)
	switch clipped {
	case .NONE: // okay
	case .ALL:  return
	case .PART: set_clip(ctx, get_clip_rect(ctx))
	}
	/* do icon command */
	cmd := push_command(ctx, Command_Image)
	cmd.texture = texture
	cmd.src = Rect{-1, -1, -1, -1}
	cmd.dest = rect
	/* reset clipping if it was set */
	if clipped != .NONE {
		set_clip(ctx, unclipped_rect)
	}
}

@private
scale_widths :: proc(ctx: ^Context, widths: []f32) -> [dynamic]i32 {
    sum : f32 = 0.0
    for width in widths {
        if width < 0.0 {
            assert(false, "relative width must be positive")
        }
        sum = sum + width
    }
    assert(sum == 1.0, "widths must sum to 1.0")

    container_width := f32(get_current_container(ctx).rect.w)

    scaled_widths : [dynamic]i32
    for i := 0; i < len(widths); i = i + 1 {
        append(&scaled_widths, i32(container_width * widths[i]))
    }

    return scaled_widths
}

@private
scale_height :: proc(ctx: ^Context, height: f32) -> i32 {

    assert(height >= 0.0 && height <= 1.0, "height must be between 0.0 and 1.0")
    
    container_height := f32(get_current_container(ctx).rect.h)
    scaled_height := i32(container_height * height)
    return scaled_height
}

layout_row_relative :: proc(ctx: ^Context, widths: []f32, height: i32 = 0) {
    
	layout := get_layout(ctx)
	items := len(widths)
    scaled_widths := scale_widths(ctx, widths)
    
	if len(widths) > 0 {
		items = copy(layout.widths[:], scaled_widths[:])
	}
	layout.items = i32(items)
	layout.position = Vec2{layout.indent, layout.next_row}
	layout.size.y = height
	layout.item_index = 0
}

layout_height_relative :: proc(ctx: ^Context, widths: []i32, height: f32) {
    
	layout := get_layout(ctx)
	items := len(widths)
    
	if len(widths) > 0 {
		items = copy(layout.widths[:], widths[:])
	}
	layout.items = i32(items)
	layout.position = Vec2{layout.indent, layout.next_row}
	layout.size.y = scale_height(ctx, height)
	layout.item_index = 0
}

