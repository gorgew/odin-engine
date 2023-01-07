//Adapted from Ginger Bill: https://gist.github.com/gingerBill/c7a91318bd7b3be96d63d428b24d19ea
package ui

import "core:fmt"
import "core:unicode/utf8"
import rl "vendor:raylib"
import mu "lib:microui"

@(private)
state := struct {
	mu_ctx: mu.Context,
	log_buf:         [1<<16]byte,
	log_buf_len:     int,
	log_buf_updated: bool,
	bg: mu.Color,
	
	atlas_texture: rl.Texture2D,
}{
	bg = {90, 95, 100, 255},
}


@(private) pixels : [][4]u8
@(private) ctx : ^mu.Context

load :: proc() {
    set_pixel_alpha()
    load_mu_tex()

    ctx = &state.mu_ctx
    load_context()
}

close :: proc() {
    delete(pixels)
    rl.UnloadTexture(state.atlas_texture)
}

begin :: proc() {
    mu.begin(ctx)
}

end :: proc() {
    mu.end(ctx)
}

@(private)
text_input :: proc() {
    text_input: [512]byte = ---
        text_input_offset := 0
        for text_input_offset < len(text_input) {
            ch := rl.GetCharPressed()
            if ch == 0 {
                break
            }
            b, w := utf8.encode_rune(ch)
            copy(text_input[text_input_offset:], b[:w])
            text_input_offset += w
        }
        mu.input_text(ctx, string(text_input[:text_input_offset]))
}

@(private)
mouse_input :: proc() {
    // mouse coordinates
    mouse_pos := [2]i32{rl.GetMouseX(), rl.GetMouseY()}
    mu.input_mouse_move(ctx, mouse_pos.x, mouse_pos.y)
    mu.input_scroll(ctx, 0, i32(rl.GetMouseWheelMove() * -30))
    
    // mouse buttons
    @static buttons_to_key := [?]struct{
        rl_button: rl.MouseButton,
        mu_button: mu.Mouse,
    }{
        {.LEFT, .LEFT},
        {.RIGHT, .RIGHT},
        {.MIDDLE, .MIDDLE},
    }
    for button in buttons_to_key {
        if rl.IsMouseButtonPressed(button.rl_button) { 
            mu.input_mouse_down(ctx, mouse_pos.x, mouse_pos.y, button.mu_button)
        } else if rl.IsMouseButtonReleased(button.rl_button) { 
            mu.input_mouse_up(ctx, mouse_pos.x, mouse_pos.y, button.mu_button)
        }
        
    }
}

get_input :: proc() {
    text_input()
    mouse_input()
    keyboard_input()
}

get_ctx :: proc() -> ^mu.Context {
    return ctx
}

render :: proc() {
    render_mu_texture :: proc(rect: mu.Rect, pos: [2]i32, color: mu.Color) {
        source := rl.Rectangle{f32(rect.x), f32(rect.y), f32(rect.w), f32(rect.h)}
        position := rl.Vector2{f32(pos.x), f32(pos.y)}

        rl.DrawTextureRec(state.atlas_texture, source, position, transmute(rl.Color)color)
    }

    render_rl_texture :: proc(texture: rawptr, rect: mu.Rect) {
        text_ptr := cast(^rl.Texture2D) texture
        source := rl.Rectangle{0.0, 0.0, f32(text_ptr.width), f32(text_ptr.height)}
        dest := rl.Rectangle{f32(rect.x), f32(rect.y), f32(rect.w), f32(rect.h)}

        rl.DrawTexturePro(text_ptr^, source, dest, rl.Vector2{0.0, 0.0}, 0.0, rl.WHITE)
    }

    //rl.ClearBackground(transmute(rl.Color)state.bg)

    command_backing: ^mu.Command
    for variant in mu.next_command_iterator(ctx, &command_backing) {
        switch cmd in variant {
        case ^mu.Command_Text:
            pos := [2]i32{cmd.pos.x, cmd.pos.y}
            for ch in cmd.str do if ch & 0xc0 != 0x80 {
                    r := min(int(ch), 127)
                    rect := mu.default_atlas[mu.DEFAULT_ATLAS_FONT + r]
                    render_mu_texture(rect, pos, cmd.color)
                    pos.x += rect.w
                }
        case ^mu.Command_Rect:
            rl.DrawRectangle(
                cmd.rect.x,
                cmd.rect.y,
                cmd.rect.w,
                cmd.rect.h,
                transmute(rl.Color)cmd.color,
            )
        case ^mu.Command_Icon:
            rect := mu.default_atlas[cmd.id]
            x := cmd.rect.x + (cmd.rect.w - rect.w) / 2
            y := cmd.rect.y + (cmd.rect.h - rect.h) / 2
            render_mu_texture(rect, {x, y}, cmd.color)
        case ^mu.Command_Clip:
            rl.EndScissorMode()
            rl.BeginScissorMode(cmd.rect.x, rl.GetScreenHeight() - (cmd.rect.y + cmd.rect.h), cmd.rect.w, cmd.rect.h)
        case ^mu.Command_Jump:
            unreachable()
        //Custom commands
        case ^mu.Command_Image:
            render_rl_texture(cmd.texture, cmd.rect)
        }
    }
}

@(private)
set_pixel_alpha :: proc() {
    pixels = make([][4]u8, mu.DEFAULT_ATLAS_WIDTH*mu.DEFAULT_ATLAS_HEIGHT)
    for alpha, i in mu.default_atlas_alpha {
		pixels[i] = {0xff, 0xff, 0xff, alpha}
	}
}

@(private)
load_mu_tex :: proc() {
    image := rl.Image{
		data = raw_data(pixels),
		width   = mu.DEFAULT_ATLAS_WIDTH,
		height  = mu.DEFAULT_ATLAS_HEIGHT,
		mipmaps = 1,
		format  = .UNCOMPRESSED_R8G8B8A8,
	}
	state.atlas_texture = rl.LoadTextureFromImage(image)
}

@(private)
load_context :: proc() {
    
    mu.init(ctx)
    ctx.text_width = mu.default_atlas_text_width
	ctx.text_height = mu.default_atlas_text_height
}

@(private)
keyboard_input :: proc() {
    // keyboard
    @static keys_to_check := [?]struct{
        rl_key: rl.KeyboardKey,
        mu_key: mu.Key,
    }{
        {.LEFT_SHIFT,    .SHIFT},
        {.RIGHT_SHIFT,   .SHIFT},
        {.LEFT_CONTROL,  .CTRL},
        {.RIGHT_CONTROL, .CTRL},
        {.LEFT_ALT,      .ALT},
        {.RIGHT_ALT,     .ALT},
        {.ENTER,         .RETURN},
        {.KP_ENTER,      .RETURN},
        {.BACKSPACE,     .BACKSPACE},
    }
    for key in keys_to_check {
        if rl.IsKeyPressed(key.rl_key) {
            mu.input_key_down(ctx, key.mu_key)
        } else if rl.IsKeyReleased(key.rl_key) {
            mu.input_key_up(ctx, key.mu_key)
        }
    }
}