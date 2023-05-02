//: [Previous](@previous)
/*: # Protocol*/
/**
 A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of funcitonality. The protocol can then be adopted by a class, struture, or enumeration to provide an actual implmentation of those requirements. Any type that statisfies the requirements of a protocol is said to conform to that protocol.
 
 In addition to specifying requirements that conforming tyeps must implement, you can extend a protocol to implement some of these requirements or to implement additional functionality that conforming types can take advantage of.

    Protocol Syntax
You define protocols in a vary similar way to classes, structures, and enumerations:
 */

protocol SomeProtocol {
    
}

/**
Custom types state that they adopt a particular protocol by placing the protocol's name after the type's anme, separated by a colon, as part of their definition. Multiple protocols can be listed, and are separated by commas:
 */

//
//struct SomeStructure: FirstProtocol, AnotherProtocol {
//
//}
//

/**
 If a class has a superclass, list the superclass name before any protocols it adopts
 */

//
//class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
//
//}
//

/**
    Property Requirements
 A protocol can require any conforming type to provide an instance property or type proeprty with a particular name and type. The protocol doesn't specify whether the property should be a stored property or a computed property - it only specifies the required property name and type. The protocol also specifies whether each proeprty must be gettable or gettable and settable.
 
 If a protocol requires a property to be gettable and settable, that property requirement can't be fulfilled by a constant stored property or a read-only computed property. If the protocol only requries a property to be gettable, the requirement can be satisfied by any kind of property, and it's valid for the property to be also settable if this is useful for your own code.
 
 Property requirements are always declared as variable properties, prefixed with the var keyword. Gettable and settable properties are indicated by writing { get set } after their type declaration, and gettable properties are indicated by writing { get }.
 
 */

protocol SomeProtocols {
    var mustBeSettable: Int { get set}
    var doesNotNeedToBeSettable: Int { get }
}

/**
 Always prefix type property requirements with the static keyword when you define them in a protocol. This rule pertains even though type property requirements can be prefixed with the class or static keyword when implemented by a class
 */

protocol AnotherProtocols {
    static var someTypeProperty: Int { get set }
}

/**
 Here's an example of protocol with a single instance property requirement:
 */

protocol FullyNamed {
    var fullName: String { get }
}

/**
 The FullyNamed protocol requires a conforming type to provide a fully qualified name. The protocol doesn't specify anything else about the nature of the conforming type - it only sepcifies that type must be able to provide a full name for itself. The protocol states that any FullyNamed type must have a gettable instance called fullName, which is of type String.
 */

struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John AppleSeed")

/**
 This example defines a structure called Person, which represents a specific named person. It states that it adopts the FullyNamed protocol as part of the first line of its definition.
 
 Each instance of Person ahs a single stored property called fullName, which is of type String. This matches the single requirement of the FullyNamed protocol, and means that Person has correctly conformed to the protocol
 */

class StartShip: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? (prefix! + " ") : "") + name
    }
}

/**
 This class implements the fullName  property requirement as a computed read-only property for a starShip, Each StarShip class insacne stroes a mandatory name and an optional prefix.
 
 
    Method Requirements
 Protocol can require specific instance methods and type methods tobe implemented by conforming types. These methods are written as part of the protocol's definition in exactly the same way as for normal instance and type methods, but without curly braces or a method body. Variadic parameters are allowed, subject to same rules as for normal methods. Defualt values, however, can't be specified for method parameters within a protocol's definition
 
 As with type property requirements, you always prefix type emthod requirements with the 'static' keyword when they're defined in a protocol. This is true even though type method requirements are prefixed with the class or static keyword when implemented by a class:
 */

protocol SomeProtocolz {
    static func someTypeMethodz();
}

/**
 The following example defines a protocol with a single instance method requirement:
 */

protocol RandomNumberGenerator {
    func random() -> Double
}

/**
 This protocol, RandomNumberGenerator, requires any conforming type to have an instance method called random, which returns a Double value whenever it's called. Although it's not specified as part of the protocol, it's assumed that this value will be a number from 0.0 up to 1.0.
 
 The RandomNumberGenerator protocol doesn't make any assumptions about how each random number will be generated - it simply requires the generator to provide a standart way to generate a new random number.
 
 Here's an implementation of a class that adopts and conforms to the RandomNumberGenerator protocol. This calss implements a pseudorandom number generator algorithm known as a linear congruentail generator:
 */

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m))
        
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
print(generator.random())
print(generator.random())


/**
    Mutating Method Requirements
 It's sometimes necessary for a method to modify the instane it belongs to. For instance methods on value types you place the mutating keyword before a method's func keyword to indicate taht the method is allowed to modify the instance it belongs to and any properties of that instance. This process is described in Modifying Value Types from Within Instance Methods.
 
 
 If you define a protocol instance method requirement that's intended to mutate instances of any type that adopts the protocol, mark the method with the 'mutating' keyword as part of the protocol's definition. This enables structures and enumerations to adopt the protocol and staisfy that method requirement.
 
            If you mark a protocol instance method requirement as mutating, you don't need to write the mutating keyword when writing an implementation of  that method for a class. The mutating keyword is only used by structures and enumerations.
 
 The example below defines a protocol called Togglable, which defines a single instance method requirement called toggle. As its name suggests, the toggle() method is intended to toggle or invert the state of any conforming type, typically by modifying a property of that type.
 
 The toggle() method is marked with the mutating keyword as part of the Togglable protocol definition, to indicate that the method is expected to mutate the state of a conforming instance when it's called:
 */

protocol Togglable {
    mutating func toggle()
}

/**
 If you implement the Toggleable protocol for a structure or enumeration, that structure or enumeration can conform to the protocol by providing an implementation of the toggle() method that's also marked as mutating.
 
 The example below defines an enumeration called 'OnOffSwitch'. This enumeration toggles between two states, indicated by the enuermation cases on and off. The enumeration's toggle implementation is marked as mutating, to match the Togglable protocol's requirements:
 
 */
enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
            case .off:
                self = .on
            case .on:
                self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()

/**
    Initializer Requirements
 Protocls can require specific initializers to be implemented by conforming types. You write these initializers as part of the protocol's definition in exactly the same way as for normal initializers, but without curly braces or an initializer body:
 */

protocol SomeProtocolInitializer {
    init(someParameter: Int)
}

/**
    Class Implementations of Protocol Initializer Requirements
 You can implement a protocol initializer requirement on a conforming class as either a designated initializer or a convenience initializer. In both cases, you must mark the initializer implementation with the required modifier:
 */

class SomeClass: SomeProtocolInitializer {
    required init(someParameter: Int){
        //
    }
}



/**
 The use of the required modifier ensrues that you provide an explicit or inherited implementation of the initializer requirement on all subclasses of the conforming class, such that they also conform to the protocol.
 
            You don't need to mark protocol initializer implementations with the required modifier on classes that are marked with the final modifier, because final classes can't subclassed.
 
 If a subclass overrides a designated initializer from a superclass, and also implements a matching initializer requirement from a protocol, mark the initializer implementation with both the required and override modifiers:
 */

protocol SomeProtocol3 {
    init()
}

class SomeSuperClass {
    init() {
        
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol3 {
    required override init() {
        
    }
}

/**
    Failable Initializer Requirements
 Protocols can define failable initializer requirements for conforming types, as defined in Failable Initializers.
 
 A failable initializer requirement can be satisfied by a failable or nonfailable initializer on a conforming type. A nonfailable initializer requirement can be satisfied by a nonfailalbe initailzer or an implicitly unwrapped failable initializer.
 
 
    Protocols as Types
 Protocols don't actually implement any functionality themselves. Nonetheless, you can use protocols as a fully fledged types in your code. Using a protocol as a type is sometimes called an exsitential type, which comes from the phrase "there exists a type T such that T conforms to the protocol".
 
 You can use a protocol in many places where other types are allowed, including:
 
    - As a parameter type or return type in function, method, or initializer
    - As the type of a constant, variable, or property
    - As the type of items in an array, dictionary, or other container
 
        Because protocols are types, begin their names with a capital letter to match the names of other types in Swift
 */

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init( sides: Int, generator: RandomNumberGenerator ) {
        self.sides = sides
        self.generator = generator
    }
    func roll () -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

/**
 This example defines a new class called Dice, which represents an n-sided dice for use in a borad game. Dice instances have a integer property called sides, which represents how many sides they have, and a property called generator, which provides a random number generator from which to create dice roll values.
 
 The generator proeprty is of type RandomNumberGenerator. Therefore, you can set it to an instance of any type that adopts the RandomNumberGenerator protocol. Nothing else is required of the instance you assign to this property, except that the instance must adopt the RandomNumberGenerator protocol. Because its type is RandomNumberGenerator, code inside the Dice class can only interact with generator in ways that apply to all generaors that conform to this protocol. That means it can't use any methods or properties that are defined by the underlying type of the generator. However, you can downcast from a protocol type to an underlying type in the same way you can downcast from a superclass to a subclass, as discussed in Downcasting.
 
 Dice also has an initializer, to set up its initial state. This initializer has a prameter called generator, which is also of type RandomNumberGenerator. You can pass a value of any conforming type in to this parameter when initializing a new Dice instance.
 
 Dices provides on instance method, roll, which returns an integer value between 1 and the number of sides on the dice This method calls the generator's random() method to create a new random number between 0.0 and 1.0, and uses this random number to create a dice roll value within the correct rage. Because generator is known to adopt RandomNubmerGenerator, it's guaranteed to  have a reandom method to call.
 
 Here's how the Dice class can be used to create a six-sided dice with a LinearCongruentialGenerator instance as its random number generator.
 */

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

/**
    Delegation
 Delegation is a design pattern that enables a class or structure to hand off some of its responsibilities to an instance of another type. This design pattern is implemented by defining a protocol that encapsulates the delegated responsibilities, such that a comforming type is guaranteed to provide the functionality that has been delegated. Delegation can be used to respond to a particular action, or to retrieve data from an external source without needing to know the underlying type of that source.
 
 */
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame )
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

/**
 The DiceGame protocol is a protocol that can be adopted by any game that involves dice.
 
 The DiceGameDelegate protocol can be adopted to track the progress of a DiceGame. To prevent string reference cycles, delegates are declared as weak references. For information about weak references, see Strong Reference Cycle Between Class Insatnces. Marking the protocol as class-only lets the SnakesAndLadders class later in this chapter declare that its delegate must use a weak reference. A class-only protocol is marked by its inheritance from AnyObject, as discussed in Class-Only Protocols.
 
 Here's a version of the Snakes and Ladders game originally introduced in Control Flow. This version is adapted to use a Dice instance for its dice-rolls; to adopt the DiceGame protocol; and to notify a DiceGameDelegate about its progress:
 */

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = 08
        board[06] = 11
        board[09] = 09
        board[10] = 02
        board[14] = -10
        board[19] = -11
        board[22] = -02
        board[24] = -8
    }
    
    weak var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidEnd(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            
            switch square + diceRoll {
                case finalSquare:
                    break gameLoop
                case let newSquare where newSquare > finalSquare:
                    break gameLoop
                default:
                    square += diceRoll
                    square += board[square]
            }
        }
        
        delegate?.gameDidEnd(self)
    }
}

/**
 This version of the game is wrapped up as a class called SnakesAndLadders, which adopts the DiceGame protocol. It provides a gettable dice property and a play() method in order to conform to the protocol.
 
 The Snake and Ladders game board setup takes place within the class's init() initializer. All game logic is moved into the protocol's pay emthod, which uses the protocol's required dice property to provie its dice roll values.
 
 Note that the delegate property is defined as an optional DiceGameDelegate, becuase a delegate isn't required in order to play the game. Becuase it's of an optional type, the delegate property is automatically set to an initial value of nil. Thereafter, the game instantiator has the option to set the property to a suitable delegate. Because the DiceGameDelegate protocol is class-only, you can declare the delegate to be weak to prevent reference cycle.
 
 DiceGameDelegate provides three methods for tracking the progress of a game. These three methods have been incorporated into the game logic within the play() method above, and are called when a new game starts, a new turn begins, or the game ends.
 
 Because the delegate property is an optional DiceGameDelegate, the play() method uses optional chaining each time it calls a method on the delegate. If the delegate property is nil, these delegate calls fail gracefully and without error. If the delegate property is non-nil, the delegate methods are called, and are passed the SnakesAndLadders instance as a parameter.
 
 This next example shows a class called DiceGameTracker, which adopts the DiceGameDelegate protocol:
 */
class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snake and Ladders")
        }
        
        print("The game is using a \(game.dice.sides)-sided dice.")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

/**
 DiceGameTracker implements all three methods required by DiceGameDelegate, It uses these methods to keep track of the number of turns a game has taken. It resets a numberofTurns property to zero when the games starts, increments it each time a new turn begins, and prints out the total number of turns once the game has ended.
 
 The implementation of gameDidStart(_:) shown above uses the game parameter to print some introductory information about the game that's about to be played. The game parameter has a type of DiceGame, not SnackesAndLadders, and so gameDidStart(_:) can access and use only methods and proeprties that are implemented as part of the DiceGame protocol. However, the method is still able to use type casting to query the type query the type of the undelying instnce. In this example, it checks whether game is actually an instance of SnakesAndLadders behind the scenes, and prints an appropriate message if so.
 
 The gameDidStart(_:) method also accesses the dice property of the passed gamee parameter. Because game is known to conform to the DiceGame protocol, it's guaranteed to have a dice property, and so the gameDidStart(_:) method is able to access and print the dice's sides property, regardless of what kind of game is being played.
 
 */
let tracker = DiceGameTracker()
let game = SnakesAndLadders()

game.delegate = tracker
game.play()

/**
    Adding Protocol Conformance with an Extension
 You can extend an exsiting type to adopt and conform to a new protocol, even if you don't have access to the source code for the existing type. Extensions can add new properties, methods, and subscripts to an existing type, and are therefore able to add any requirements that a protocol may demand.
 
            Existing instances of a type automatically adopt and conform to a protocol when that conformance is added to the instance's type in an extension.
 */
protocol TextRepresentable {
    var textualDescription: String { get }
}

/**
 The Dice class from above can be extended to adopt and conform to TextRepresentable:
 */

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

/**
 This extension adopts the new protocl in exactly the same way as if Dice had provided it in its original implementation. The protocol name is provided after the type name, separated by a colon, and an implementation of all requirements of the protocol is provided within the extension's curly braces.
 
 Any Dice instance can now be treated as TextRepresentable:
 */

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12)


/**
 Similiary, the SnakesAndLadders game class can be extended to adopt and conform to the TextRepresentable protocol:
 */

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.textualDescription)

/**
    Conditionally Conforming to Protocol
 A generic type may be able to satisfy the requirements of a protocol only under certain conditions, such as when the types gnenric parameter conforms to the protocol. You can make a generic type conditionally conform to a protocol by listing constraints when extending the type. Write these constraints after the name of the protocol you're adopting by writing a generic where clause.
 
 To following extension makes Array instances  conform to the TextRepresentable protocol whenever they store elements of a type that conforms to TextRepresentable.
 */

extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "["+itemsAsText.joined(separator: ",")+"]"
    }
}


let myDice = [d6, d12]
print(myDice.textualDescription)


/**
    Declaring Protocol Adoption with an Extension
 If a type already conforms to all of the requirements of a protocol, but hasn't yet stated that it adopts that protocol, you can make it adopt the protocol with an empty extension:
 */

struct Hamster {
    var name: String
    var textualDescription: String {
        return " A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable {}
/**
 Instances of Hamster can now be used wherever TextRepresentable is the required type:
 */

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

/**
            Types don't automatically adopt a protocol just by satifying its requirements. They must always explicitly decalre their adoption of the protocol.
 
 
    Adopting a Protocol Using a Synthesized Implementation
 Swift can automatically provide the protocol conformance for Equatable, Hashable, and Comparable in many simple cases. Using this synthesized implementation means you don't have to write repetivie boilerplate code to implement the protocol requirements yourself
 
 Swift provides a synthesized implementation of Equatable for the following kinds of custom types:
 
    - Strcutures that have only stored properties that conform to the Equatable protocol
    - Enumerations that have only associated types that conform the Equatable protocol
    - Enumerations that have no associated types
 
 To receive a synthesized implementation of '==', declare conformance to Equtable in the file that contains the original declaration, without implementing an == operator yourself. The Equatable protocol provides a default implementation of !=.
 
 The example below defines a Vector3D sturucture for a three-dimensional position vector(x, y, z), similar to the Vector2D structure. Because the x, y and z properties are all of an Equataable type, Vector3D receives synthesized implementations of the equivalence operators.
 */

struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}

let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if twoThreeFour == anotherTwoThreeFour {
    print("These two vectors are also equivalent")
}



//: [Next](@next)
