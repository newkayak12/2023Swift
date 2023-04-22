//: [Previous](@previous)
/*: # Enumerations*/
/**
 An 'enumeration' defines a common type for a group of related values and enables you to work with those values in a type safe way within your code.
 If you are familiar witch C, you will know that C enumerations assign related names to a set of integer values. Enumeration. If a value (known as a raw value) is provided for each enumeration case, the value can be a string, a character, or a vlaue or any integer or floating point type.
 
 Alterantviely, enumeration cases can specify associated values of any type to be stored along with each different case value, much as unions or variants do in other languages. You can define a common set of related cases as part of one enumeration, each of which has a different set of values of appropriate types associated with it.
 
 Enumerations in Swift are first-class types in their own right. They adopt many features traditionally supported only by classes, such as computed properties to provide additional information about the enumeration's current value, and instance methods to provide functionality related to the vlaues the enueration represents. Enumerations can aloso define initilizers to provide an inital case value; can be extended to expand their functionality beyond thier original implementation; and can conform to protocols to provide standard functionality
 
 
 
    Enumeration Syntax
 
 You introduce enumerations with the enum keyword and place their entire definition within a pair of braces:
 */
enum SomeEnumeration {
    
}

enum CompassPoint {
    case north, south, east, west
}

//The values defined in an enumeration are its enumeration cases. You use the case Keyword to introduce new enumeration cases

/**
        Swift enumeration cases dont' have an integer value set by default, unlike languages like C and Objective-C. In the CompassPoint example above, north, south, east and west don't implicitly equal 0, 1, 2 and 3. Instead, the differentenumeration cases are values in their own right, with an explicitly defined type type of CompassPoint
 
 Multiple cases an appear on a single line, seperated by commas:
 */
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

/**
 Each enumeration definition a new type. Like other types in Swift, their names start with ca captial letter. Give enumeration types singular rather than plural names, so that they read as self.evident:
 */

var directionToHead = CompassPoint.west

/**
 The type of 'directionToHead' is inferred when it's initailized with one of the possible values of CompassPoint. Once directionToHead is declared as CompassPoint, you can set it to a different CompassPoint value using a shorter dot syntax
 */

directionToHead = .east

/**
 The type of 'directointoHead' is already known, and so you can drop the type when setting its value. This makes for highly readable code when working with explicitly typed enumeration values.
 
 
    Matching Enumeration Values with a Switch Statement
 You can match individual enumeration values with a 'switch' statement:
 */

directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

/**
 
    Iterating over Enumeration Cases
 For some enumerations, it's useful to have a collection of all of that enuermation's cases. You enable this by writing : "CaseIterable" after the enumeration's name. Swift exposes a collection of all the cases as an 'allCases' property of the enumeration type.
 */

enum Beverage: CaseIterable {
    case coffee, tea, juice
}

let numberOfChoice = Beverage.allCases.count
print("\(numberOfChoice)")

for beverage in Beverage.allCases {
    print(beverage)
}

/**
 The syntax used in the examples above marks the enumeration as conforming to the 'CaseIterable' protocol.
 
 
    Associated Values
 The examples in the previous section show how the cases of an enumeration are a defined value in their own right. You can set a constant or vairable to Planet.erath, and checkfor this value later. However, it's sometimes useful to be able to store values of other types alongside these case values. This additional information is called an associated value, and it varies each time you use that case as a vlaue in your code.
 
 You can define Swift enumerations to store associated values of any given type, and the value types can be different for each case of the enumeration if needed. Enumerations similar to these are known as discirminated union, tagged unions, or variants in other programming languages.
 
 */
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
/**
 This can be read as:
 "Define an enumeration type called 'Barcode', which can take either a value of 'upc' with an associated value of type( Int, Int, Int, Int), or a value of 'qrCode' with an associated value of type 'string'."
 
 This definitoin doesn't provide any actual Int or String vlaues - it just defines the type of associated values that Barcode constants and variables can store when they're equal to 'Barcode.upc' or 'Barcode.qrCode'.
 */

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
// You can assign the same product a different type of barcode:
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

/**
 At this point, the original "Barcode.upc" and its integer values are replaced by the new "Barcode.qrCode" and its string value. Constatns and variables of type Barcode can store either a .uupc or a .qrCode, but they can store only one of them at any given time.
 
 You can check the different barcode types a switch statement. This time, however, the associated values are extracted as part of the switch statement. You extract each associated value as a constant or variable for use within the 'switch' case's body:
 */

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print(numberSystem,
          manufacturer,
          product,
          check)
case .qrCode(let productCode):
    print(productCode)
}


/**
If all of the assoicated values for an enumeration case are extracted as constant, or if all are extracted as variables, you can place a single 'var' or 'let' annotation before the case name, for brevity:
 
 */
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print(numberSystem,
          manufacturer,
          product,
          check)
case let .qrCode(productCode):
    print(productCode)
}


/**
    Raw Values
 The barcode example in Associated Values shows how cases of an enumeration can declare that they store associated values of different types. As an alterantive to associated values, enumeration cases can come prepopulated with default values, which are all of the same type
 */

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

/**
 Here, the raw values for an enumeration called "ASCIIControlCharacter" are defined to be of type 'Character', and are set to some of the more common ASCII control characters. 'Character' values are described in 'Strings and Character'
 
 Raw values can be strings, characters, or any of the integer or floating-point number types. Each raw value must be unique within its enumeration declaration.
 
        Raw values are not the same as associated values. Raw values are set to prepopulated values when you first define the enumeration in your code, like the three ASCII codes above. The raw value for a particular enumeration case is always the same. Associated values are set when you create a new constant or variable based on one of the enumeration's cases, and can be different each time you do so.
 
    
  
 Implicitly Assigned Raw Values
 
 When you're working with enumerations that store integer or string raw values, you don't have explicitly assign a raw value for each case. When you dont' Swift automatically assigns the vlaue for you.
 
 
 
 */




//: [Next](@next)
