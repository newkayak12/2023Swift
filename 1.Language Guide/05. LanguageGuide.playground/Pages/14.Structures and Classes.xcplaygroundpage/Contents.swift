//: [Previous](@previous)
/*: # Structures and Classes*/
/**
 Structures and Classes are genenral-purpose, flexible consturcts that become the building block of your program's code.
 You define properties and methods to add functionality to your structures and classes using the same syntax you use to define constants, vairables, and functions.
 
 Unlike other programming languages, Swift doesn't require you to create separate interface and implemenation files for custom structures and classes In Swift, you define a structure or class in a single file, and the external interace to that class or structure is automatically made availalbe for other code to use.
 
    
        An instance of a class is traditionally known as an object. However, Swift structures and classess are much closer in functionality than in other languages, and much of this chapter describes functionality that applies to instances of either a class or a structure type. Because of this, the more general term instance is used.
 
 
    Comparing Structures and Classes
 Structures and classes in Swift have many things in common
    - Define properties to store values
    - Define methods to provide functionality
    - Define subscripts to provide access to their values using subscript syntax
    - Define initializers to set up their initial state
    - Be extended to expand their functionality beyond a defualt implementaion
    - Conform to protocols to provide standard functionality of a certain kind
 
 Class have additional capabilities that structures don't have:
    - Inheritance enables one class to inheir the charateristics of another.
    - Type casting enables you to check and interpret the type of a class instance at runtime
    - Deinitializers enable an instance of a classs to free up any resources it has assigned.
    - Reference counting allows more than one reference to a class instance.
 
 
 The additional capabilities that classes support come at the cost of increasd complexity as a general guideline, prefer sturctures becuase they're easier to reason about, and use classes when they're appropriate or necessary. In practice, this means most of the custom data types you define will be structures and enumerations.
 
 
 
    Definition Syntax
 Structures and classes have a similiar definition syntax. You introduce structures with the struct keyword and classes with the class keyword. both place their entire definition within a pair of braces:
 */

struct SomeStructrue {
    
}
class SomeClass {
    
}
/**
        
            Whenever you define a new structure or class, you define a new Swft type. Give types 'UpperCamelCase' names to match the capitalization of standard Swift types, Give properties and methods 'lowerCamelCase' names to differentiate them form type names.
 */

struct Resolution {
    var width = 0;
    var height = 0;
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

/**
 
    Structure and Class Instances
 The 'Resolution' structure definition and the 'VideMode' class definition only describe what a Resolution or VideoMode will look like. They themselves don't describe a specific resolution or video mode. To do that, you need to create an instance of the structure or class
 */

let someResolution = Resolution()
let someVideMode = VideoMode()

/**
 Structures and classes both use initializer syntax for new instances. The simplest form of initilaizer syntax uses the type name of the class or structure followed by empty parentheses, such as Resolution(), VideoMode(). This creates a new instance of the class or structure
 
 
 
 
    Memberwise Initializers for Structure Types
 All structures have an automatically generaterd memberwise intializer, which you can use to intialize the member properties of the new instance can be passed to the memberwise initializer by name:
 */

let vga = Resolution(width: 640, height: 480)

/**
 Unlike structures, class instannces don't receive a default memberwise initializer.
 
    Structures and Enumerations Are Value Type
 
 A value type is a type whose value is copied when it's assigned to a variable or constant, or when it's passed to a function.
 
 You've actually been using value types extensively throughout the previous chapters. In fact all of the basic types in Swift - integers, floating-point numbers, Booleans, strings, arrays, and dictionaries - are value types, and are implemented as structures behind the scenes.
 
 All structures and enumerations are value types in Swift. This means that any structure and enumeration instances you create - and any value types they have as proeprties - are always copied when they're passed around in your code.
 
        Collections defined by the standard library like arrays, dictionaries, and strings use an optimization to reduce the performance cost of copying. Instead of making a copy immediately, these collections share the memory where the elements are stroed between the original instance and any copies. If one of the copies of the collection is modified, the elements are copied just efore the modification. The behavior you see in your code is always as if a copty took place immediately.
 
 Conside this example, which uses the Resolution structure from the previous example:
 */

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
/**
 This example declares a constant called hd and set it to a Resolution instance initialized with the width and height of full HD video
 
 It then decalres a variable called cinema and sets it to the current value of hd, Because Resolution is a structure, a copy of the existing instance is made, and this new copy is assigned to cinema. Even though hd and cinema now have the same width and height, thery 're two completely different instances behind the scenes.
 
 Next, the width property of cinema is amended to be the width of the slightly wider 2K standard used for digital cinema projection.
 */
cinema.width = 2048
/**
 Checking the width property of cinema show that it has indeed changed to be 2048;
 */
print(cinema.width)
/**
 However, the width property of the original hd instance still has the old value of 1920
 */
print(hd.width)
/**
 When cinema was given the current value of hd, the values stored in hd were copied into the new cinema instance. The en dresult was two completely separate instances that contained the same numeric values. However, because they're separate instances, setting the width of cinema to 2048 doesn't affect the width stroed in hd.
 
 
 The same behavior applies to enumerations:
 */
enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}

var currentDirection = CompassPoint.west
let rememberdDirection = currentDirection
currentDirection.turnNorth()


print(currentDirection)
print(rememberdDirection)

/**
        Classes Are Reference Types
 Unlike value types, reference types are not copied when they're assigned to variable or constant, or when they're passed to a function. Rather than a copy, a reference to the same existing instance is used.
 */

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

/**
 This example declares a new constant called tenEighty and sets it to refer to a new instance of the VideoMode class. The Video mode is assigned a copy of the HD resolution of 1920 by 1080 from before. It's set to be interlaced, its name is set to "1080i", and its frame rate is set to 25.0 frames per second.
 
 Next, tenEighty is assigned to a new constant, called alsoTenEighty, and the frame rate of alsoTenEighty is modified:
 */
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
/**
 Because classes are reference types, tenEighty and alsoTenEighty actually both refer to the same VideoMode instance. Effectively, they're just two different names for the same single instace, as shown in the figure below.
 
 
 Note that tenEighty and alosoTenEighty are declared as constants, rather than variables. However, you can still change tenEighty.frameRate and alsoTenEighty.frameRate because the values of the tenEighty and alsoTenEighty constants themselves don't actually change. tenEighty and alsoTenEighty themselves don't "store" the VideoMode instance - instead, they both refer to a VideMode instance behind the scenes. It's the frameRate proeprty of the underlying VideoMode that's changed, not the values of the constant references to that VideoMode.
 
    
        Identity Operator
 Because classes are reference types, it's possible for multiple constants and variables to refer to the same single instance of a class behind the scenes (The smae isn't true for structures and enumerations, because they're always copied when they're assigned to constant or variable, or passed to a function).
 
 
    - Identical to (===)
    - Not identical to (!==)
 
 */

if tenEighty === alsoTenEighty {
    print("SAME")
} else {
    print("DIFFERENT")
}

/**
 
    Pointers
 If you have experience with, C, C++, or Objective-C, you may know that these languages use pointers to refer to addresses in memory. A Swift constant or variable that refers to an instance of some reference type is similar to a pointer in C, but isn't a direct pointer to an address in memory, and doesn't require you to write an asterisk to inicate that you are creating a reference. Instead, these references are defined like any other constant or vairable in Swift. The standart library provides pointer an buffer types that you can use if you need to interact with pointers directly
 */

//: [Next](@next)
