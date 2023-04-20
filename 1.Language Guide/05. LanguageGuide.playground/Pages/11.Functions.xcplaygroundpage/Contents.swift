//: [Previous](@previous)
/*: # Functions*/
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

/**
    Closures
 Closures are self-contained block of functionality that can be passed around and used in your code. Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages.
 
 Closues can capture and store reference to any constants and variables from the context in which they're defined. This is known as closing over those constants and variables. Swift handles all of the memory management of capturing for you.
 
 Global and nested functions, as introduced in Functions, are actually sepcial cases of closures. Closures take on of three forms:
 
    - Global functions are closures that have a name and don't capture any values.
    - Nested functions are closure that have a name and can capture valuesform their enclosing function.
    - Closure expression are unnamed closures written in a light weight syntax that can capture values from their surrounding context
 
 Swift's closure expression have a clean, clear style, with optimizations that encourage brief, clutter free syntax in common scenarios. These optimizatoins include:
 
    - Inferring parameter and return value types from context
    - Implicit returns from single-expression closures
    - Shorthand agrument names
    - Trailing closure syntax
 
 
    Closure Expression
 
 Nested functions, as introduced in Nested Functions, are a convenient means of naming and defining self-contained blocks of code as part of larger function. However, it's sometimes useful to write shorter versions of function-like constructs without a full declaration and name. This is particularly true when you work with functions or methods that take functions as one or more of their arguments.
 
 'Closure expressions' are a way to write inline closures in a breif, focuesd syntax. Closure expression provide several syntax optimizations for writing closures in a shorten form without loss of clarity or intent. The closure expression examples below illustrate these optimizations by refining a single example of the sorted(by:) method over several iterations, each of which expresses the same functionality in a more succinct way
 
 
 
    The Sorted Method
 
 Swift's standard library provides a method called 'sorted(by:)', which sorts an array of values of a known type, based on the output of a sorting closure that you provide. Once it competes the sorting process, the sorted(by:) method returns a new array of the same type and size as theold one, with its elements in the correct sorted order. The original array isn't modified by the 'sorted(by:)' method.
 */

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backward2( _ s1: String, _ s2: String ) -> Bool {
    return s1 > s2
}

var reversedNames = names.sorted(by:backward2)

/**
    Closure Expression Syntax
 Closure expression syntax has the following general form:
 
        { ( parameter ) -> return type in
                    statement
        }
 
 
 */
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in  return s1 > s2 })

/**
    Inferring Type Form Context
 Becaus the sorting closure is passed as an argument to a method, Swift can infer the types of its parameters and the type of the value it returns. The 'sorted(by:)' method is being called on an array of strings, so its argument must be a function of type '(String, String) -> Bool'. This means that the '(String, String)' and 'Bool' types don't need to be written as part of the closure expression's definition. Because all of the types can be inferred, the return arrow and the parentheses around the names of the parameters can also be omitted
 */
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 })

/**
 It's always possible to infer the parameter types and return type when passing a closure to a functoin or method as an inline closure expression. As a result, you never need to write an inline closure in it's fullest form when the closure is used as a function or method argument.
 
 Nonetheless, you can still make the types explicit if you wish, and doing so is encouraged if it avoids ambiguiry for readers of your code. In the case of the 'sort(by:)' method, the purpose of the closure is clear from the fact taht sorting is taking place, and it's safe for a reader to assume that the closure is likely to be working with 'String' value, because it's assisting with the sorting of an array of strings.
 
 
    Implicit Returns from Single-Expression Closures
 Single-expression closures can implicitly return the result of their single expression by omitting the return keyword from their declaration, as in this versoin of the previous example:
 */
reversedNames = names.sorted(by:{s1, s2 in s1 > s2})

/**
 Here, the function type of the 'sorted(by:)' method's argument makes it clear that a 'Bool' value must be returned by the closure. Because the closure's body contains a single expression ( s1 > s2 ) that returns a 'Bool' value, there's no ambiguity, and the 'return' keyword can be omitted.
 
 
    Shorthand Argument Names
 Swift automatically provides shorthand argument names to inline closures, which can be used to refer to the values of the closure's arguments by the name $0, $1, $2 and so on.
 
 If you use these shorthand argument names within your closure expression, you can omit the closure's argument list from its definition. The type of the shorthand argument names is inferred from the expected function type, and the highest numbered shorthand argument you use determines the number of arguments that the closure takes. The 'in' keyword can also be omitted, because the closure expression is made up entirely of its body:
 */

reversedNames = names.sorted(by:{ $0 > $1 })

/**
 Here, '$0' and '$1' refer to the closure's first and second 'String' arguments. Because $1 is the shorthand argument with hightest number, the closure is understood to take two arguemnts. Because the 'sorted(by:)' funciton here exprects a closure whose arguments are both string, the shorthand arguments $0 and $1 are both of type 'String'.
 
 
 
    Operator Methods
 There's actually an even shorter way to write the closure expression above. Swift's 'String' tyep defines its string-specific implementation of the grater-than operator (>) as a method that has two parameters of type 'String', and returns a value of type 'Bool'. This exactly matches the method type needed by the 'sorted(by:)' method. Therefore, you can simply pass in the greather-than operator, and Swift will infer that you want to use its string-specific implementation:
 */

reversedNames = names.sorted(by: > )

/**
    Trailing Closures
 If you need to pass a closure expression to a function as the functoin's final argument and the closure expression is long, it can be useful to write it as a trailing closure instead. You write a trailing closure after the function call's parentheses, even though the trailing closure is still an argument to the function. When you use the trailing closure syntax, you don't write the argument label for the first closure as part of the function call. A function call can include multiple trailing closures; however, the first few examples below use a single trailing closure.
 */
func someFunctionThatTakesAClosure(closure: () -> Void) {
    
}

someFunctionThatTakesAClosure(closure: {
    //closure's body goes here
})
someFunctionThatTakesAClosure(){
    //trailing closure's body goes here
}

reversedNames = names.sorted(){ $0 > $1 }
reversedNames = names.sorted{ $0 > $1 }

let digitNames = [ 0:"Zero", 1:"One", 2:"Two", 3:"Three", 4:"Four", 5:"Five", 6:"Six", 7:"Seven", 8:"Eight", 9:"Nine"]
let numbers = [16, 58, 510]

let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
   
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    
    return output
}


/**
 The 'map(_:)' method calls the closure expression once for each item in the array. You don't need to specify the type of the closure's input paramter, 'number', because the type can be inferred from the values in the array to be mapped.
 
 If a function takes multiple closures, you omit the argument label for the first trailing closure and you label the remaining trailing closures. For example, the function below load a picture for a photo gallery:
 */
//func loadPicture( from server: Server, completion: (Picture) -> Void, onFailure: () -> Void) {
//    if let picture = download("photo.jpg", from: server) {
//        completion(picture)
//    } else {
//        onFailure()
//    }
//}
/**
 When you call this function to load a picture, you provide two closures. The first closure is a completion handler that displays a picture after a successful download. The second closure is an error handler that displays an error to the user.
 */

//loadPicture(from: someServer) { picture in
//    someView.currentPicture = picture
//} onFailure: {
//    print("Couldn't download the enxt picture")
//}
/**
 In this example, the 'loadPicture(from:completion:onFailure:)' function dispatches its network task into the background, and calls one of the two completion handlers when network task finishes. Writing the function this way lets you cleanly seperate the code that's responsible for handling a network failure from the code that updates the user interface after a successful download, insted of using just one closure that handles both circumstances.
 
        Completion handlers can become hard to read, especially when you have to nest multiple handlers. An alternate approach is to use asynchronous code
 
 
    Capturing values
 */


//: [Next](@next)
