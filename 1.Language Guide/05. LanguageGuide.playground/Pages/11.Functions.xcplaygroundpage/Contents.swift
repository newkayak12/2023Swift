//: [Previous](@previous)
/*: # Functions*/
import Foundation

/**
 Functions are self-cotained chunks of code that perform a specifc task. You give a function a name that identifies what it does, and this name is used to 'call' the function to perform its task when needed.
 
 Swift's unified function syntax is flexible enough to express anything from a simple C-style function with no parameter names to a complex Objective-C-sytle method with naes and argument labels for each parameter.
 
 
 
    Function case
 
 1. Function without Parameters
    func sayHelloWorld () -> String { return "helloWorld" }
 
 2. Function with Multiple Parameters
    func greet(person: String, alreadyGreeted: Bool) -> String { return "Hello" }
 
 3. Function with Multiple Return Value
    func minMax(array: [Int]) -> (min: Int, max: Int) {
        var currentMin = array[0]
        var currentMax = arrya[0]
 
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
 
 
        return (currentMin, currentMax)
    }
 
 4. Optional Tuple Return Type
If the tuple type to be returned from a function has the potential to have "no value" for the entire tuple, you can use an optional tuple return type to reflect the fact taht the entire tuple can be 'nil'. You write an optional tuple return type by placing a questionmark after the tuple type's closing parenthesis, such as (Int, Int)? or (String, Int, Bool)?.
 
 5. Function With an Implicit Return
    func greeting( for person: String ) -> String {
        return "Hello \(person) !"
    }
 
 
 
    Function Argument Labels and Parameter Names
 Each function parameter has both an 'argument label' and a 'parameter name'. The argument label is used when calling the function; each argument is written in the function call with its argument label before it. The parameter name is used in the implementation of the function. By default, parameters use their parameter name as their argument label.
 */

func someFunction(firstParameterName: Int, secondParameterName: Int) {
    
}
/**
 All parameters must have unique names. Although it's possible for multiple parameters to have the same argument label, unique argument labels help make your code more readable.
 
    Specifying Argument Labels
 You write an argument label before the parameter name, sepearated by a space:
 */

func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)! Glad you could visit from \(hometown)"
}

/**
 The use of argument labels can allow a function to be called in an expressive, sentence-like manner, while still providing a function body that's readable and clear in intent.
 
    Omitting Argument Labels
 If you don't want an argument label for a parameter, write an underscore instead of an explicit argument label for that parameter
 */
func someFunction2( _ firstParameterName: Int, seconParameterName: Int ) {
    
}

/**
 If a parameter has an argument label, the argument must be labeled when you call the function.
 
    Default Parameter Values
 You can define a default value for any parameter in a functino by assigning a value to the parameter after that parameter's type. If a default value is defined, you can omit that parameter when calling the function.
 */

func someFunction3( parameterWithoutDefault: Int, parameterWithDefault: Int = 12 ) {
    print(parameterWithoutDefault, parameterWithDefault)
}

someFunction3(parameterWithoutDefault: 1)

/**
 
    Variadic Parameters
 A 'variadic parameter' accepts zero or more values of a specified type. You use a variadic parameter to specify that the parameter can be passed a varying number of input values when the function is called. Write variadic parameters by inserting three period characters (...) after the parameter's type name.
 
 The values passed to variadic parameter are made available within the function's body as an array of the appropriate type. For example, a variadic parameter with a name of numbers and a type of Doube... is made available withing the function's body as a constant array called numbers of type [Double].
 */
func arithmeticMean( _ numbers: Double... ) -> Double {
    var total: Double = 00
    for number in numbers {
        total += number
    }
    
    return total / Double(numbers.count)
}
arithmeticMean(1.2, 1.9, 12, 0.1)

/**
 A function can have multiple variadic parameters. The first parameter that comes after a variadic parameter must have an argument label. The argument label makes it unambiguous witch arguments are passed to the variadic parameter and which arguments are passed to the parameters that come after the variadic parameter.
 
 
    In-Out Parameters
 Function parameters are constants by default. Trying to change the value of a function parameter from within the body of that function result in a compile-time error. This means that you can't change the value of a parameter by mistake. If you want a function to modify a parameter's value, and you want those changes to persist after the function call has ended, define that parameter as an 'in-out parameter' instead.
 
 You write an in-out parameter by placing the 'inout' keyword right before a parameter's type. An in-out parameter has a value that's passed in to the function, is modified by the function, and is passed back out of the function to replace the original value. For a detailed discussion of the behavior of in-out parameters and associated compiler optimization
 
 You can only pass a variable as the argument for an in-out parameter. You can't pass a constant or a literal value as the argument, becuase constants and literals can't be modified. You place an ampersand(&) directly before a variable's name when you pass it as an argument to an in-out parameter, to indicate that it can be modified by the function.
 
        In-out parameters can't have default values, and variadic parameters can't be marked as inout.
 */

func swapTwoInts( _ a: inout Int, _ b : inout Int ) {
    let tempararyA = a;
    a = b
    b = tempararyA
}

var someInt = 3
var anotherInt = 108
swapTwoInts( &someInt, &anotherInt )

print(someInt, anotherInt)

/**
 
        Function Types
 Every function has a specific 'funtion type', made up of the parameter types and the return type of the function.
*/
func addTwoInts( _ a: Int, _ b: Int ) -> Int {
    return a + b;
}
/**
    Using Function Type
 You use function types just like any other types in Swift. For example, you can define a constant or variable to be of a function type and assign an appropriate function to that variable:
 */
var mathFunction: ( ( Int, Int ) -> Int ) = addTwoInts

/**
    Function Types as Parameter Types
 You can use a function type such as (Int, Int) -> Int as a parameter type for another function. This enables you to leave some aspects of a function's implementation for the function's caller to provide when the function is called.
 
 */

func printMathResult( _ mathFunction: ((Int, Int) -> Int), _ a: Int, _ b: Int ) {
    print("Result \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)


/**
    Function Types as Return Types
 You can use a function type as the return type of another function. You do this by writing a complete function type immediately after the return arrow( -> ) of the returning function.
 */
func stepForward( _ input: Int ) -> Int {
    return input + 1
}
func stepBackward( _ input: Int ) -> Int {
    return input - 1
}

func chosseStepFunction( backward: Bool ) -> ( (Int) -> Int ) {
    return backward ? stepForward : stepBackward
}

/**
    Nested Functions
 All of the functions you have encountered so far in this chapter have been examples of global function, which are defined at a global scope. You can define functions inside the bodies of other functions, known as nested functions.
 
 Nested functions are hidden from outside world by default but can still be called and used by their enclosing function An enclosing function can aloso return one of its nested functions to allow the nested function to be used in another scope.
 
 */

func chooseStepFunctionNested( backward: Bool ) -> ( (Int) -> Int ) {
    func stepForward( input: Int ) -> Int { return input + 1 }
    func stepBackward( input: Int ) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}

chooseStepFunctionNested( backward: false ) ( 2 )

//: [Next](@next)
