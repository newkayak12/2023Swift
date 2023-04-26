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
 Desinated initializers are the primary initializers for a class
 */
//: [Next](@next)
