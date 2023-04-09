//: [Previous](@previous)
/*: # Assertions and Preconditions*/
/**
 Assertions and Preconditions are checks that happen at runtime. You use them to make sure an essential condition is satisfied before executing any futher code. If the Boolean condition in the assertion or precondition evaluates to true, code execution continues as usual. If the condition evaluates to false,
 the current state of the program is invalid; code execution ends, and your app is terminated.
 
 You use assertions and preconditions to express the assumptions you make and the expectations you have while coding, so you can include them as part of your code. Assertions help you find mistakes and incorrect assumptions during development, and preconditions help you detect issues in production.
 
 In addition to verifying your expectations at runtime, assertions and preconditions also become a useful form of documentation within the code. Unlick the error conditions discussed in Error Handling above, assertions and preconditions arne't used for recoverable or expected errors. Because a failed assertion or precondition indicates an invalid program state, there's no way to catch a failed assertion.
 
 Using assertions and preconditions ins't a substitue for designing you code in such a way taht invalid conditions are unlikely to arise. However, using them to enforce valid data and state causes you app to terminate more predictably if an invalid state occurs, and helps make the problem easier to debug. Stopping execution as soon as an invalid state is detected also helps limit the damage caused by that invalid state.
 
 The different between assertion and preconditions is in when they're checked: Assertions are checked only in debug builds, bue preconditions are checked in both debug and productoni builds. In production builds, the condition inside an assertion isn't evaluated. The means you can use as manay assertions as you want during your development process, without impacting performance in production.
 
    Debugging with Assertions
 You write an assertion by calling the 'assert(_:_:file:line:)' function from the Swift standard library. You pass this function an expression that evaluates 'true' or 'false' and message to display if the result fo the condition is false
 */

let age = 3
assert(age >= 0, "A person's age can't be less than zero")

let age2 = -1
//assert(age2 >= 0, "A person's age can't be less than zero")
//__lldb_expr_5/06.Assertions and Preconditions.xcplaygroundpage:23: Assertion failed: A person's age can't be less than zero
//Playground execution failed:

/**
 You can omit the assertion message
 */
//assert(age2 >= 0)

/**
 If the code already checks the condition, you use the 'assertionFailure(_:file:line:)' function to indicate that an assertion has failed.
 */

if age2 > 10 {
    print("larger than 10")
} else if age2 >= 0 {
    print("larger than 0")
} else {
//    assertionFailure("FAIL")
    //__lldb_expr_11/06.Assertions and Preconditions.xcplaygroundpage:41: Fatal error: FAIL
}

/**
    Enforcing Preconditions
 Use a precondition whenever a condition has the potential to be false, but must definitely be true for your code to continue execution. For example, use a precondition to check that a subscript isn't out of bounds, or to check that a functino has been passed a valid value.
 
 You write a precondition by calling the 'precondition(_:_:file:line:)' function You pass this function an expression that evalutates to 'true' or 'false' and a message to display if the result of the condition is false
 */

//In the implementation of a subscript
let index = -1
precondition(index > 0, "Index must be greater than zero.")

/**
 You can also call the 'preconditionFailure(_:file:line:)' function to indicate that a failure has occuerred-for example, if the default case of a switch was taken, but all valid input data should have been handled by one of the switch's other case
 
    ‘If you compile in unchecked mode (-Ounchecked), preconditions aren’t checked. The compiler assumes that preconditions are always true, and it optimizes your code accordingly. However, the fatalError(_:file:line:) function always halts execution, regardless of optimization settings.
    
    You can use the fatalError(_:file:line:) function during prototyping and early development to create stubs for functionality that hasn’t been implemented yet, by writing fatalError("Unimplemented") as the stub implementation. Because fatal errors are never optimized out, unlike assertions or preconditions, you can be sure that execution always halts if it encounters a stub implementation.’
 
 */


//: [Next](@next)
