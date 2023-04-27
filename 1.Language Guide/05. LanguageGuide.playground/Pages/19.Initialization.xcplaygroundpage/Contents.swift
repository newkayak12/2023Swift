//: [Previous](@previous)
/*: # Initialization*/
/**
 Initialization is the process of preparing an instance of a class, structure, or enumeration for use. This process involves setting an initial value for each stroed property on that instance and performing any other setup or initialization that's required before the new instance is ready for use.
 
 Instance of class types can also implement a deinitializer, which performs any custom cleanup just before an instance of that class is deallocated.
 
    Setting Initial Values for Stored Properties
 Classes and structures must set all of their stored proeprties to an appropriate initial value by the time an instance of that class or structure is created. Stored properties can't be left in an indeterminate state.
 
 You can set an initial value for a stored property within an initializer, or by assigning a default property value as part of the property's definition. These actions are described in the following sections.
 
        When you assign a default value to a stored property, or set its initial value within an initializer, the value of that property is set directly, without calling any property observers.
 
    Initializer
 Initializer are called to create a new instance of a particular type. In its simplest form, an initializer is like an instance method with no parameters, written using the 'init' keyword.
 
    init() {
 
    }
 
 */
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}

var f = Fahrenheit()
print(f.temperature)
/**
 The structure defines a single initializer, 'init', with no parameters, which initializes the stored temperature with a value of 32.0.
 
    
    Default Property Values
 You can set the initial value of a stored property from within an initializer, as shown above. Alternatively, specify a default property value as part of the property's declaration. You specify a default property value by assigning an inital value to the property when it's defined.
 
        If a property always takes the same initial value, provide a default value rather than setting a value within an initializer. The end result is the same, but the default value ties the property's initialization more cloely to its declaration. It makes for shorter, clearer initializer and enables you to infer the type of the property from its default value. The default value also makes it easier for you to take advantage of default initializers and initializer inheritance
 
 
    Customizing Initailization
 you can customize the initialization process with input parameters and optional property types, or by assigning constant properties during initialization
 
    Initialization Parameters
 You can provide initialization parameter as part of an initializer's definition, to define the types and names of values that customize the initialization process. Initialization parameters have the same capabilities and syntax as function and method parameters.
 */
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double){
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)

/**
    Parameter Names and Argument Label
 As with function and method parameters, initialization parameters can have both a parameter name for use within the initializer's body and an argument label for use when calling the initializer.
 
 However, initializers don't have an identifying function name before their parentheses in the way that functions and methods do. Therefore, the names and types of an initializer's parameters play a particularly important role identifying which initializer should be called. Because of this, Swift provides an automatic argument label for every parameter in an initailizer if you don't provide one.
 */

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double){
        red = white
        green = white
        blue = white
    }
}

/**
 Both initializers can be used to create a new 'Color' instance, by providing named values for each initializer parameter:
 */
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

/**
    Initializer Parameters Without Argument Labels
 If you don't want to use an argument label for an initializer parameter, write an underscore(_) instead of an explicit argument label for that parameter to override the defualt behavior.
 */

struct Celsius2 {
    var temperatureInCelsius: Double
    init(fromFahrenheit farenheit: Double) {
        temperatureInCelsius = (farenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = (kelvin - 273.15)
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

let bodyTemperature = Celsius2(37.0)

/**
    Optional Property Type
 If your custom type has a stored property that's logically allowed to have "no value" - perhaps because its value can't be set during initialization, or because it's allowed to have "no value" at some later point - declare the property with an optional type. Properties of optional type are automatically intialized with a value of nil, inicating that the property is deliberately intended to have "no value yet" during initialization
 
 */
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String){
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()

/**
    Assigning Constant Properties During Initialization
 You can assign a value to a constant property at any point during initialization, as long as it's set to a definite value by the time initialization finishes. Once a constant property is assigned a value, it can't be further modified.
 
        For class instances, a constant property can be modified during initialization only by the class that introduces it. It can't be modified by a subclass.
 
 You can revise the 'SurveyQuestion' example from above to use a constant property rather than a variable property for the text property of the question, to indicate taht the question doesn't change once an instance of 'SurveyQuestion' is created. Even though the 'text' property is now a constant, it can still be set within the class's initializer.
 */
class SurveyQuestions {
    let text: String
    var response: String?
    
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

let beetsQuestion = SurveyQuestions(text: "How about beet?")
beetsQuestion.ask()

/**
    Default Initializers
 Swift provides a default initializer for any structure or class that provides default values for all of tis properties and doesn't provide at least one initializer itself. The default initializer simply creates a new instance with all of tis properties set to their default values.
 
 */
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}

var item = ShoppingListItem()

/**
    Memberwise Initializers for Structure Types
 Structure types automatically receive a memberwise initializer if they don't define any of their own custom initializers. Unlike a default initialzer, the structure receives a memberwise initializer even if it has stored properties that don't have default values.
 
 The memberwise initializer is a shorthand way to initialize the member properties of new structure instances. Initial values for the properties of the new instance can be passed to the memberwise initializer by name.
 
 */

struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)

/**
 When you call a memberwise initializer, you can omit values for any properties that have default values.
 */

let zerobyTwo = Size(height: 2.0)
print(zerobyTwo)

/**
    Initializer Delegation for Value Types
 
 Initializers can call other initializers to perform part of an instance's initialization. This process, known as 'initializer delegation', avoids duplicating code across multiple initializers.
 */
struct SizeStruct {
    var width = 0.0, height = 0.0
}
struct PointStruct {
    var x = 0.0, y = 0.0
}
struct RectStrcut {
    var origin = PointStruct()
    var size = SizeStruct()
    
    init() {}
    init(origin: PointStruct, size: SizeStruct) {
        self.origin = origin
        self.size = size
    }
    init(center: PointStruct, size: SizeStruct) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        
        self.init(origin: PointStruct(x: originX, y: originY), size: size)
    }
}
let originRect = RectStrcut(origin: PointStruct(x: 2.0, y: 2.0), size: SizeStruct(width: 5.0, height: 5.0))

/**
    Class Inheritance and Initialzation
 All of a class's stored properties - including any properties the class inheirts from its superclass - must be assigned an initial value during initialization.
 
 Swift defines two kinds of initializer for class types to help ensure all stored properties receive an initial value. These are known as designated initializers and convenience initializers.
 
 
 
    Designated Initializers and Convenience Initializers
 Desinated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.
 
 Classes tend to have very few desingated initializers, and it's quite common for a class to have only one. Designated initializers are 'funnel' points through which initialization takes place, and through which the initialization process continues up the superclass chain.
 
 Every class must have at least one desinated initializer. In some cases, this requirement is satified by inheriting one or more designated initializers from a superclass.
 
 Convenience initializers are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class ass the convenience initailizer with some of the designated initializer's parameters set to default values. You can also define a convenince initializer to create an instance of that class for a specific use case or input value type.
 
 You don't have to provide convenience initializers if your class doesn't require them. Create convenience initializers whenever a shortcut to a common initialization pattenr will save time or make initialization of the class clearer in intent
 
 
    Syntax for Designated and convenience Initializers
 Designated initializers for classes are written in the same way as simple initializers for value types:
 
                init ( parameters ) {
                    statment
                }
 
 Convenience initializers are written in the same style, but with the convenience modifier placed before the init keyword, separated by a space
 
                convenience init ( parameters ) {
                        statements
                }
 
    Initializer Delegation for Class Typs
 To simplify the relationships between designated and convenience initializers, Swift applies the following three rules for delegation calls between initializers:
 
    Rule 1
    - A designated initializer must call a designated initializer from its immediate superclass
 
    Rule 2
    - A convenience initializer must call another initializer from the same class.
 
    Rule 3
    - A convenience initializer must ultimately call a designated initializer
 
 A simple way to remeber this is:
    - Designated initializers must always delegate up.
    - Convenience initializers must always delegate across.
 
 */
/*: ![img](init.png)*/
/**
 Here, the superclass has a single desinated and two convenience initializers. One convenience initializer calls another convenience initializer, which in turn the single designated initializer. This satisfies rules 2 and 3 from above. The superclass doesn't itself have a futher superclass, and so rule 1 doesn't apply.
 
 The subclass in this figure has two desinated initializers and one convenience initializer. The convenience initializer must call one of the two designated initializers, because it can only call another initializer from the same class. This satisfies rule 2 and 3 above. Both designated initializers must call the single designated initializer from the superclass, to satisfy rule 1 from above
 
        These rules don't affect how users of you classes create instance of each class. Any initializer in the diagram above can be used to create a fully initialized instance of the class they belong to. The rules only affect how you write the implmentation of the class's initializers.
 
 The figure below shows a more complex class hierachy for four classes It illustrates how the designated initializers in this hiearachy act as 'funnel' points for class initialization, simplifying the interrelationships among classes in the chain:
 
 */

/*: ![img](init2.png)*/
/**
    Two-Phase Initialization
 Class initialization in Swift is a two-phase process. In the first phase, eadh stored property is assigned an initial value by the class that introduced it. Once the initial state for every stored property has been determined, the second phase begins, and each class is given the opportunity to customized its stored properties further before the new instance is considered ready for use.
 
 The use of a two-phase initialization process makes initialization safe, while still giving complete flexibility to each class in a class hierachy. Two-phase initialization prevents property values from being accessed before they're initialized, and prevents property values from being set to a different value by another initalizer unexpectedly.
 
            Swift's two-phase initialization process is similar to initialization in Objective-C. The main difference is that during phase 1, Objective-C assigns zero or null values to every property. Swift's initialization flow is more flexible in that it lets you set custom initial values, and can cop with types for which 0 or nil isn't a valid default value.
 
 Swift's compiler performs four helpful safety-checks to make sure that two-phase initialization is completed without error:
 
    SafetyCheck1
        A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer.
 
    As mentioned above, the memory for an object is only considered fully initialized once the initial state of all of its sotred proeprties is known. In order for this rule to be satisfied, a designated initializer must make sure that all of its own properties are initialized before i hands off up the chain.
 
    SafetyCheck2
        A designated initializer must delegate up to supperclass initializer before assigning a value to an inheirted property. If it dosen't, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization.
 
    SafetyCheck3
        A convenince initializer must delegate to another initializer bfore assigning a value to any property. If it dosen't, the new value the convenience initailzier assigns will be overwritten by its own class's designated initializer.
 
    SafetyCheck4
        An initializer can't call any instance methods, read the values of any instance properties, or refer th self as a value until after the first phase of initialization is complete.
 
The class instance isn't fully valid until the first phase ends. Properties can only be accessed, and methods can only be called, once the class instance is known to be valid at the end of the first phase.
 
 
 
    Phase 1
    - A designated or convenience initializer is called on a class.
    - Memory for a new instance of that class is allocated. The memory isn't yet initialized
    - A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
    - The designated initialzier hands off to a superclass initializer to perform the same task for its own stored properties.
    - This continues up the class inheritance chain until the top of the chain is reached.
    - Once the top of the chain is reached, and the final class in the chain has ensured that all of its sotred properties have a value, the instance's memory is considered to be fully initialized, and phase 1 is complete.
 
    Phase 2
    - Working back down from the top of the chain, each designated initailizer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.
    - Finally, any phase 1 looks for an initialization call for a hypothetical subclass and superclass:
 
 
    Initializer Inheritance and Overriding
 Unlike subclasses in Objective-C, Swift subclasses don't inherit their superclass initializers by default. Swift's approach prevents a situation in which a simple initializer from a superclass is inherited by a more specialized subclass and is used to crate a new instance of the subclass that isn't fully or correctly initialized.
 
 If you want a custom subclass to present one or more of the same initializers as its superclass, you can provide a custom implementation of those initializers within the subclass.
 
 Wehn you write a subclass initializer that matches a superclass designated initializer, you are effectively providing an override of that designated initializer. Therefore, you must write the override modifier before the subclass's initializer definition. Thisis true even if you are overriding an automatically provided default initailzier
 
 As with an overridden property, method, or subscript, the presence of the override modifier prompts Swift to check that the superclass has a matching desingated initializer to be overridden, and validates thath the parameters for your overriding initializer have been specified as intended.
 
 Conversely, if you wirte a subclass initializer that matches a superclass convenience initializer, that superclass convenience initializer can never be called directly by your subclass, as per the rules described above in Initializer Delegation for Class types. Therefore, you subclass is not providing an override of the superclass initializer.
 */
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

/**
    Automatic Initializer Inheritance
 Superclass initializer are automatically inherited if certain conditions are met. In practice, this means that you don't  need to write initializer overrides in mayny common scenarios, and can inheir your superclass initializers with minimal effort whenever it's safe to do so.
 
    Rule 1
    If your subclass doesn't define any designated initializers, it automatically inherits all of its superclass designated initializers.
 
    Rule 2
    If your subclass providies an implementation of all of tis superclass designated initializers - either by inheriting them as per rule1, or by providing a custom implementation as part of its definition
 
 
 
    Failable Initailizers
 It's sometimes useful to define a class, structure, or enumeration for which initialization can fail. This failure might be triggered by invalid initialization parameter values, the absence of a required external resource, or some other condition that prevents initialization from succeeding.
 
 To cope with initialization conditions that can fail, define one or more failable initializers as part of a class, structure, or enumeration definition. You write a  failable initializer by placing a question mark after the init keyword( init? ).
 
 A failalbe initializer create an optional value of the type it initializes. You wirte return 'nil' within a failable initializer to indicate a poin at which initializatoin failure can be triggered.
 
            Strictly speaking, initializers don't return a value. Rather, their role is to ensure that 'self' is fully and correctly initialized by the time that initialization ends. Although you write return 'nil' to trigger an initialization failure, you don't use the return keyword to indicate initialization success.
 
 For instance, failalbe initializers are implemented for numeric type conversions. To ensure conversion between numeric types mainains the value exactly, use the init(exactly:) initializer. If the type conversion can't maintain the value, the initializer fails.
 */
let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}

let valueChanged = Int(exactly: pi)
if valueChanged == nil {
    print("\(pi) conversion to Int doesn't maintain value.")
}


struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty {return nil}
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print(giraffe)
}

let anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
    print("FAIL")
}

/**
    Failable Initializers for Enumerations
 You can use a failalbe initializer to select an appropriate enumeration case based on one ore more parameters. The initializer can then fail if the provided parameters don't match an appropriate enumeration case.
 */
enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init? ( symbol: Character ){
        switch symbol {
            case "K":
                self = .kelvin
            case "C":
                self = .celsius
            case "F":
                self = .fahrenheit
            default:
                return nil
        }
    }
}





//: [Next](@next)
