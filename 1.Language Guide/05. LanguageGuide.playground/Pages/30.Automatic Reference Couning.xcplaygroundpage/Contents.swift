//: [Previous](@previous)
import Foundation
/*: # Automatic Reference Counting */
/**
Swift uses `Automatic Reference Counting (ARC)` to track and manage your app's memory usage. In most cases, this means that memory management "just works" in Swift, and you don't need to think about memory management yourself. ARC automatically free up the memory used by class instances when those instances are no longer needed.
 
 However, in a few cases ARC requires more information about the relationships between parts of your code in order to manage memory for you. This chapter describes those situations and shows how you enable ARC to manage all of your app's memory. Using ARC in Swift is very similar to the approach described in `Transitioning to ARC Release Notes` for using ARC with Objective-C.
 
 Reference counting applies only to instances of classes. Structrues and enumerations are value types, not reference types, and aren't stored and passed by reference.
 
 
    How ARC Works
 Every time you create a new instance of a class, ARC frees up the memory used by that instance so that the memory can be used for other purposes instead. This ensures that class instances don't take up space in memory when they're no longer needed.
 
 However, if ARC were to dealocate an instance that was still in use, it would no longer be possible to access that inscane's properties, or call that instance's methods. Indeed, if you tried to access the instance, your app would most likely crash.
 
 To make sure that instances don't disappear while they're still needed, ARC tracks how many properties, constants, and vairables are currently referring to each class instance. ARC will not deallocate an instance as long as at least one active reference to that instance still exists.
 
 To make this possible, whenever you assign a class instance to a property, constant, or variable, that property, constant, or variable makes a `strong reference` to the instance. The reference is called a "strong" reference because it keeps a firm hold on that instance, and doesn't allow it to be deallocated for as long as that strong reference reamins.
 
 
    ARC in Action
 Here's an example of how Automatic Reference Counting works. This example starts with a simple class called `Person`, which defines a stored constant property called `name`:
 */
class Person {
    let name: String
    init( name: String ){
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit{
        print("\(name) is being deinitialized")
    }
}
/**
 The `Person` class has an initializer that sets the instance's `name` property and prints a message to indicate that initialization is underway. The `Person` class also has a deinitializer that prints a message when an instance of the class is deallocated.
 
 The next code snippet defines three variables of type `Person?`, which are used to set up multiple reference to a new `Person` instance in subsequent code snippets. Because these variables are of an optional type (`Person?`, not `Person`), they're automatically initialized with a value of `nil`, and don't currently refernce a `Person` instance.
 
 */

var reference1: Person?
var reference2: Person?
var reference3: Person?

/**
 You can now create a new `Person` instance and assign it to one of these three variables:
 */

reference1 = Person(name:"John AppleSeed")

/**
 Note that the message "John Appleseed is being initialized" is printed at the point that you call the `Person` class's initializer. This confirms that initialization has taken place.
 
 Because the new `Person` instance has been assigned to the `reference1` variable, there's now a strong reference from `reference1` to the new `Person` instance. Because there's at least one strong reference. ARC makes sure that this `Person` is kept in memory an isn't deallocated.
 
 If you assign the same `Person` instance to two more varibles, two more strong references to that instance are established:
 */

reference2 = reference1
reference3 = reference2

/**
 There are now `three` strong references to this single `Person` instance.
 If you break two of these strong references (including the original reference) by assigning `nil` to two of variables, a single strong reference remains, and the `Person` instance isn't deallocated:
 
 */


reference1 = nil
reference2 = nil

/**
 ARC doesn't deallocate the `Person` instance until the third and final strong reference is broken, at which point it's clear that you are no longer using the `Person` instance:
 */

reference3 = nil

/**
    Strong Reference Cylces Between Class Instances
 In the example above, ARC is able to track the number of references to the new `Person` instance you create and to deallocate that `Person` instance when it's no longer needed.
 
 However, it's possible to write code in which an instance of a class never gets to a point where it has zero strong refernces. This can happen if two class instances hold a strong reference to each other, such that each instance keeps the other alive. This is known as a `strong reference cycle`.
 
 You resolve strong reference cycles by defining some of the relationship between classes as weak or unowned references instead of as strong references. This process is described in `Resolving Strong Reference Cycles Between Class Instances`. However, before you learn how to resolve a strong reference cycle, it's useful to understand how such a cycle is caused.
 
 Here's an example of how a strong refernce cycle can be created by accident. This example defines two classes called `Person` and `Apartment`, which model a block of apratments and its residents:
 */

class Persons {
    let name: String
    init ( name: String ) { self.name = name}
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized")}
}

class Apartment {
    let unit: String
    init ( unit: String ) { self.unit = unit }
    var tenant: Persons?
    deinit { print("Apartment \(unit) is being deinitialized")}
}

/**
 Every `Persons` instance has a `name` property of type `String` and an optional `apartment` property that's initally `nil`. The `apartment` property is optional, because a person may not always have an apartment.
 
 Similarly, every `Apartment` instance has a `unit` property of type `String` and has an optional `tenant` property that's initially `nil`. The tenant property is optional because an apartment may not always have a tenant.
 
 Both of these classes also define a deinitializer, which prints the fact that an instance of that class is being deinitialized. This enables you to see whether instances of `Person` and `Apartment` are being deallocated as expected.
 
 This next code snippet defines two variables of optional type called `john` and `unit4A`, which will be set to a specific `Apartment` and `Person` instance below. Both these variables have an initial value of `nil`, by virtue of being optional:
 */

var john: Persons?
var unit4A: Apartment?

/**
 You can now create a speicific `Persons` instance and `Apartment` instance and assign these new instances to the `john` and `unit4A` variables:
 */

john = Persons(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

/**
 Here's how the strong references look after creating and assigning these two instances. The `john` variable now has a strong reference to the new `Person` instance, and the `unit4A` variable has a strong refernce to new `Apartment` instance:
 
 You can now link the two instances together so taht the person has an aprtment, and the apartment has a tenant. Note that an exclamation point(!) is used to unwrap and access the instances stored inside the `john` and `unit4A` optional variables, so that the properties of those instances can be set:
 */

john!.apartment = unit4A
unit4A!.tenant = john

/**
 Here's how the strong references look after you link the two instances togther:
 
 Unfortunately, linking these two instances creates a strong reference cycle between them. The `Persons` instance now has a strong reference to the `Apartment` instance, and the `Apartment` instance has a strong reference to the `Persons` instance. Therefore, when you break the strong references held by the `john` and `unit4A` variables, the reference counts don't drop to zero, and the instances aren't deallocated by ARC
 */

john = nil
unit4A = nil

/**
Note that neither deinitializer was called when you set these two varibles to `nil`. The strong reference cycle prevents the `Persons` and `Apartment` instances from ever being deallocated, causing a memory leak in your app.
 
Here's how the strong references look after you set the `john` and `unit4A` variables to `nil`;
The strong references between the `Persons` isntance and the `Apartment` instance remain and can't be broken.
 
 
 
    Resolving Strong Reference Cycles Between Class Instances
Swift provides two ways to resolve strong reference cycles when you work with properties of class type: weak references and unowned references.
 
 Weak and unowned references enable one instance in a reference cycle to the other instance without keeping a strong hold on it. The instances can then refer to each other without creating a strong reference cycle.
 
 Use a weak reference when the other instance has a shorter lifetime - that is, when the other instance can be deallocated first. In the `Apartment` example above. it's appropriate for an aprtment to be able to have no tenant at some point in its lifetime, and so a weak reference is an appropriate way to break the reference cycle in this case. In contrast, use an unowned reference when the other instance has the same lifetime or a longer lifetime.
 
 
    Weak References
 A weak reference is a reference that doesn't keep a strong hold on the instance it referes to, and so doesn't stop ARC from disposing of the referenced instance. This behavior prevents the reference from becoming part of a strong reference cycle. You indicate a weak reference by placing the `weak` keyword before a property or variable declaration.
 
 Because a weak reference doesn't keep a strong hold on the instance it refers to, it's possible for that instance to be deallocated while the weak refernce is stil referring to it. Therefore, ARC automatically sets a weak reference to `nil` when the instance that it refers to is deallocated. And, because weak references need to allow their value to be change to `nil` at runtime, they're always declared as variables, rather than constants, of an optional type.
 
 You can check for the existence of a value in the weak reference, just like any other optional value, and you will never end up with a reference to an invalid instance that no longer exists.
 
 
        Property observers aren't called when ARC set a weak reference to nil
 
 
 The example below is identical to the `Persons` and `Apartment` example from above, with one important difference. This time around, the `Apartment` type's `tenant` property is declared as a weak reference:
 */

class Person2 {
    let name: String
    init(name: String) { self.name = name }
    var aprtment: Apartment2?
    deinit { print("\(name) is being deinitalized")}
}

class Apartment2 {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person2?
    deinit { print("Apartment \(unit) is being deinitialized")}
}

/**
 The strong reference from the two variables (`john` and `unit4A`) and the links between the two instances are created as before:
 */

var john2: Person2?
var unit4A2: Apartment2?

john2 = Person2(name: "John Appleseed")
unit4A2 = Apartment2(unit: "4A")

john2!.aprtment = unit4A2
unit4A2!.tenant = john2

/**
The `Person2` instance still has a strong reference to the `Apartment` instance, but the `Apartment` instance now has a weak reference to the `Person2` instance. This mean that when you break the strong reference held by the `john` variable by setting it to `nil`, there are no more strong refernce to the `Person2` instance:
 */

john2 = nil

/**
 Because there are no more strong references to the `Person2` instance, it's dealloacated an the `tenant` proeprty is set to `nil` The only remaining strong reference to the `Apartment` instance is from the `unit4A` variable. If you break that strong reference, there are no more strong references to the `Apartment` instance:
 */

unit4A2 = nil

/**
 Because there are no more strong references to the `Apartment` instance, it too is deallocaed:
 
        In systmes that use garbage collection, weak pointers are sometimes used to implement a simple caching mechanism because objects with no strong references are deallocated only when memory pressure triggers garbage collection. However, with ARC, values are deallocated as soon as their last strong reference is removed, making weak references unsuitable for such a purpose.
 
 
    Unowned References
 Like a weak reference, an unowned reference doesn't keep a strong hold on the instace it refers to. Unlike a weak reference, however, an unowned reference is used when the other instance has the same lifetime or longer lifetime. You indicate an unowned reference by placing the `unowned` keyword before a property or variable declaration.
 
 Unlike a weak reference, an unowned reference is expected to always have a value. As a result, marking a value as unowned doesn't make it optional, and ARC never sets an unowned reference's value to `nil`.
 
        Use an unowned reference only when you are sure that the reference always refers to an instance that hasn't been deallocated. If you try to access the value of an unowned reference after that instance has been deallocated, you'll get a runtime error.
 
 The relationship between `Customer` and `CreditCard` is slightly difference from the relationship between `Apartment2` and `Person2` seen in the weak reference example above. In this data model, a customer may or may not have a credit card, but a credit card will always be associated with a customer. A `CreditCard` instance never outlives the `Customer` that it refers to. To represent this, the `Customer` class hass an optional `card` property, but the `CreditCard` class has an unowned `customer` proeprty.
 
 */

class Customer {
    let name: String
    var card: CreditCard?
    init( name: String ) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized")}
}
class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init( number: UInt64, customer: Customer ) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

var hong: Customer?
hong = Customer(name: "John Appleseed")
hong!.card = CreditCard(number: 1234_5678_9012_3456, customer: hong!)

/**
 The `Customer` instance now has a strong reference to the `CreditCard` instance, and the `CreditCard` instance has an unowned reference to the `Customer` instace.
 
 Because of the unowned `customer` reference, when you break the strong reference held by the `johnny` variable, there are no more strong references to the `Customer` instance
 */
print("-------")
hong = nil

/**
 
        The example above show how to use use `safe` unowned references. Swift also provides `unsafe` unowned references for cases where you need to disable runtime safety checks - for example, for performance reasons. As with all unsafe operations, you take on the responsibility for checking that code for safety.
 
        You indicate an unsafe unowned reference by writing `unowned(unsafe)`. If you try to access an unsafe unowned reference after the instance that it refers to is deallocated, your program will try to access the memory location where the instance used to be, which is an unsafe operation.
 
    
 
    Unowned Optional References
 You can mark an optional reference to a class as unowned. In terms of the ARC ownership model, an unowned optional reference and a weak reference can both be used in the same contexts. The difference is that when you use an unowned optional reference, you 're responsible for making sure it always refers to a valid object or is set to `nil`.
 */
class Department {
    var name: String
    var courses: [Course]
    init(name: String) {
        self.name = name
        self.courses = []
    }
    
}

class Course {
    var name: String
    unowned var department: Department
    unowned var nextCourse: Course?
    
    init( name: String, in department: Department ) {
        self.name = name
        self.department = department
        self.nextCourse = nil
    }
}

/**
 Department maintains a strong reference to each couse that the deaprtment offers. In the ARC ownership model, a department
 owns its courses. `Course` has two unowned references, one to the department and one to the next course a student should take; a course doesn't own either of these objects. Every course is part of some department so the `department` proeprty isn't an optional. However, because some courses don't have a recommended follow-on course, the `nextCourse` property is an optional.
 */

let department = Department(name: "Horticulture")
let intro = Course(name: "Survey of Plants", in: department)
let intermediate = Course(name: "Growing Common Herbs", in: department)
let advanced = Course(name: "Caring for Tropical Plants", in: department)

intro.nextCourse = intermediate
intermediate.nextCourse = advanced
department.courses = [intro, intermediate, advanced]

/**
 An unowned optional reference doesn't keep a strong hold on the instance of the class that it wraps, and so it doesn't prevent ARC from dealocating the instace. It behaves the same as an unowned reference does under ARC, except that an unowned optional refernce can be `nil.`
 
 Like non-optional unowned references, you're responsible for ensuring that `nextCourse` always refers to a course that hasn't been deallocated. In this case, for example, when you delete a course from `department.courses` you also need to remove any references to it that other courses might have.
 
        The underlying type of an optional value is `Optional`, which is an enumeration in the Swift standard library. However, optional are an exception to the rule that value types can't be marked with `unowned`
    
        The optional that wraps the class doesn't use reference counting, so you don't need to maintain a strong reference to the optional.
 
 
    Unowned References and Implicitly Unwrapped Optional Properties
 The examples for weak and unowned references above cover two of the more common scenarios in which it's necessary to break a strong reference cycle.
 
 The `Person` and `Apartment` example shows a situtation where one property that's allowed to be `nil` an another property that can't be `nil` have the potential to casue a strong reference cycle. This scenraio is best resolved with an unowned reference.
 
 However, there's a third scenario, in which both properties should always have a value, and neither property should ever be `nil` once initialization is complete. In this scenario, it's useful to combine an unowned property on one class with an implicitly unwrapped optional property on the other class.
 
 This enables both properties to be accessed directly once initialization is complete, while still avoiding a reference cycle. This section shows you how to set up such a relationship.
 
 The example below defines two class, `Country` and `City`, each of which stores an instance of the other class as property. In this data model, every country must always have a capital city, and every city must always belong to a country. To represent this, the `Country` class has a `capitalCity` property, and the `City` class has a `country` property:
 */

class Country {
    let name: String
    var capitalCity: City!
    init( name: String, capitalName: String ) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init( name: String, country: Country ) {
        self.name = name
        self.country = country
    }
}

/**
 To set up the interdependency between the two classes, the initializer for `City` takes a `Country` instance, and stores this instacne in its `country` property.
 
 The initializer for `City` is called from within the initializer for `Country`. However, the initializer for `Country` can't pass `self` to the `City` initializer until a new `Country` instance is fully initialized, as described in `Two-Phase Initialization`.
 
 To cope with this requirement, you declare the `capitalCity` property of `Country` as an implicitly unwrapped optional property. indicated by the exclamation point at the end of its type annotation (`City!`). This means that the `capitalCity` property has a default value of `nil`, like any other optional, but can be accessed without the need to unwrap its value as described in `Implicitly Unwrapped Optionals`.
 
 Because `capitalCity` has a default `nil` value, a new `Country` instance is considered fully initialized as soon as the `Country` instance sets its `name` property within its initializer. This means that the `Country` initializer can start to reference and pass around the implicit `self` property as soon as the `name` property is set. The `Country` initializer can therefore pass self as one of the parameters for the `City` initializer when the `Coutnry` initializer is setting its own `capitalCity` property.
 
 All of this means that you can create the `Country` and `City` instances in a single statement, without creating a strong reference cycle, and the `capitalCity` property can be accessed directly, without needing to use an excalmation point to unwrap its optional value:
 */

var country = Country(name: "Canda", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")

/**
 In the example above, the use of an implicitly unwrapped optional means that all of the two-phase class initializer requirements are satisfied. The `capitalCity` property can be used and accessed like a non-optional value once initialization is complete, while still avoiding a strong reference cycle.
 
 
    Strong Reference Cycle for Closures
 You saw above how a strong reference cycle can be created when two class instance properties hold a strong reference to each other. You also saw how to use weak and unowned references to break these strong reference cycles.
 
 A strong reference cycle can also occur if you assign a closure to property of a class instance, and the body of that closure captures the instance. This capture might occur because the closure's body accesses a property of the instance, such as `self.someProperty`, or because the closure calls a method on the instance, such as `self.someMethod()`. In either case, these accesses caus the closure to "capture" `self`, creating a strong reference cycle.
 
 This strong reference cycle occurs because closures, like classes, are reference types. When you assign a closure to property, you are assigning a reference to that closrue. In essence, it's the same problem as above - two strong references are keeping each other alive. However, rather than two class instances, this time it's a class isntance and a closure that are keeping each other alive.
 */

class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: (() -> String) = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "</\(self.name)"
        }
    }
    
    init (name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

/**
 The `HTMLElement` class defines a lazy property called `asHTML`. This property references a closure that combines `name` and `text` into an HTML, string fragment. The `asHTML` property is of type `() -> String`, or "a function that takes no parameters, and returns a `String` value".
 
 By default, the `asHTML` property is assigned a closure that returns a string representation of an HTML tag. This tag contains the optional `text` value if it exists, or no text content if `text` doesn't exist. For a paragraph element, the closure would return.
 
 The `asHTML` property is named and used somewhat like an instance method. However, because `asHTML` is a closure property rather than an instance method, you can replace the default value of the `asHTML` property with a custom closure, if you want to change the HTML rendering for a particular HTML element.
 */

let heading = HTMLElement(name: "h1")
let defaultText = "SomeDefaultText"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}

print(heading.asHTML())

/**
 
             The `asHTML` property is declared as a lazy property, because it's only need if and when the element actutally needs to be rendered as a string value for some HTML oupute target. The fact that `asHTML`, is a lazy property means that you can refer to `self` within the default closure, because the lazy property will not be accessed until after initialization has been completed and `self` is known to exist.
 
 
 The HTMLElement class provides a single initialzier, which takes a `name` argument and (if desired) a text argument to initialize a new element. The class also defines adeinitializer, which prints a message to show when  an `HTMLElement` instance is deallocated.
 
 */

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph?.asHTML())

/**
 The instance's `asHTML`. property holds a strong reference to its closure. However, because the closure referes to `self` within its body, the closure `captures` self, which means that it holds a strong reference back to the `HTMLElement` instance. A strong reference cycle is created between the two.
 
 If you set the `paragraph` varaible to `nil` and break its strong reference to the `HTMLElement` instance, neither the `HTMLElement` instance nor its closure are deallocated, because of the strong reference cycle:
 */

paragraph = nil

/**
 Note that the message in the `HTMLElement` deinitializer isn't printed, which shows that the `HTMLElement` instance isn't deallocated.
 
 
 
    Resolving Strong Reference Cycles for Closures
 You resolve a strong reference cycle between a closure and a class instance by defining a capture list as part of the closure's definition. A capture list defines the rules to use when capturing one or more reference types within the closure' body. As with strong reference cycles between two class instances, you declare each captured reference to be a weak or unowned reference rather than a strong reference. The appropriate choice of weak or unowned depends on the relationships between the different parts of your code.
 
            Swift requires you to write `self.someProperty` or `self.someMethod()` whenever you refer to a member of self within a closure. This helps you remember that it's possible to capture `self` by accident.
 
    Defining a Capture List
 Each item in a capture list is pairing of the `weak` or `unowned` keyword with a reference to a class instance or a variable initialized with some value. These parinings are writeen within a pair of square braces, separated by commas.

 
         lazy var someClosure = {
            [unowned self, weak delegate = self.delegate] (index: Int, stringToProcess: String) -> String in
                //closure
         }
 
 If a closure doesn't specify a parameter list or return type because theycan be inferred from context, place the capture list at the very start of the closure, followed by the `in` keyword;
 
        lazy var someClosure = {
            [unowned self, weak delegate = self.delegate] in
 
                //closure
    
        }
 

    Weak and Unowned References
 Define a capture in a closure as an unowned reference when the closure and the instance it captures will always refer to each other, and will always be deallocated at the same time.
 
 Conversely, define a capture as a weak reference when the captured reference may become `nil` at some point in the future. Weak references are always of an optional type, and automatically become `nil` when the instance they reference is deallocated. This enables you to check for thier existence within the closure's body
 
        If the captured reference will never become `nil`, it should always be captured as an unowned reference, rather than a weak reference.
 */


class HTMLElements {
    let name: String
    let text: String?
    
    lazy var asHTML: (() -> String) = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "</\(self.name)>"
        }
    }
    
    init (name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

/**
 This implementations of `HTMLElements` is identical to the previous implementation, apart from the addition of a capture list within the `asHTML` closure. In this case, the capture list is `[unowned self]`, which means "capture self as an unowned reference rather than a strong reference
 */

var para: HTMLElements? = HTMLElements(name: "p", text: "Hello, world")
print(para!.asHTML())

/**
 This time, the capture of `self` by the closure is an unowned reference, and doesn't keep a strong hold on the `HTMLElements` instance it has captured. If you set the strong reference from the `para` variable to `nil`, the `HTMLElements` instance is deallocated, as can be seen from the printing of its deinitializer message in the example below:
 */

para = nil










//: [Next](@next)
