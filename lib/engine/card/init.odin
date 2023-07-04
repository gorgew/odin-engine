package card

import "core:fmt"

init :: proc() {
    init_cards()
    default_deck_1 := test_default_deck_1()
    player1 := create_player(&default_deck_1)
    //fmt.print(default_deck_1)
    fmt.print(player1.deck)
}

@(private)
test_default_deck_1 :: proc() -> [dynamic] string {
    decklist: [dynamic] string
    append(&decklist, 
        "Market Bear",
        "Market Bear",
        "Market Bear",
        "Market Bear",
        "Sweatshop",
        "Sweatshop",
        "Sweatshop",
        "Sweatshop",
    )
    return decklist
}