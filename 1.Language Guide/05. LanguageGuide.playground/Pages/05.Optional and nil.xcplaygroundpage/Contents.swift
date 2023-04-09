//: [Previous](@previous)
/*: # Optional & nil*/
/**
 You use 'optionals' in situations where a value may be absent. An optional represents two possibilities: Either ther is a value, and you can unwrap the optional to access that value, or there isn't a value at all
 
 
     ‘The concept of optionals doesn’t exist in C or Objective-C. The nearest thing in Objective-C is the ability to return nil from a method that would otherwise return an object, with nil meaning “the absence of a valid object.” However, this only works for objects—it doesn’t work for structures, basic C types, or enumeration values. For these types, Objective-C methods typically return a special value (such as NSNotFound) to indicate the absence of a value. This approach assumes that the method’s caller knows there’s a special value to test against and remembers to check for it. Swift’s optionals let you indicate the absence of a value for any type at all, without the need for special constants.’
 
 Here's an example of how optionals can be used to cope with the absence of a value. Swift's 'Int' type has an initializer which tires to convert a 'String' value into an 'Int' value. However, not every string can be converted into an integer. the string "123" can be converted into number value 123, but the String "hello Swift" doesn't have an obvious numberic value to convert to.
 
 */
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)

/**
 Because the initalizer might fail, it returns an optional 'Int', rather than an 'Int'. An optional 'Int' isWritten as 'Int?', not 'Int'. The question mark indicates that the value it contains is optinal, meaning that it might contain some 'Int' value, or it might contain 'no value at all'
 
 
    nil
 You set an optional variable to a valueless state by assigning it the special value 'nil':
 */

var serverResponseCode: Int? = 404
serverResponseCode = nil

/**
 If you define an optional variable without providing a default value, the variable is automatically set to 'nil' for you:
 */

var surveyAnswer: String?


/**
    ‘Swift’s nil isn’t the same as nil in Objective-C. In Objective-C, nil is a pointer to a nonexistent object. In Swift, nil isn’t a pointer—it’s
     the absence of a value of a certain type. Optionals of any type can be set to nil, not just object types.’
 
 
 
    If Statmenet and Force Unwrapping
 
 You can use an 'if' to find out whether an optional contains a value by comparing the optinal against 'nil'. You perform this comparison with the "equal to" operator (==) or the "not equal to" operator (!=)
 
 If an optional has a value, it's considered to be "not equal to" nil:
 */

if convertedNumber != nil {
    print("CONTAIN INTEGER VALUE")
}

/**
 Once you're sure that the optional 'does' conain a value, you can access its underlying value by adding an exclamation point (!) to the end of the optional's name The exclamation point effectively says, "I know that this optinal definitely has a value; please use it." This is knwon as force unwrapping of the optional's value:
 */

if convertedNumber != nil {
    print(convertedNumber!)
}

/**
        ‘Trying to use ! to access a nonexistent optional value triggers a runtime error. Always make sure that an optional contains a non-nil value before using ! to force-unwrap its value.’
 
    Optional Binding
 You use optional binding to find out whether an optional contains a value, and if so, to make that value available as a temporary constant or variable. Optional binding can be used with 'if' and 'while' statement to check for a value inside an optional, and to extract that value into constant or variable, as part of a single action. 'if' and 'while' statments are described in more detail in CONTROL FLOW
 
 
        if let constantName = someOptional {
            statments
        }
 
 You can rewrite the possibleNumber example from the Optionals section to use optional binding rather than forced unwrapping:
 */
if let actualNumber = Int(possibleNumber) {
    print("The string \(possibleNumber) has an integer value of \(actualNumber)")
} else {
    print("The string \(possibleNumber) couldn't be converted to an integer")
}


/**
 If you don't need to refer to the original, optional constant or variable after accessing the value it contains, you can use the same name for the new constant or variable:
 */

let myNumber = Int(possibleNumber)
if let myNumber = myNumber {
    print("My number is \(myNumber)")
}


/**
 Because this kind of code is so common, you can use a shorter spelling to unwrap an optional value: write just the name of the constant or variable that you're unwrapping. The enw, unwrapped constant or variable implicitly uses the smae anme as the optional value.
 */

if let myNumber {
    print(myNumber)
}

/**
 You can use both constants and variables with optional binding. If you wnated to manipualte the value of myNumber within the first branch of the 'if' statement, you could wirte 'if var myNumber' instead, and the value conained within the optional would be made available as a variable rather than a constant. Changes you make to 'myNumber' inside the body of the 'if' statment apply only to that local variable, 'not' to the original, optional constant or variable that you unwrapped.
 
 You can include as many optional bindings and Boolean conditions in a single 'if' statment as you need to, seperated by commas. If any of the values in the optional bindings are 'nil' or any Booelan condition evalutates to false, the whole 'if' statment's condition is considered to be false.
 */
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber <= secondNumber && secondNumber < 100 {
    print("PASS")
}

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("PASS")
        }
    }
}

/**
    Implicitly Unwrapped Optional
 As described above, optionals indicate that constant or variable is allowed to have "no value". Optionals can be checked with an 'if' statment to see if a value exist, and can be conditionally unwrapped with optional binding to access the optional's value if it does exist.
 
 Sometimes it's clear from a program's structure that an optional will always have a value, after that value is first set. In these cases, it's useful to remove the need to check and unwrap the optional's value every time it's accessed, because it can be safely assumed to have a value all of the time.
 
 These kind of optionals are defined as implicilty unwrapped optionals. You write an implicitly unwrapped optaionl by placing an exclamation point (String!) rather than a question mark (String?) after the type that you want to make optional. Rather than placing an exclamation point afte the optional's name when you use it, you place an excalmation point after the optional's type when you decalre it.
 
 Implicilty unwrapped optionals are useful when an optional's value is confirmed to exist immediately after the optional is first defined and can definitely be assumed to exist at every point thereafter. The primary use of implicitly unwrapped optional in Swift is during class initialization, as described in "Unowned References and Implicitly Unwrapped Optional Properties."
 
 An implicitly unwrapped optional is a normal optional behind the scenes, but can also be used like a non-optional value. without the need to unwrap the optional value each time it's accessed. The following exmaple show the differene in behavior between an optional string and an implicitly unwrapped optional string when accessing their wrapped value as an explicit String:
 */

let possibleString: String? = "An Optional String"
let forcedString: String = possibleString!

let assumedString: String! = "An implicitly unwrapped optional string"
let implicitString: String = assumedString

/**
 You can think of an implicitly unwrapped optional as giving permission for the optional to be for-unwrapped if needed. When you use an implicitly unwrapped optional value, Swift first tires to use it as an oridinary optional value; if it can't be used as an optional, Swift force-unwraps the value. In the code above, the optional value 'assumedString' is force-unwrapped before assigning its value to implicitString because 'implicitString' has an explicit, non-optional type of 'String' Incode below, 'optionalString' doesn't have an explicit type so it's an oridinary optional.
 */

let optionalString = assumedString
//The type of optionalString is "String?" and assumedString isn't force-unwrapped.

/**
 If an implicitly unwrapped optional is 'nil' and you try to access its wrapped value, you'll trigger a runtime error. The result is exactly the same as if you place an exclamation point a normal optional that doesn't contain a value.
 */

if assumedString != nil {
    print(assumedString)
}

if let definiteString = assumedString {
    print(definiteString)
}

/**
    ‘Don’t use an implicitly unwrapped optional when there’s a possibility of a variable becoming nil at a later point. Always use a normal optional type if you need to check for a nil value during the lifetime of a variable.’
 
 
    Error Handling
 You use 'error handling' to respond to error conditions you program may encounter during execution.

 In constrast to optionals, which can use the presence or absence of a value to communicate success or failure of a function, error handling allows you to determine the underlying cause of failure, and, if necessary, propagate the error to another part of your program.
 
 When a function encounters an error condition, it 'throw' an error. That function's caller can then 'catch' the error and repond appropriately.
 */

func canThrowAnError() throws {
    // this function may or may not throw an error
}

/**
 A function indicates that it can throw an error by including the 'throws' keyword in its declaration. When you call a function that can throw an error, you prepend the try keyword to the expression.
 */

do {
    try canThrowAnError()
    //no error was thrown
} catch {
    //an error was thrown
}

/**
 A 'do' statement creates a new containing scope, which allows errors to be propagated to one or more catch clauses. Here' an example of how error handling can be used to respond to different error conditions:
 
         func makeASandwich() throws {
         //...
         }
         
         do {
            try makeASandwich()
            eatASandwitch()
         } catch SandwichError.outOfCleanDishes {
            washDishes()
         } catch SandwitchError.missingIngredients( let ingredients ) {
            buyGroceries(ingredients)
         }
 
 
 
 */






//: [Next](@next)
