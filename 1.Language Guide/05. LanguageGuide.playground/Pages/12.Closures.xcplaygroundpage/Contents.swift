//: [Previous](@previous)
/*: # Closures*/


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
 A closure can capture constants and variables from the surronding context in which it's defined. The closure can then refer to and modify the values of those constants and variables from within its body, even if the original scope that defined the constants and variables no longer exists.
 
 In Swift, the simplest form of a closures that can capture values is a nested function, written within the body of another function. A nested function can captrue any of its outer function's arguments and can aloso capture any constants and variables defined within the outer function.
 
 */

func makeIncrementer( forIncrement amount: Int ) -> ( () -> Int ) {
    var runningTotal = 0;
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    
    return incrementer
}

/**
 The return type of makeIncrementer is () -> Int. This means that it returns a function, rather than a simple value. the function it returns has no parameters, and returns an Int value each time it's called.
 
 The 'makeIncrementer(forIncrement:) function defines an integer variable called runningTotal, to store the current running total of the incrementer that will be returned. This variable is initialized with a value of 0
 
 The 'makeIncrementer(forIncrement:) function has a single Int parameter with an argument label of 'forIncrement', and a parameter name of amount. The argument value passed to this parameter specifies how much 'runningTotal' should be incremented by each time the returned incrementer function is called. The makeIncrmenter function defines a nested function called incrementer, which performs the actual incrementing. This function simply adds 'amount' to 'runningTotal', and returns the result.
 
 func incrementer() -> Int {
 runningTotal += amount
 
 return runningTotal
 }
 
 The 'incrementer()' function doesn't have any paramters, and yet it refers to 'runningTotal' and 'amount' from within its function body. It does this by capturing a 'reference' to 'runningTotal' and 'amount' from the surrounding function and using them within its own funciton body.
 Capturing by reference ensures that 'runningTotal' and 'amount' don't disappear when the call to 'makeIncrementer' ends, and also ensures that 'runningTotal' is available the next time incrementer function is called.
 
 As an optimization, Swift may instead capture and store a copy of a value if that value isn't mutated by a closure, and if the value isn't mutated after the closure is created.
 
 Swift also handles all memory management invloved in disposing of variables when they're no longer needed.
 
 
 */
let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()
/**
 Calling the original incrementer(incrementByTen) again continues to increment its own 'runningTotal' variable, and doesn't affect the variable captured by 'incrementBySeven';
 */
incrementByTen()
/**
 If you assign a closure to a property of a class instance, and the closure that instance by referring to the instance or its members, you will create a strong reference cycle between the closure and the instance. Swift uses captrue lists to break these strong reference cycles
 
 
 Closures Are Reference Types
 
 
 In the example above, 'incrementBySeven' and incrementByTen' are constants, but the closures these constants refer to are still able to increment the 'runningTotal' variables that they have captured. This is because functions and closures are reference types.
 
 Whenever you assign a function or a closure to a constant or a variable, you are actually setting that constant or variable to be a 'reference' to the function or closure. Int the example above, it's the choice of closure that 'incrementByTen' refers to that's constant, and not the contents of the closure itself.
 
 This aloso means that if you assign a closure to two different constants or variables, both of those constants or variables refer to the same closure.
 */

let otherByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
otherByTen()

/**
 The example above shows that calling 'otherByTen' is the same as calling 'incrementByTen.' Because both of them refer to the same closure, they both increment and return the same running total.
 
 
 Escaping Closures
 A closure is said to 'escape' a function when the closure is passed as an argument to the function, but is called after the function returns. When you decalre a function that takes a closure as one of its parameters, you can write '@escaping' before the parameter's type to indicate that the closure is allowed to escape.
 
 One way that a closure can escape is by being stored in a variable that's defined outside the function. As an example, many functions that start an asynchronous opertaion take a closure argument as a completion handler. The function returns after it starts the operation, but the closure isn't called until the operation is completed - the closure needs to escape, to be called later.
 */
var completionHandlers: [ () -> Void ] = []
func someFunctionWithEscapingClosure( completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

/**
 The someFunctionWithEscapingClosure(_:) function takes a closure as its argument and adds it to an array that's declared outside the function. If you didn't mark the parameter of this function with '@escaping', you would get a compile-time error.
 
 An escaping closure that refers to 'self' needs special consideration if 'self' refers to an instance of a class. Capturing 'self' in an escaping closure makes it easy to accidentally create a strong reference cycle.
 
 Normally, a closrue captures variables implicitly by using tem in the body of the closure, but in this case you need to be explicit. If you want to capture 'self', write 'self' explicitly when you use it, or include 'self' in the closure's capture list. Writing 'self' explicitly lets you express your intent, and reminds you to confirm that there isn't a reference cycle.
 */
func someFunctionWithNonescapingClosure( closure: () -> Void ) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure {
            self.x = 100
        }
        someFunctionWithNonescapingClosure {
            x = 200
        }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)

/**
 Here's a version of 'doSomething()' taht captures 'self' by including it in the closure's capture list, and then refers to self implicitly
 */


class SomeOtherClass {
    var x = 10
    func doSomething(){
        someFunctionWithEscapingClosure {
            [self] in x = 100
        }
        someFunctionWithNonescapingClosure {
            x = 200
        }
    }
}
/**
 If 'self' is an instance of a structure or an enumeration, you can always refer to 'self' implicitly. However, an escaping closure can't capture a mutable reference to 'self' when 'self' is an instance of a structure or an enumeration.
 Structures and enumerations don't allow shared mutabiliy,
 */

struct SomeStruct {
    var x = 10
    mutating func doSomeThing() {
        someFunctionWithNonescapingClosure {
            x = 200
        }
        //        someFunctionWithEscapingClosure { //Escaping closure captures mutating 'self' parameter
        //            x = 200
        //        }
    }
}

/**
 The call to the 'someFunctionWithEscapingClosure' function in the example above is an error because it's inside a mutating method, so 'self' is mutable. Taht vilates the rule taht escaping closures can't capture a mutable reference to self for structures. **
 
 
    AutoClosures
 An 'autoclosure' is a closure that' automatically create to wrap an expression that's being passed as an argument to a function. It doesn't take any arguments, and when it's called, it return the value of the expression that's wrapped inside of it This syntatic convenience lets you omit braces around a function's parameter by writing a normal expression instead of an explicit closure.
 
 It's common to call functions that take autoclosures, but it's not common to implment that kind of function.
 
 An autoclosure lets you delay evalutaion, becuase the code inside isn't run until you call the closure. Delaying evaluation is useful for code that has side effects or is comptationlly expensive, because it lets you control when that code is evaluated
 */


var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)


let cusomterProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)

print("Now serving \(cusomterProvider())")
print(customersInLine.count)

/**
 Even though the first element of the cusomersInLine array is removed by the code insde the closure, the array element isn't removed until the closure is actually called. If the closure is never called, te expression inside the closure is never evalutated, which means the array element is never removed
 
 You get the same bhavior of delayed evalutaion when you pass a closure as a argument to function
 */
func serve( customer customerProvider: (() -> String)) {
    print("Now serving \(cusomterProvider())")
}

serve(customer: {customersInLine.remove(at: 0)})
print(customersInLine.count)

/**
 The 'serve(customer:)' function in the listing above takes an explicit closure that return a customer's name. the version of 'serve(customer:)' below performs the same operation but, instead of taking an explicit closure, it takes an autoclosure by marking its parameter's type with the '@autoclosure' attribute. Now you can call the function as if it took a 'string' arugment instead of a closure. The argument is automatically converted to a closure, because the 'customerProvider' parameter's type is marked with the '@autuoclosure' attribute
 */
func serve2( customer customerProvider: (@autoclosure () -> String)) {
    print("Now serving \(cusomterProvider())")
}

serve2(customer: customersInLine.remove(at: 0))
print(customersInLine.count)

/**
        Overusing autoclosures can make you code hard to understand. The context and function name should make it clear that evalutating is being deffered
 */
        
//: [Next](@next)
