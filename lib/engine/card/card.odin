package card

import "core:sort"
import "core:math/rand"

CardType :: enum {
    Agent,
    Negotiation,
    Venture,
}

//Card, as in the idea of a card
Card :: struct {
    cardType: CardType,
    name: string,
    text: string,
    cost: int,
    on_cast: proc(),
    on_etb: proc(),
    callback: proc(),
    on_death: proc(),
}

//The physical cardboard of each card
Cardboard :: struct {
    card: ^Card,
    id: int,
}

decklist_to_cardboard :: proc(decklist: ^[dynamic]string) -> [dynamic]Cardboard {
    sort.quick_sort(decklist[:])
    deck : [dynamic]Cardboard
    id_count := 1
    for card_name in decklist {
        if !(card_name in card_map) {
            assert(false, "card in decklist not found");
        }
        card_ref := &card_map[card_name]
        append(&deck, Cardboard{
            card_ref,
            id_count,
        })

        id_count += 1
    }
    shuffle_deck(&deck)
    return deck
}

shuffle_deck :: proc(deck: ^[dynamic]Cardboard) {
    rand.shuffle(deck[:])
}
