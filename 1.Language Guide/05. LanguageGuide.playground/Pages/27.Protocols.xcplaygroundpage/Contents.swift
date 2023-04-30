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
 
 */














//: [Next](@next)
