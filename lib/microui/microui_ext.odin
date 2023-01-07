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
	cmd.rect = rect
	/* reset clipping if it was set */
	if clipped != .NONE {
		set_clip(ctx, unclipped_rect)
	}
}