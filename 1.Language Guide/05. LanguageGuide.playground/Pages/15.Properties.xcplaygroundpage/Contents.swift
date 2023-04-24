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

struct SmallRectangle {
    private var _height = TwelveOrLess()
    private var _width = TwelveorLess()
    
    var height: Int {
        get { return height.wrappedValue }
        set { _height.wrappedValue = newValue}
    }
    var width: Int {
        get { return width.wrappedValue }
        set { width.wrappedValue = newValue}
    }
}

/**
 The _height and _width properties store an instance of the proeprty wrapper, TwelveOrLess. The getter and setter for height and width wrap access to the wrappedValue property.
 */



//: [Next](@next)
