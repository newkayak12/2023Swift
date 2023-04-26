//: [Previous](@previous)
/*: # Inheritance*/
/**
 A class can inherit methods, properties, and other characteristics from another class. When one clsas inheirts from another, the inheriting class is known as a subclass, and the class it inheirts from is known as it superclass. Inheritance is a fundamental behavior that differentiates classes from other types in Swift.
 
 Classes in Swift can call and access methods, properties, and subscripts belonging to their superclass and can provide their own overriding versions of those methods, prorperties, and subscripts to refine or modify their behavior. Swift helps to ensure you overrides are correct by checking that the override definition has a matching superclass definition.
 
 Classes can also add property observers to inherited properties in order to be notified when the value of property changes. Property observers can be added to any property, regardless of whether it was orignally defined as a stored or computed proeprty.
 
 
    Defining a Base Class
 Any class that doesn't inherit from another class is known as a base class.
 
        Swift classes don't inherit from a universal base class. Classes you define without specifying a superclass automatically become base classes for you to build upon.
 
 */
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        //do nothing
    }
}

/**
 You create a new instance of Vehicle with initializer syntax, which is written as a type name followed by empty parentheses:
 */

let someVehicle = Vehicle()

/**
 Having created a new 'Vehicle' instance, you can access its 'description' property to print a human-readable description of the vehicle's current speed:
 */

print("Vehicle: \(someVehicle.description)")

/**
 The 'Vehicle' class defines common characteristics for an arbitary vehicle, but isn't much use in itself. To make it more useful, you need to refine it to describe more specific kinds of vehicles
 
 
    Subclassing
 Subclassing is the act of basing a new class on an existing class. The subclass inheirts characteristics from the existing class, which you can then refine. You can also add new characteristics to the subclass
 
 To indicate that a subclass has a superclass, write the subclass name before the superclass anme, separated by a colon:
 */

//class SomeSubclass: SomeSuperclass {
//    //
//}

class Bicycle: Vehicle {
    var hasBasket = false
}

/**
 Above class automatically gains all of the characteristics of Vehicle, such as its currentSpeed and description properties and its 'makeNoise()' method.
 
 
 
    Overriding
 A subclass can provide its own custom implementation of an instance method, type method, instance property, type property, or subscript that it would otherwise inherit from a superclass. This is known as overriding.
 
 To override a characteristic that would otherwise be inheirted, you prefix your overriding definition with the override keyword. Doing so clarifies that you intend to provide an override and haven't provided a match definition by mistake. Overriding by accident can cause unexpected behavior, and any overrides without a 'override' keyword anre diagnosed as an error when you code is compiled.
 
 The 'override' keyword also prompts the Swift compiler to check that your overriding class's superclass has a declaration that matches the one you provided for the override. This check ensures that your overriding definition is correct.
 
 
    Accessing Superclass Method, Proeprties, and Subscripts
 When you provide a method, property, or subscript override for a subclass, it's sometimes useful to use the existing superclass implmentation as part of you override. For example, you can refine the behavior of that exsiting implementation, or store a modified value in an existing inherited variable.
 
    - An overridden method named 'someMethod()' can call the superclass version of 'someMethod()' by calling 'super.someMethod()' within the overriding method implementation.
 
    - An overridden property called 'someProperty' can access the superclass versoin of 'someProperty' as 'super.someProperty' within the overriding getter or setter implementation.
 
    - An overridden subscript for 'someIndex' can access the superclass version of the same subscript as 'super[someIndex]' from within the overriding subscript implementation.
 
    
 
    Overriding Methods
 You can override an inherited instance or type method to provide a tailored or alterantive implementation of the method within your subclass.
 
 The following example defines a new subclass of 'Vehicle' called 'Train', which overrides the 'makeNoise()' method that 'Train' inherits from 'Vehicle'
 */

class Train: Vehicle {
    override func makeNoise() {
        print("CHOO CHOO!")
    }
}

let train = Train()
train.makeNoise()

/**
    Overriding Properties
 You can override an inherited instance or type property to provide your own custom getter and setter for that property, or to add property observers to enable the overrding property to observe when the underlying property value changes.
 
    Overriding Property Getters and Setters
 You can provide a custom getter to override 'any' inherited property, regardless of whether the inherited property is implemented as a stroed or computed property at source. The stored or computed nature of an inherited property isn't known by a subclass - it only knows that the inherited property has a certain name an type. You must always state both the name and the type of the property you are overriding, to enable the compiler to check that your override matches a superclass property with the same name an type.
 
 You can present an inherited read-only property as a read-write property by providing both a getter and a setter in your subclass property override. You can't, however, present an inherited read-write property as a read-only property.
 
 
        If you provide a setter as part of property override, you must also provide a getter for that override. If you don't want to modify the inherited property's value within the overriding getter, you can simply pass through the inherited value by returning 'super.someProperty' from the getter, where someProperty is the name of the property  you are overriding.
 
 The following example defines a new class called Car, which is subclass of Vehicle. The 'Car' class introduces a new stored property called 'gear', with a default integer value of 1. The 'Car' class also overrides the 'description' property it inherits from 'Vehicle', to provide a custom description that includes the current gear:
 
 */

class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

/**
    Overriding Property Observers
 You can use property overriding to add property observers to an inherited property. This enables you to be notified when the value of an inherited property changes, regardless of how that property was originally implemented.
 
        You can't add property observers to inherited constant stored properties or inherited read-only computed properties. The value of these properties can't be set, and so it isn't appropriate to provide a 'willSet' or 'didSet' implementation as part of an override.
 
        Not also that you can't provide both an overriding setter an an overriding property observer for the same property. If you want to observe changes to a property's value, and you are already providing a custom setter for that property, you can simply observe any value changes from within the custom setter.
 
 */

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int( currentSpeed / 10.0 ) + 1
        }
    }
}

/**
 Whenever you set the 'currentSpeed' property of an 'AutomaticCar' instance, the property's didSet observer sets the instance's gear property to an appropriate choice of gear for the new speed.
 */

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar : \(automatic.description)")

/**
    Preventing Overrides
 You can prevent a method, property, or subscript from being overridden by marking it as 'final'. Do this by writing the 'final' modifier before the method, property, or subscript's introducer keyword

        - final var
        - final func
        - final class func
        - final subscript
 
 Any attempt to override a final method, property, or subscript in a subclass is reported as a compile-time error. Methods, proeprties, or subscripts that you add to a class in an extension can also be marked as final within the extension's definition.
 
 You can mark an entire calss as final by writing the 'final' modifier before the 'class' keyword in its class definition. Any attempt to subclass a final class is reported as a comile-time error
 
 */
//: [Next](@next)
