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

/**
 Use a tuple to make a compund value-for example, to return multiple values from a functoin the elements of a tuple can be referred to either by name or by number.
 */

func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum:Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        
        sum += score
    }
    
    return (min, max, sum)
}

let statistics = calculateStatistics(scores: [5,3,100,3,9])
print(statistics.sum)
print(statistics.2)


/**
Functions can be nested. Nested functions have access to variables that were decalred in the outer function You can use nested functions to organize the code in a function that's long or complex.
 */

func returnFifteen() -> Int {
    var y = 10;
    func add () {
        y += 5
    }
    add()
    
    return y
}

returnFifteen()


/**
 Functions are a first-class type. This mean that a function can return another function as its value.
 */

func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    
    return addOne
}

makeIncrementer()(10)
var increment = makeIncrementer()
increment(7)

/**
 A function cna take another function as one of its argument
 */

func hasAnyMatches( list: [Int], condition: (Int) -> Bool ) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    
    return false
}

func lessThanThen(number: Int) -> Bool {
    return number < 10
}

var numbers = [20, 19, 7, 12]
hasAnyMatches(list: numbers, condition: lessThanThen)


/**
 Functions are actually a special case of closures : block of code that can be called later. The code in a closure has
 access to things like vaiables and functions that were available in the scope where the closure was create, even if the closure is in a different scope when it's exectued (nested function above) you can write a closure without a name by surrounding code with braces({})
 */

numbers.map({ (number: Int) -> Int in
    let result = 3 * number
    return result
});

numbers.map{
    if $0.isMultiple(of: 2) {return $0}
    return 0
}
numbers.map({ (number: Int) -> Int  in
    if number.isMultiple(of: 2) { return number }
    else { return  0 }
})

/**
 You have several options for wirting closures more concisely. When a closure's type is already konown, such as the callback for a delegate, you can omit the type of its parameters, its return type, or both. Single statement closure implicitly return the value of their only statement
 */


let mappedNumbers = numbers.map({number in 3 * number})
print(mappedNumbers)


/**
 You can refer to parameters by number instead of by name - this approach is especially userful in very short closures.
 A closure passed as the last argument to a function can appear immediately after the parentheses. When a closure is the only argument to a function, you can omit the parentheses entirely.
 */
let sortedNumbers = numbers.sorted{ $0 > $1 }
print(sortedNumbers)





//: [Next](@next)
