//: [Previous](@previous)
/*: # Method*/
/**
 Methods are function that are associated with a particular type. Classes, structures, and enumerations can all define instance methods ...
 
 The fact that structures and enumeration can define methods in Swift is a major difference from C and Objective-C.
 
 
    Instance Method
 */
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
/**
    The self Property
 Every instance of a type ahs an implicit property called self, which is exactly equivalent to the instance itself. You use the self property to refer to the current instance within its own instance methods.
 */

extension Counter {
    func decrement() {
        self.count -= 1
    }
}
/**
 Swift assumes that you referring to a property or method of the current instance whenever you use a known property or method name within a method.
 
 The main exception to this ruls occurs when a prameter anme for an instance method has the same name as a property of that instance. In this situtation, the parameter name takes precedence, and it becomes necessary to refer to the property in a more qualified way.
 */

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}

var somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0){
    print("right")
}
/**
 Without the self prefix, Swift would assume that both uses of x referred to the method parameter called 'x'.
 
 
    Modifying Value Types from Within Instance Methods
 Structures and enumerations are value types. By default, the properties of a value type can't be modified from within its instance method
 
 However, if you need to modify the properties of your structure or enumeration within a particular method, you can opt in to 'mutating' behavior for that method. The method can then mutate its properties from within the method, and any changes that it makes are written back to the original structure when the method ends. The method can also assign a completely new instacne to its implicit 'self' property, and this new instance will replace the existing one wehn the method ends
 */

extension Point {
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
somePoint.moveBy(x: 2.0, y: 3.0)
print(somePoint.x, somePoint.y)

/**
 Note that you can't call a mutating method on a constant of structure type, because its properties can't be changed.
 
 
    Assigning to self Within a Mutating Method
 Mutating methods can assign an entirely new instance to the implicit self property.
 */

extension Point {
    mutating func MoveTo( x deltaX: Double, y deltaY: Double) {
        self = Point(x: deltaX, y: deltaY)
    }
}
somePoint.MoveTo(x: 1.0, y: 1.0)
/**
 Mutating methods for enumerations can set the implicit self parameter to be a different case from the same enumeration:
 
 */

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
            case .off:
                self = .low
            case .low:
                self = .high
            case .high:
                self = .off
        }
    }
}
var oven = TriStateSwitch.low
oven.next()
oven.next()


/**
    Type Methods
 Instance methods, as described above, are methods that you call on an instance of a particular type. You can also define methods that are called on the type itself. These kinds of methods are called type methods. You indicate type methods by writing the static keyword before the method's func keyword. Classes can use the 'class' keyword instead, to allow subclasses to override the superclass's implementation of that method.
 */
class SomeClass {
    class func someTypeMethod() {
        print(self)
    }
}
SomeClass.someTypeMethod()

/**
 Within the body of a type method, the implicit self property refers to the type itself, rather than an instance of that type. This means that you can use self to disambiuate between type proeprties and type method parameters, just as you do for instance properties and instance mehtod parameters.
 
 More generally, any unqualified method and proeprty names that you use within the body of a type method will refer to other type-level methods and properties. A type method can call another type method with the other mehtod's name, without needing to prefix it with the type name. Similarly, type methods on structures and enumerations can access type properties by using the type property's name withoud a type name prefix.
 */

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock( _ level: Int ) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level}
    }
    static func isUnlocked( _ level: Int ) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult //ignore the return value,
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    
    func complete( level: Int ){
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    
    init(name: String) {
        playerName = name
    }
}




//: [Next](@next)
