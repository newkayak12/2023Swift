//: [Previous](@previous)
/*: # Extensions*/
/**
 Extensions add new functionality to an existing class, structure, enumeration, or protocol type. This includes the ability to extend types for which you don't have access to the original source code. Extensions are similar to categories in Objective-C.
 
 Extensions in Swift can;
    - Add computed instance properties and computed type properties
    - Define instance methods and type methods
    - Provide new initializers
    - Define subscripts
    - Define and use new nested types
    - Make an existing type conform to a protocol
 
 In Swift, you can even extend a protocol to provide implementations of its requirements or add additional functionality that conforming types can take advantage of.
 
        Extensions can add new functionality to a type, but they can't override existing functionality.
 
    Extension Syntax
 Declare extension with the extension keyword:
 */

//
//extension SomeType {
//
//}
//

/**
 An extension can extend an existing type to make it adopt one or more protocols. To add protocol conformance, you write the protocol names the same way as you write them for a class or structure:
 */

//
//extension SomeType: SomeProtocol, AnotherProtocol {
//
//}
//

/**
 Adding protocol conformance in this way is described in Adding Protocol Conformance with an Extension.
 
 An extension can be used to extend an existing generic type, as describe in Extending a Generic Type. You can also extend a generic type to conditionally add functionality, as described in Extensions with a Generic Where Clause.
 
 
    Computed Properties
 Extensions can add computed instance properties and computed type properties to exsiting types. This example adds five computed instance prorperties to Swift's built-in Doulbe type, to provide basic support for working with distance units:
 
 */

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
/**
 These computed properties express that a Double value should be considered as a certain unit of length. Although they're implemented as computed properties, the names of these properties can be appended to a floating-point literal value with dot syntax, as a way to use that literal value to perform distance conversions.
 
 These properties are read-only computed properties, and so they're expressed without the get keyword, for brevity. Their return value is of type Double, and can be used within mathmetical calculations wherever a Double is accpeted.
 
        Extension can add new computed properties, but they can't add stored properties, or add property observers to existing properties.
 
    Initializers
 Extensions can add new initializers to existing types. This enables you to extend other types to accept your won custom types as initializer paraemters, or to provide additional initialization options that were not included as part of the type's originial implementaion.
 
 Extension can add new convenience initializers to a class, but they can't add new designed initializers or deinitializers to a class. Designated initializers and deinitilizers must always be provided by the original class implementation.
 
 If you use an extension to add an initializer to a value type that provides default values of all of its sotred properties and doesn't define any custom initializers, you can call the default initializer and memberwise initializer for that value type from within your extension's initializer. This wouldn't be the case if you had written the initializer as part of the value type's original implementation.
 
 If you use an extension to add an initializer to a structure that was declared in another moduel, the new initializer can't access 'self' until it calls an initializer from the defining module.
 
 */

struct Size {
    var width = 0.0
    var height = 0.0
}

struct Point {
    var x = 0.0
    var y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

/**
 Because the Rect structure provides default values for all of its properties, it receives a default initializer and a memerwise initializer automatically.
 */

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

extension Rect {
    init( center: Point, size: Size ) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

/**
 
 The initializer then calls the structure's automatic memberwise initializer init(origin: size:), which stores the new origin and size values in the appropriate properties:
 
    Method
 Extensions can add new instance methods and type methods to existing types. The following example adds a new instance emthod called repetition to the Int type:
 */

extension Int {
    func repetition ( task: () -> Void ){
        for _ in 0..<self {
            task()
        }
    }
}

/**
    Mutating Instance Methods
 Instance methods added with an extension can also modify the instance itself. Structure and enumeration methods that modify 'self' or its properties must mark the instance method as mutating, just like mutating method from an original implementation.
 
 */

extension Int {
    mutating func square () {
        self = self * self
    }
}

var someInt = 3
someInt.square()

/**
    Subscripts
 Extensions can add new subscripts to an existing type. This example adds an integer subsript to Swift's built-in Int type. This subscript [n] return the decimal digit n places in from the right of the number:
 */

extension Int {
    subscript (digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0 ..< digitIndex {
            decimalBase *= 10
        }
        
        return (self / decimalBase) % 10
    }
}

746381295[0]
746381295[1]
746381295[2]
746381295[3]

/**
    Nested Types
 Extensions can add new nested types to existing classes, structures, and enumerations:
 
 */

extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
            case 0:
                return .zero
            case let x where x > 0:
                return .positive
            default:
                return .negative
        }
    }
}

/**
 This example also adds a new computed instance property to Int, called kind, which return the appropriate Kind enumeration case for that integer.
 
 */

func printIntegerKinds( _ numbers: [Int] ) {
    for number in numbers {
        switch number.kind {
            case .negative:
                print("-")
            case .zero:
                print("0")
            case .positive:
                print("+")
        }
    }
}



//: [Next](@next)
