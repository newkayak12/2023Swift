//: [Previous](@previous)
/*: # Nested Types*/
/**
 Enumerations are often created to support a specific class or structure's functionality. Similaraly, it can be convenient to define utility calsses and structures purely for use within the context of a more complex type. To accomplish this, Swift enables you to define nested types, whereby you nest supporting enumerations, classes, and structures within the definition of the type they support.
 
    Nested Types in Action
 The example below defines a structure called BlackjackCard, which models a playing card as used in the game of Blackjack. The BlackjackCard structure contiains two nested enumeration types called Suit and Rank.
 
 
 */
struct BlackjackCard {
    enum Suit: Character {
        case spade = "♠", hearts = "♡", diamonds = "◇", clubs = "♣"
    }
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
                case .ace:
                    return Values(first: 1, second: 11)
                case .jack, .queen, .king:
                    return Values(first: 10, second: nil)
                default:
                    return Values(first: self.rawValue, second: nil)
            }
        }
    }
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue)"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        
        return output
    }
}


/**
 
    Referring to Nested Types
 To use a nested type otside of tis definition context, prefix its name with the name of the type it's nested within:
 */
let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
print(heartsSymbol)





//: [Next](@next)
