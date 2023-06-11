package gamestate

@(private)
currentPlayer: ^Player

Phase :: enum {
    PayStep,
    DrawStep,
    Main1,
    Combat, 
    Main2,
    End,
}

next_phase :: proc() {

}

