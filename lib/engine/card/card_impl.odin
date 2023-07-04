package card

card_map := make(map[string]Card)

init_cards :: proc() {
    card_map["Market Bear"] = Card{
        CardType.Agent,
        "Market Bear",
        "",
        2,
        empty, empty, empty, empty,
    }
    card_map["Sweatshop"] = Card{
        CardType.Venture,
        "Sweatshop",
        "",
        1,
        empty, empty, empty, empty,
    }

}

@(private)
empty :: proc() {}