package main

import rl "vendor:raylib"

main :: proc() {
    screenWidth :i32 = 800;
    screenHeight :i32 = 450;
    window := create_window(screenWidth, screenHeight)

    pos := rl.Vector2{10, 10}
    
    for !rl.WindowShouldClose()
    {
        rl.BeginDrawing();

        rl.ClearBackground(rl.RAYWHITE);

        rl.DrawText("Congrats! You created your first window!", 190, 200, 20, rl.LIGHTGRAY);
        rl.DrawCircleV(pos, 20.0, rl.MAGENTA)
        rl.EndDrawing();
    }
    rl.CloseWindow();
}