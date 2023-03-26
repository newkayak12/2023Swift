//: [Previous](@previous)
import Foundation
/*: # Functions and Closures*/
/**
 Use func to declare a function. call a funtion by following its name with a list of argument in parentheses. Use '->' to seperate the parameter names and types from the function's return type.
 
 
 */

func greet( person : String, day: String ) -> String {
    return "Hello \(person), today is \(day)"
}

greet(person: "Bob", day: "monday")

/**
 By default, function use their parameter name as labels for their arguments. Write a custom argument label before the parameter name, or write '_' to use no argument label
 */

func greet2( _ person: String, on day: String ) -> String {
    return "Hello \(person), today is \(day)"
}

greet2("John", on: "Wednesday")



//: [Next](@next)
