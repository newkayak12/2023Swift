//: [Previous](@previous)
/*: # Protocols and Extesions*/
/**
 Use 'protocol' to declare a protocol.
 */

protocol ExampleProtocol {
    var simpleDescription: String {get}
    mutating func adjust()
    func springRain()
}

/**
 Classes, enumerations, and structures can all adopt protocols.
 */
class SimpleClass: ExampleProtocol {
    func springRain() {
        print("coldRain")
    }
    
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += " Now 100% adjusted."
    }
}

var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol {
    func springRain() {
        print("coldRain")
    }
    
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adujsted)"
    }
}

var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription

/**
 Notice the use of the 'mutating' keyword in the declaration of 'SimpleStructure' to mark a method that modifies the structure. The declaration of "SimpleClass" doesn't need any of its methods marked as mutating because methods on a class can always modify the class.
 
 Use "extension" to add functionality to an existing type, such as new methods and computed properties You can use an extension to add protocol conformance to a type that's decalred elsewhere, or even to a type that you imported from a libarary or framework.
 */

extension Int: ExampleProtocol {
    func springRain() {
        print("HeavyRain")
    }
    
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}

print(7.simpleDescription)

protocol ExamDoubleProtocol {
    func addAbsoluteValue();
}
extension Double: ExamDoubleProtocol {
    func addAbsoluteValue() {
        self + 12.1;
    }
}

1.1.addAbsoluteValue()

/**
 You can use a protocol name just like any other named type - for example, to create a collection of objects that have different types but that all conform to a single protocol. When you work with values whose type is protocol type, methods outside the protocol definition aren't available.
 */

let protocolValue: ExampleProtocol = a;
print(protocolValue.simpleDescription)

/**
 Even though the variable 'protocolValue' has a runtime type of SimpleClass, the compiler treats it as the given type of 'ExampleProtocol'. This mean that you can't accidentally access methods or properties thath the class implements in addition to its protocol conformance.
 */

//: [Next](@next)
