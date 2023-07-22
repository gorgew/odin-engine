package assets

import "lib:animation"

Animations := make(animation.Animation_Map)

@(private)
load_animations :: proc() {
    animation.add_from_spritesheet(&Animations, "gabe_run", &Textures[Texture.gabe_run], 
        .125, 
        1, 7, 
        24, 24, 
        7, 
        0.0, 0.0, 
        true)
}