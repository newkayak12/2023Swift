//: [Previous](@previous)
/*: # Control Flow*/
/**
    For-In Loops
 */
let names = ["Anne", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)")
}

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}

for index in 1...5 {
    print(index)
}
let base = 3
var answer = 1
let power = 10
for _ in 1...power {
    answer *= base
}
print(answer)

/**
 Use the 'stride(from:to:by:) function to skip the unwanted marks.
 */
let minutes = 60
let minuteInterval = 5
for tickMark in stride(from: 0, through: minutes, by: minuteInterval) {
    print(tickMark)
}

/**
 Closed ranges are also available, by using 'stride(from:through:by:)' instead:
 */
let hours = 12
let hourInterval = 3
for tickMake in stride(from: 3, through: hours, by: hourInterval) {
    print(tickMake)
}


/**
    While Loops
 A 'while' loop performs a set of statements until a condition become 'false'.
 
    - while : evaluates its condition at the start of each pass through the loop.
    - repeat-while : evalutates its condition at the end of each pass through the loop
 
 
 1.
    While 'condition' {
        'statement'
    }
 
 
 2. repeat - while loop in Swift is analogous to a do-while in other languages.
    repeat {
        'statement'
    } while 'condition'
 
 
 
 
 
      Conditional Statements
 Swift provides two ways to add conditional branches to your code:  the 'if' statement and the switch statement. Typically, you use the 'if' statement to evaluate simple conditions with only a few possible outcomes. The 'switch' statement is better suited to more complex conditions with multiple possible permutations and is useful in situations where pattern matching can help select an appropriate code branch to execute.
 
 
        If
 */
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}

/**
 
        Switch
 A 'switch' statement considers a value and compares it against several possible matching patterns. It then executes an appropriate block of code, based on the first pattern that matches successfully. A 'switch' statement provides an alternative to the 'if' statement for responding to multiple potentail states.
 
        switch 'some value to consider' {
            case value1:
                respond to value1
            case value2:
                respond to value2
            case value3:
                respond to value3
            default:
                otherwise, do something else
        }
 
 Every 'switch' statement consist of multiple possible cases, each of which begins with the 'case' keyword. In addition to comparing against specific values, Swift provides several ways for each case to specify more complex matching patterns.
 
 
 
        No Implicit Fallthrought
 
 In constrast with 'switch' statements in C and Objective-C, 'switch' statements in Swift don't fall through the bottom of each case and into the next one by default. Instead, the entire 'switch' statement finishes its execution as soon as the first matching 'switch' case is completed, without requring an explicit break statement. This makes the 'switch' statement safer and easir to use than the one in C and avoids executing more than one 'switch' case by mistake.
 
 
        Although 'break' isn't required in Swift, you can use a break statement to match and ignore a particular case or to break out a matched case before the case has completed its execution.
 */
let anotherChar: Character = "a"
switch anotherChar {
case "a":
    break; // 없으면 에러 _ 일부러 명시적으로 break라도 없으면 에러
case "A":
    print("A")
default:
    break;
}
//error: error while processing module import: error: 10.Control Flow.xcplaygroundpage:109:1: error: 'case' label in a 'switch' must have at least one executable statement
/**
 Unlike a 'switch' statement in C, this switch statement doesn't match "a" and "A". Rather, it reports a compile-time error that case "a": doesn't contain any executable statments. This approach avoids accidental fallthrough from one case to another and makes for safer code that's clearer in its intent.
 
        To explicitly fall through at the end of a particular 'switch' case, use the 'fallthrough' keyword
 
 
    Interval Matching
 Values in 'switch' cases can be checked for their inclusion in an interval. This example uses number intervals to provide a natural-language count for numbers of any size:
 */

let approximateCount = 62
let countedThings = "moons oribiting Saturn"
let naturalCount: String

switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings)")

/**
      Tuples
 
 */


