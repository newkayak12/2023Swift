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
 
 You can use tuples to test multiple values in the same switch statement. Each element of the tuple can be tested against a differenct value or interval of values. Alternatively, use the underscore, also known as the wildcard pattern, to match any possible value.
 */
let somePoint = (1, 1)
switch somePoint {
    case (0, 0):
        print("ORIGIN")
    case (_, 0):
        print("It's on X-axis")
    case (0, _):
        print("It's on Y-axis")
    case (-2...2, -2...2):
        print("Inside the box")
   default:
        print("Outside the box")
}


/**
    Value Bindings
 
 A switch case can name the value or values it matches to temporary constants or variables, for use in the body of the case. This behavior is knwon as 'value binding', because the values are bound to temporary constant or variables within the case's body.
 */
let anotherPoint: (Int, Int) = (2, 0)
switch anotherPoint {
    case (let x, 0):
        print("X \(x) Y 0")
    case (0, let y):
        print("X 0 Y \(y)")
    case let (x, y):
        print("X \(x) Y \(y)")
}

/**
    Where
 A 'switch' case can use a 'where' clause to check for additional conditions.
 */

let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
    case let (x, y) where x == y:
        print("\(x) == \(y)")
    case let (x, y) where x == -y:
        print("\(x) == \(y)")
    case let (x, y):
        print("\(x), \(y)")
}


/**
    Compound Cases
 Multiple switch cases that share the same body can be combined by writing several pattern after 'case', with a comma between each of the patterns. If any of the patterns match, then the case is considered to match. The patterns can be written over multiple lines if the list is long.
 
 */
let someChar: Character = "e"
switch someChar {
    case "a", "e", "i", "o", "u":
        print("vowel")
    case "b", "c", "d", "f", "g", "h", "j", "k", "m", "n", "p",
        "q", "r", "s", "t", "v", "w", "x", "y", "z":
        print("consonant")
    default:
        print("")
}
/**
 Compound cases can aloso include value bindings. All of the patterns of a compound case have to inlcude the same set of value bindings, and each binding has to get a value of the same type from all of the patterns in the compund case. This ensures that, no matter which part of the compound case matched, the code in the body of the case can always access a value for the bindings and that the value always has the same type.
 
    
    Control Transfer Statements
 Control transfer statement change the order in which your code is executed, by transferring control from one piece of code to another. Swift has five control transfer statements:
 
    - continue
    - break
    - fallthrough
    - return
 
    - Labeled Statement ->
         'label name': while 'condition' {
                statements
          }
 
    - Early Exit ->
         A 'guard' statement, like an if statment, executes statments depending on the Boolean value of an expression. You use a 'guard' statement to require that a condition must be true in order for the code after the 'guard' statement to be executed. Unlike an if statement, a 'guard' statement always has an else clause-the code inside the else clause is executed if the condition isn't true.
 
    - Checking API Availabilty ->
         Swift has built-in support for checking API availability, which ensures that you don't accidentally use APIs that are unavailable on a given deployment target
 
            if #available ( platform name version, ..., *) {
                statements to execute if the APIs are available
            } else {
                fallback statements to execute if the APIs are unavailable
            }
 */

if #available (macOS 10.12, *) {
    print("osx 10.12 later")
} else {
    print("other")
}

@available (macOS 11.0, *) //requires macOs 11.0 or later
struct ColorPreference {
    var betsColor = "blue"
}

/**
    - throw
    
 */
