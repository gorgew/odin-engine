package card

Player :: struct {
    deck: [dynamic] Cardboard,
    hand: [dynamic] Cardboard,
    graveyard: [dynamic] Cardboard,
    money: int,
}

create_player :: proc(decklist: ^[dynamic]string) -> Player {
    player := Player {
        decklist_to_cardboard(decklist),
        make([dynamic] Cardboard, 0, 16),
        make([dynamic] Cardboard, 0, 40),
        0,
    }
    draw_cards(&player, 5)
    return player
}

draw_cards :: proc(player: ^Player, count: int) {
    for i := 0; i < count; i = i + 1 {
        append(&player.hand, pop_front(&player.deck))
    }
}