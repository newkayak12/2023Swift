//: [Previous](@previous)
/*: # Properties*/
/**
    Properties
 Proeprties associate value with a particular class, structure, or enumeration. Stored properties store constant and variable values as part of an instance, whereas computed proeprties calculate a value. Computed properties are provided by classes, structures, and enumerations. Stored proeprties are provideed only by classes and structures.
 
 Stored and computed properties are usually associated with instances of a particular type. However, properties can also be associated with the type itself. Such properties are knwon as type properties.
 
 In addition, you can define property observer to monitor changes in property's value, which you can respond to with custom actions. Property observer can be added to stored properties you define youself, and also to properties that a subclass inherits from its superclass.
 
 You can also use a property wrapper to reuse code in the getter and setter of multiple properties.
 
 
    Sttored Properties
 In its simplest form, a stored proeprty is a constant or variable that's stored as part of an instance of a particular class or structure. Stored proeprties can be either variable stored proeprty or constant stored properties
 
 You can provide a default value for a stored property as part of its definition, as described in 'Default Property Values'. You can aloso set and modify the initial value for a stored property during initialization.
 
 The example below defines a structure alled FixedLengthRange, which describes a range of intergers whose range length can't be changed after it's created:
 
 */

struct FixedLengthRange {
    var firstValue: Int
    var length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
/**
 Instance of FixedLengthRage have a variable stored property called firstValue and a constant stored property called length. In the example above, length is initialized when the new range is created and can't be cha ged therafter, because it's a constant property
 
 
    Lazy Stored Properties
 A lazy stored proeprty is a property whose initial value isn't calculated until the first time it's used. You indicate a lazy stored property by writing the lazy modifier before its declaration
 
        You must always decalre a lazy property as a variable, because its initial value might no be retreived until after instance intialization completes. Constant properties must always have a value before initialization completes, and therefore can't be decalred as lazy
 
 Lazy proeprties are useful when the initial value for a property is dependent on outsiede factors whose value aren't known until after an instance's initializatoin is complete. Lazy properties are also useful when the inital value for a property requires complex or computationally expensive setup that shouldn't be performed unless or until it's needed.
 
 The exampel below uses a lazy stored prorperty to avoid unnecessary initialization of a complex class. This example defines two classes called DataImporter and DataManager, neither of which is shown in full:
 */

class DataImporter {
    var fileName = "data.txt"
}
class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
}

let manager = DataManager()
manager.data.append("Some Data")
manager.data.append("Some more Data")

/**
 The DataManager class has a stored property called data, which is initialized with a new, empty array of String values. Although the rest of its functionality isn't shown, the pupose of this DataManager class is to manage and provide access to this array of String data.
 
 Part of the functionality of the DataManager class is the ability to import data from a file. This functionality is provided by the DataImporter class, which is assumed to take a nontrivial amount of time to initialize. This might be because a DataImporter instance needs to open a file and read its contents into memory when the DataImporter instance is initialized.
 
 Because it's possible for a DataManager instance to manage its data without ever importing data form a file, DataManager doesn't create a new DataImporter instacne when the DataManager itself is creataed. Instaed, it makes more sense to create the DataImporter instance if and when it's first used.
 
 Becuase it's marked with the lazy modifier, the DataImporter instance for the importer property is only created when the importer property is first accessed, such as when its filename prorperty is queried:
 
 
        If a property marked with the lazy modifier is accessed by multiple thread simultaoneously and the property hasn't yet been initialzied, there's no guarantee that the property will be initialized only once.
 
    
 
    Stroed Properties and Instance Variables
 If you have experiecne with Objective-C, you may knw that it provides two ways to store values and references as part of a class instacne. In addition to properties, you can use instance variables as a backing store for the values stored in a property.
 
 Swift unifies these concepts into a single prorperty declaration. A Swift prorperty doesn't have a corresponding instance variable, and the backing store for a property isn't accessed directly. This approach avoids confusion about how the value is accessed in different contexts and simplifies the property's declaration into a single, definitive statement. All information about the property-including its name, type and memroy management characteristics-is defined in a single location as part of the types definition.
 
 
 
    Computed Properties
 In addition to stored properties, classes, structures, and enumerations can define computed properties, which dont' actually store a value. Instead, they provide a getter and an optional setter to retrieve and set other proeprties and values indriect
 */
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
print("square.origin is now at \(square.origin.x) \(square.origin.y)")


/**
    Shorthand Setter Declaration
 If a computed property's setter doesn't define a name for the new value to be set, a default name of 'newValue' is used. Here's an alternatvie version of the Rect structure that takes advantage of this shorthand notation:
 
 
 */
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

/**
    Shorthand Getter Declaration
 If the entire body of a getter is a single expression, the getter imlicitly returns that expression. Here's an another version of the 'Rect' structure that takes advantage of this shorthand notation and the shorthand notation for setter:
 
 */
struct CompactRect {
    var origin = Point()
    var size = Size()
    
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2), y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}
/**
 Omitting the return from a getter follows the same rules as omitting return from a function
 
    Read-Only Computed Properties
 A computed property with a getter but no setter is known as a read-only computed property. A read-only computed property always returns a vlaue, and can be accessed through dot syntax, but can't be set to a different value.
 
        You must declare computed properties - including read-only computed properties - as variable properties with the var keyword, because their value isn't fixed. The let keyword is only used for constant properties, to indicate that their values can't be changed once they're set as part of instance initialization.
 
 you can soimpliciyghe declareation of a reay-only coputed proeprty by removing the get keyword and its braces
 */

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

let fourByFivByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)

/**
    Property Observers
 Property observers ovserve and respond to changes in a prorperty's value. Porperty oservers are called every time a property's value is set, even if the enw value is the same as the property's current value.
 
    - Stored prorperties that you define
    - Stored prorperties that you inherit
    - Computed prorperties that you inherit
 
 For an inherit proerty, you add a proeprty observer by overriding that prorperty in a subclass. For a computed prorperty that you defin, use the prorperty's setter to observe and respond to value chagnes, instead of trying to crate an observer. Overriding properties is described in Overriding.
 
 You have the option to define either or both of these observers on a prorperty:
    
    - 'willSet' is called just before the value is stored.
    - 'didSet' is calle immediately after the new value is stored.
 
 If you implment a 'willSet' observer, it's passed the new prorperty value as a constant parameter. You can specify a name for this parameter as part of your 'willSet' implementation. If you dont' write the parameter anme and parentheses within your implementaion, the parameter is made available with a default parameter name of 'newValue'
 
 Similarly, if you implement a 'didSet' observer, it's passed a constant parameter containing the old property value. You can name the parameter or use the default parameter name of 'oldValue'. If you assign a value to property within its own didSet observer, the new value that you assign replaces the one that was just set.
 
        The 'willSet' and 'didSet' observers of superclass properties are called when a property is set in a subclass intializer, after the superclass initializer has been calledwhile a class is setting its own properties, before the superclass inititalizer has been called.
 
 Here's an example of 'willSet' and 'didSet' in action. The example below defines a new class called StepCounter, which tracks the total number of steps that a person takes while walking. This class might be used with input data from a pedometer or other step counter to keep track of a person's exercise during their daily routine.
 */

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps){
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet{
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 986

/**
 The StepCounter class declares a totalSteps property of type Int. This is a stored prorpety with willSet and didSet observers. The willSet and didSet observers for totalSteps are called whenever the proeprty is assigned a new value. This is true even if the new Value is the same as the current value.
 
 This example's willSet observer uses a custom parameter name of 'newTotalSteps' for the upcoming new value. In this example, it simply prints out the value that's about to be set.
 
 The 'didSet' observer is called after the value of totalSteps is updated. It compares the new Value of totalSteps aginst the old value. If the total number of steps has increased, a message is printed to indicate how many new steps have been taken. The 'didSet' observer doesn't provide a custom parameter name for the old value, and the default name of 'oldValue' is used instead.
 
        If you pass a property that has obsevers to a function as an in-out parameter, the willSet and didSet observers are always called. This is because of the copy-in copy-out memory model for in-out parameters: the value is always written back to the property at the end of the fuction. For a detailed discussion of the behavior of in-out parameters
 
 
    Property Wrappers
 A property wrapper adds a layer of separation between code that managers how a property is stored and the code that defines a property. For example, if you have properties that provide thread-safety checks or store their underlying data in a database, you have to write that code on every proeprty. When you use a property wrapper, you write the management code once when you define the wrapper, and then reuse that management code by applying it to multiple properties.
 
 To define a property wrapper, you make a structure, enumeration, or class that defines a wrappedValue prorperty In the code below, the TwelveOrLess structure ensures that the value it wraps always contains a number less than or equal to 12. If you ask it to store a larger number, it stores 12 instead.
 
 */
@propertyWrapper
struct TwelveOrLess {
    public var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

/**
 The setter ensures that new values are less than or eqault to 12, and the getter returns the stored value.
 
        The declaration for number in the example above marks the variable as private, which ensures number is used only in the implementation of TwelveOrLess. Code that's written anywhere else accesses the value using the getter and setter for 'wrappedValue', and can't use the number directly.
 */

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
    
    init(){}
}

var rectangle = SmallRectangle()
print(rectangle.height)

rectangle.height = 10
print(rectangle.height)

rectangle.height = 24
print(rectangle.height)


/**
 The height and width properties get their oinitial values from the definition of TwelveOrLess, which sets TweleveOrLess.number to zero. The setter in TwelveOrLess treats 10 as a valid value so storing the number 10 in rectangle.height proceed as written. However, 24 is larger than TwelveOrLess allows, so trying the store 24 end up setting rectangle.height to 12 instead, the largest allowed value.
 
 When you apply a wrapper to a property, the compiler syntehsizes code that provides storage for the wrapper and code that provides access to the prorperty through the wrapper. You could write code that uses the behavior of a property wrapper, without taking advantage of the special attribute syntax.
 For example, here's a version of SmallRectangle from the previous code listing that wraps its properties in the TwelveOrLess structure explicitly, instead of writing @TweleveorLess as an attribute:
 */

struct SmallRectangles {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue}
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue}
    }
}

/**
 The _height and _width properties store an instance of the proeprty wrapper, TwelveOrLess. The getter and setter for height and width wrap access to the wrappedValue property.
 
 
    Setting Initial Values for Wrapped Properties
 The code in the examples above sets the initial value for the wrapped property by giving number an initial value in the definition of 'TwelveOrLess'. Code that uses this property wrapper can't specify a different initial value for a property that's wrapped by 'TwelveOrLess' - for example, the definition of 'SmallRectangle' can't give height or width initial values. To support setting an initial value or other customization, the property wrapper needs to add an initialzier. here's an expanded version of TwelveOrLess called SmallNumber that defines initializers that set the rapped and maximum value:
 */
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int
    
    var wrappedValue: Int {
        get {
            return number
        }
        set {
            number = min(newValue, maximum)
        }
    }
    
    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min (wrappedValue, maximum)
    }
    
}

/**
 The instance of SmallNumber that wrap height and width are crated by calling SmallNumber(). The code inside that initializer sets the initial wrapped value and the inital maximum value, using the defauclt values of zero and 12. The property wrapper still provides all of the initial values, like the eariler example that used TwelveOrLess in SmallRectangle. Unlike that exmaple, 'SmallNumber' also supports writing those initial values as part of declaring the property.
 
 When you specify an initial value ofr the property, Swift uses the init(wrppaedValue:) initializer to set up the wraper.
 */

struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}

var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)
/**
 When you write = 1 on a property with a wrapper, that's translated into a call to the init(wrappedValue:) initializer. The instances of 'SmallNumber' that wrap height and width are created by calling 'SmallNumber(wrappedValue: 1)'. The initializer uses the wrapped value that's specified here, and it uses the default maximum value of 12.
 
 When you write arguments in parentheses after the custom attribute, Swift uses the initializer that accpets those arguments to set up the wrapper. For example, if you provide an initial value and a maximum value, Swift uses the init(wrappedValue: maximum:) initializer:
 */
struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)


narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)

/**
 The instance of 'SmallNumber' that wraps height is created by calling SmallNumber(wrappedValue: 2, maximum: 5), and the instance that wraps width is created by calling SmallNumber(wrappedValue: 3, maximum: 4),
 
 By including arguments to the property wrapper, you can set up the initial state in the wrapper or pass other options to the wrapper when it's created. This syntax is the most general way to use a property wrapper. You can provide wheneer arguments you need to the attribute, and they're passed to the initialzier.
 
 When you include proeprty wrapper arguments, you can also specify an initial value using assignment. Swift treats the assignment like a 'wrappedValue' argument and uses the initializer that accepts the arguments you include.
 */

struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}
var mixedRectangle = MixedRectangle()
print(mixedRectangle.height)

mixedRectangle.height = 20
print(mixedRectangle.height)


/**
 The instance of SmallNumber that wraps height is created by calling SmallNumber(wrappedValue: 1), which uses the default maximum value of 12. The instance that wraps width is created by calling SmallNumber(wrappedValue: 2, maximum: 9)
 
 
    Projecting a Value From a Property Wrapper
 In addition to the wrapped value, a property wrapper can expose additional functionality by defining a 'projected' value - for example, a property wrapper that manages access to a database can expose a 'flushDatabaseConnection()' method on its projected value. The name of the projected value is the same as the wrapped value, excet it begins with a dollar sign. Because your code can't define properties that start with '$' the projected value never interferes with properties you define.
 
 In the SmallNumber example above, if you try to set the proeprty to a number that's too large, the proeprty wrapper adjusts the number before storing it. The code below adds a projectedValue property to the SmallNumber structure to keep track of whether the prorperty wrapper adjusted the new value for the prorperty before storing that new value.
 
 */
@propertyWrapper
struct SmallNumbers {
    private var number: Int
    private(set) var projectedValue: Bool
    
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
    
    init() {
        self.number = 0
        self.projectedValue = false
    }
}

struct SomeStructure {
    @SmallNumbers var someNumber: Int
}
var someStructure = SomeStructure()

someStructure.someNumber = 4
print(someStructure.$someNumber)

someStructure.someNumber = 55
print(someStructure.$someNumber)

/**
 Writing 'someStructure.$someNumber' accesses the wrapper's projected value. After storing a small number like four, the value of 'someStructure.$someNumber' is 'false'. However, the projected value is 'true' after trying to store a number that's too large, like 55.
 
 A proeprty wrapper can return a value of any type as its projected value. In this example, the proeprty wrapper exposes only one piece of information - whether the number was adjusted - so it exposes that Boolean value as its projected value. A wrapper instance of the wrapper as its projected value.
 
 When you access a projected value from code that's part of the type, like a property getter or an instance method, you can omit 'self'. before the property name, just like accessing other properties. The code in the following example refers to the projected value of the wrapper around height and width as $height and $width.
 
 */
enum Sizes {
    case small, large
}

struct SizedRectangle {
    @SmallNumbers var height: Int
    @SmallNumbers var width: Int
    
    mutating func resize(to size: Sizes) -> Bool {
        switch size {
            case .small:
                height = 10
                width = 20
            case .large:
                height = 100
                width = 100
        }
        
        return $height || $width
    }
}
/**
 Because property wrapper syntax is just syntatic sugar for a property with a getter and a setter, accessing height and width behaves the same as accessing any other property. For example, the code in resize(to:) access height and width using their property wrapper. If you call resize(to: .large), the switch case for .large sets the rectangle's height and width to 100. The wrapper prevents the value of those properts from being larger than 12, and it sets the prjected value to true, to record the fact that it adjust thier values. At the end of resize(to:), the return statement checks $height and $width to determine wheter the property wrapper adjusted either height or width.
 
 
 
 
    Global and Local Variables
 The capabilites describe above for computing and observing properties are also available to global variables and local variables. Global variables are variables that are defined outsied of any function, method, closure, or type context. Local variables are varibles that are defined within a function, method, or closure context.
 
 The global and local variables you have encountered in previous chapters have all been stored variables. Stored variables, like stored properties, provide storage for a value of a certain type an allow that value to be set and retrieved.
 
 However, you can also define computed variables and define observers for stored variables, in either a global or local scope. Computed variables calculate their value, rather than storing it, and they're written in the same way as computed properties.
 
        Global constants and variables are always computed lazily. in a similar manner to Lazy Stored Properties. Unlike lazy stored properties, global constants and variables don't need to be marked with the lazy modifer.
        
        Local constants and variabes are never computed lazily.
 
 you can apply a property wrapper to a local stored variable, but no to a global variable or a computed variable.
 */
//func someFunction() {
//    @SmallNumber var myNumber: Int = 0
//
//    myNumber = 10
//    myNumber = 24
//}
//

/**
    Type Properties
 Instance proeprties are properties that belong to an instace of a particular type. Every time you create a new instance of that type, it has its own set of property values, separate from any other instance.
 
 You can aloso define properties that belong the the type itself, not to any one instace of that type. There will onely ever be one copy of these properties, no matter how many instances of that type you create. These kind of properties are called 'type properties'.
 
 Type properties are useful for defining values that are universal to all instances of a particular type, such as a constant property that all instances can use, or a variable property that stores a value that's global to all instances of that type
 
 Stored type proeprties can be variables or constants. Computed type properties are always decalred as variable properties, in the same way as computed instance properties.
 
        Unlike stored instance properties, you must always give stored type properties a default value. This is because the type itself doesn't have an initializer that can assign a value to a stored type property at initialization time.
 
        Stored type properties are lazily initialized on their first access. They're guranteed to be initialized only once, even when accessed by multiple thread simultaneously, and they don't need to be marked with the lazy modifer.
 
 
    Type Property Syntax
 In C and Objective-C, you define static constants and variables associated with a type as global static variables. In Swift however, type properties are wirtten as part of the type's definition, within the types' outer curly braces, and each type property is explicitly scoped to the type it supports
 
 You define type properties with the 'static' keyword. For computed type properties for class types, you can use the 'class' keyword instaed to allow subclasses to overide the superclass's implementation.
 */
struct SomeStruc {
    static var storedTypeProperty = "some value"
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnum {
    static var storedTypeProperty = "some value"
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClazz {
    static var storedTypeProperty = "some value"
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int { //overrideable static variation
        return 107
    }
}

/**
            The computed type property examples above are for read-only computed type properties, but you can also define read-write computed type properties with the same syntax as for computed instance properties.
 
    Querying and Setting Type Properties
 Type properties are queried and set with dot syntax, just like instance properties. However, type properties are queried and set on the type, not on an instance of that type.
 */
print(SomeStruc.storedTypeProperty)
SomeStruc.storedTypeProperty = "ANOTHER"
print(SomeStruc.storedTypeProperty)

print(SomeEnum.computedTypeProperty)
print(SomeClazz.computedTypeProperty)

//220 ~ 221






//: [Next](@next)
