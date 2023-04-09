//: [Previous](@previous)
/*: # Numeric Type Conversion*/
/**
 Use the int type for all general-purpose integer constants and variables in your code, even if they're known to be nonnegative. Using the default integer type in every day situations means that integer constants and variables are immediately interoperable in your code and will match the inferred type for integer literal values.
 */



/**
    Integer Conversion
 
The range of numbers that can be stored in an integer constant or variable is different fro each numeric type. An Int8 constant or vairable can store nubers between -128 to 127, whereas a UInt8 constant or variable can store numbers between 0 and 255. A number that won't fit into constant or variable of a sized integer type is reported as error when your code is compied:
 */

//let cannotBeNegative: UInt8 = -1
// UInt8 can't store negative number, and so this will report an error

//let tooBig: Int8 = Int8.max + 1
// Int8 can't store a number larger than its maximum value, and so this will report and error

/**
Because each numeric type can store a different range of values, you must opt in to numeric type conversion on a case-by-case basis. This opt-in approach prevents hidden conversion errors and helps make type conversion intentions explicit in your code.
 
To convert one specific number type to another, you initialize a new number of the desired type with the exisiting value. In the example below, the constant 'twoThousand' is of type 'UInt16', whereas the constant one si of type UInt8. They can't be added togerther directly, because they're not of the same type. Instead, this example call 'UInt16(one)' to create a new UInt16 initialized with the value of 'one', and uses this value in place of the original:
 */

let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)

/**
 Because both sides of the addition are now of type UInt16, the addition is allowed. The output constant (twoThousnadAndOne) is inferred to be of type UInt16, because it's the sum of two Uint16 values.
 
 Sometype(ofInitialValue) is the default way to call the initializer of a Swift type and pass in an initial value. Behind the scenes, 'UInt16' has an initializer that accepts a UInt8 value, and so this initializer is used to make a new 'UInt16' from an existing UInt8. You can't pass in any type here, however-it has to be a type for which 'UInt16' provides an initializer. Extending existing type to provide initializers that accept new types (including you own type definitions) is covered in Extensions.
 
 
    Integer and Floating-Point conversion
 Conversions between integer and floating-point numeric types must be made explicit:
 */
let three = 3;
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine

/**
 Here, the value of constant three is used to create a new value of type Double, so that both sides of the addition are of the same type. Without this conversion in place, the addition would not be allowed.
 
 Floating-point to integer conversion must also be made explicit. An integer type can be initialized with a 'Double' or 'Float' value:
 */

let integerPi = Int(pi)

/**
 Floating-point values are always truncated when used to initalize a new integer value in the way. This means that 4.75 becomes 4, and -3.9 becomes -3.
*/


//: [Next](@next)
