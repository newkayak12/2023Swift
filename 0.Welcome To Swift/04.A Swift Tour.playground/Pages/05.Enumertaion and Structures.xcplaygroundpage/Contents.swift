//: [Previous](@previous)
/*: # Enumerations and Structures*/

/**
 Use 'enum' to create enumeration. Like classes and all other named types, enumerations can have mehtods associated with them.
 */

enum Rank: Int, CaseIterable{
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    func simpleDescription () -> String {
        switch self {
                
            case .ace:
                return "ace"
            case .jack:
                return "jack"
            case .queen:
                return "queen"
            case .king:
                return "king"
            default:
                return String(self.rawValue)
        }
    }
    
    func compare (greatherThan element: Rank) -> Bool {
        return self.rawValue > element.rawValue
    }
    func compare (lessThan element: Rank) -> Bool {
        return self.rawValue < element.rawValue
    }
}



let ace = Rank.ace
let aceRawValue = ace.rawValue
ace.compare(greatherThan: .jack)
ace.compare(lessThan: .jack)

/**
 By default, Swift assigns the raw values starting at zero and icrementing by one each time, but you can change this behavior by explicitly specifying values. In the example above, 'Ace' is explicitly given a raw value of '1', and the rest of the raw values are assigned in order. You also use strings or floating-point numbers as the raw type of an enumeration. Use the 'rawValue' property to access the raw value of an enumeration case.
 
 Use the 'init?(rawValue:)' initializer to make an instance of an enumeration from a raw value. It returns either the enumeration case matching the raw value or 'nil' if there's no matching 'Rank'.
 */

if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}

/**
 The case values of an enumeration are actual values, not just another way of writing their raw values In fact, in cases wehre there isn't a meaningful raw value, you don't have to provide one.
 */

enum Suit: CaseIterable {
    
    case spades, hearts, diamonds, clubs
    
    func simpleDescription () -> String {
        switch self {
            case .spades:
                return "spades"
            case .hearts:
                return "hearts"
            case .diamonds:
                return "diamonds"
            case .clubs:
                return "clubs"
        }
    }
    
    func color() -> String {
        switch self {
            case .spades, .clubs:
                return "black"
            case .hearts, .diamonds:
                return "red"
        }
    }
}

let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()
hearts.color()

/**
 Notice the two ways that the 'hearts' case of the enumeration is referred to above: When assigning a value to the 'hearts' constant, the enumeration case 'Suit.hearts' is referred to by its full name because the constatnt doesn't have and explicit type specified. Insde the switch, the enumeration case is reffered to by the abbreviated form '.hearts' because the value of 'self' is already known to be a suit. You can use the abbreviated form anytime the value's type is already known.
 
 If an enumeration has raw values, those values are determined as part of the declaration, which means every instance of a particular enumeration case always has the same raw value. Another choice for enumeration cases is to have values associated with the case-these values are determined when you make the instance, and they can be different for each instance of an enumeration case. You can think of the associated values as behaving like stored properties of the enumeration case instace. For example, consider the case of requesting the sunrise and sunset time from a server the server either responds with request information, or it responds with a description of what went wrong.
 */


enum ServerResponse {
    case result( String, String )
    case pending( String )
    case failure( String )
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let pending = ServerResponse.pending("now loading...")
let failure = ServerResponse.failure("Out of cheese")

func printReference  (value element: ServerResponse) {
    switch element {
        case let .result(sunrise, sunset):
            print("Sunrise is at \(sunrise)and sunset is at \(sunset)")
        case let .pending(message):
            print((message))
        case let.failure(message):
            print("Failure... \(message)")
    }
}

printReference(value: success)
printReference(value: pending)
printReference(value: failure)

/**
 Use 'struct' to create a structure. Structures support many of the same behaviors as classes, including methods and initalizers. One of the most important differences between 'structures' and 'classes' is that 'structures' are always copied when they're passed around in your code, but 'classes' are passd by reference
 */

struct Card {
    var rank: Rank
    var suit: Suit
    
    func simpleDescription () -> String{
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
    
    
}

let threeOfSpades = Card(rank: .three, suit: .spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()

func fullDeck () {
    let allCaseOfRank = Rank.allCases
    let allCaseOfSuit = Suit.allCases
    
    for suit in allCaseOfSuit {
        for rank in allCaseOfRank {
            print("The \(rank) of \(suit)")
        }
    }
}

fullDeck()




//: [Next](@next)

