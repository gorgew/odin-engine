package assets

import rl "vendor:raylib"
import "core:fmt"
import "core:strings"

Texture :: enum {
    gabe_run,
}

Textures := [len(Texture)]rl.Texture2D{}

@(private)
load_textures :: proc() {
    for tex in Texture {
        str := get_path( "assets/", tex, ".png")
        fmt.println("Loaded texture at ", str)
        path := strings.clone_to_cstring(str)
        Textures[tex] = rl.LoadTexture(path)
    }
}
@(private)
get_path :: proc(args: ..any) -> string {
    return fmt.aprint(args=args, sep="")
}