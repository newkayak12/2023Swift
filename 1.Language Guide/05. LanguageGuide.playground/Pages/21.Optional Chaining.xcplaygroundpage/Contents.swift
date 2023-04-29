//: [Previous](@previous)
/*: # Optional Chaining*/
/**
 Optional chaining is a process for querying and calling properties, methods, and subscripts on an optional that might currently be nil, If the optional contains a value, the property, method, or subscript call succeeds; if the optional is 'nil', the property, method, or subscirpt call returns nil. Multiple queries can be chained together, and the entire chain fails gracefully if any link in the cahin is nil.
 
            Optional chaining in Swift is similar to messaging nil in Objective-C, but in a way that works for any type, and that can be checkd for success or failure.
 
    Optional Chaining as an Alternative to Force Unwrapping
 You specify optional chaining by placing a question mark (?) after the optional value on which you wish to call a property, method or subscript if the optional is non-nil. This is very similar to placing an exclmation point (!) after an optional value to force the unwrapping of its value. The main difference is that optional chaining fails gracefully when the optional is nil, whereas forced unwrapping triggers a runtime error when the optional is nil.
 
 To reflect the fact that optional chaining can be called on a nil value, the result of an optional chaining call is always an optional value, even if the property, method, or subscript you are querying returns a non-optional value. You can use this optional return value to check whether the optional chaining call was successful, or didn't succeed due to a nil value in the chain.
 
 Specifically, the result of an optional chaining call is of the same type as the expected return value, but wrapped in an optional. A property that normally returns an Int will return an Int? when accessed through optoinal chaining.
 
 The next several code snippets demonstrate how optional chaining differs from forced unwrapping and enables you to check for success.
 */

class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

/**
 Residence instances have a single Int property called numberOfRooms, with a default value of 1. Person instances have an optional residence property of type Residence?.
 
 If you create a new Person instance, its residence property is default initialized to nil, by virtue of being optional. Int the code below, john has a residence property value of nil:
 */

let john = Person()

/**
 If you try to access the numberOfRooms property of this person's residence, by placing an exclamatoin point after residence to force the unwrapping of tis value, you trigger a runtime error, because there's no residence value to unwrap
 */

//let roomCount = john.residence!.numberOfRooms
//runtimeError

/**
 The code above succeeds when john.residence has a non-nil value and will set roomCount to an Int value containing the appropriate number of rooms. However, this code always triggers a runtime error when 'residence' is nil, as illustrated above.
 
 Optional chaining provides an alterantvie way to access the value of numberOfRooms. To use optional chaining, use a question mark in place of the exclamation point:
 */

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms")
}

/**
 This tells Swift to "chain" on the optional residence property and to retrieve the value of numberOfRooms if residence exists.
 
 Because the attempt to access numberOfRooms has the potential to fail, the optional chaining attept returns a value of the Int?, or "optional Int". When residence is nil, as in the example above, this optional Int will also be nil, to reflect the fact that it was not possible to access numberOfRooms. the optional Int is accessed through optional binding to unwrap the integer and assign the non-optional value to the roomCount constant.
 
 Note that this is true even though numberOfRooms is a non-optional Int. The fact that it's queried through an optional chain means that the call to numberOfRooms will always return an Int? instead of an Int.
 
 You can assign a Residence instance to join.residence, so that it no longer has a nil value:
 */

john.residence = Residence()

/**
 john.residence now contains an actual Residence instance, rather than nil. If you try to access numberOfRooms with the same optional chaining as before, it will now return an Int? that contains the default numberOfRooms value of 1:
 */

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms.")
}

/**
    Defining Model Classes for Optional Chaining
 You can use optional chaining with calls to properties, methods, and subscript that are more than ove level deep. This enables you to drill down into subproperties within complex models of interrelated types, and to check whether it's possible to access properties, methods, and subscripts on those subproperties.
 
 The code snippets below define four model classes for use in several subsequent examples, including examples of multilevel optoinal chaining. These classes expand upon the Person and Residence model from aobve by adding a Room and Address class, wtih associated properties, methods, and subscripts
 */

class PersonClazz {
    var residence: ResidenceClazz?
    
}
class ResidenceClazz {
    var rooms: [Room] = []
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript( i: Int ) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name}
}
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

/**
    Accessing Properties Through Optional Chaining
 As demonstrated in Optional Chaining as an Alternative to Forced Unwrapping, you can use optional chaining to access a prorperty on an optional value, and to check if that property access is successful.
 
 Use the classes defined above to create a new Person instance, and try to access its numberOfRooms property as before:
 */
let john2 = PersonClazz()
if let roomCount = john2.residence?.numberOfRooms {
    print("John residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms.")
}

/**
 Because john.residence is nil, this optional chaining call fails in the same way as before.
 You can also attpempt to set a property's value through optional chaining:
 
 */

let someAddress = Address()
someAddress.buildingName = "29"
someAddress.street = "Acacia Road"
john2.residence?.address = someAddress

/**
 In this example, the attempt to set the address proeprty of john.residence will fail, because john.residence is currently nil.
 
 The assignment is part of the optional chaining, which means none of the code on the right-hand side of the - operator is evaluated. In the previous exampe, it's not easy to see that someAddress is never evalutated, becuase accessing a constant doesn't have any side effects. the listing below does the same assignment, but it uses a funciton to create the address. The function print("function was called") before returning a vaulue, which lets you see whether the right-hand side of - operator was evaluated.
 */

func createAddress() -> Address {
    print("Function was called")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}

john2.residence?.address = createAddress()

/**
    Calling Methods Through Optional Chaining
 You can use optional chaining to call a method on an optional value, and to check whether that method call is successful. You can do this event if that method doesn't defin a return value.
 
 The printNumberOfRooms() method on the Residence class prints the current value of numberOfRooms.
 */

//func printNumberOfRooms() {
//    print("The number of rooms is \(numberOfRooms)")
//}
//#line 99

/**
 This method doesn't specify a return type. However, functions and methods with no return type have an implicit return type of Void, as described in Functions Without Return Values. This mean that they return a value of (), or an empty tuple.
 
 If you call this method on an optional value with optional chaining, the method's return type will be Void?, not Void, because return values are always of an optional type when called through optional chaining. This enables you to use an if statement to check whether it was possible to call the printNumberOfRooms() method, even though the method doesn't itself define a return value.
 */


if john2.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

/**
 The same is true if you attempt to set a property through optional chaining. The example above in Accessing Properties Through Optional Chaining attempts to set an address value for john.residence, even though the residence property is nil. Any attempt to set a property through optional chaining returns a value of type Void?, which enables you to compare against nil to see if the property was set successfully.
 */

if ( john2.residence?.address = someAddress ) != nil {
    print("It was possible to set the address")
} else {
    print("It was not possible to set the address")
}


/**
    Acessing Subscripts Through Optional Chaining
 You can use optional chaining to try to retrieve and set a value from a subscript on an optional value, and to check whether that subscript call is successful.
 
                When you access a subscript on an optional value through optional chaining, you place the question mark before the subscript's brackets, not after. The optional chaining question mark always follows immediately after the part of the expression that's optional.
 
 The example below tries to retrieve the name of the first room in the rooms array of the john.residence property using the subscript defined on the Residence class. Because john.residence is currently nil, the subscript call fails
 */

if let firstRoomName = john2.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrieve the first room name.")
}

/**
The optional chaining question mark in this subscript call is placed immediately after john.residence, before the subscript brackets, because john.residence is the optional value on which optional chaining is being attempted.
 
 Similiary, you can try to set a new value through a subscript with optional chaining:
 */

john2.residence?[0] = Room(name: "Bathroom")

/**
This subscript setting attempt also fails, becuase residence is currently nil.
 
 If you create and assign an actual Residence instance to john.residence, with one or more Room instances in its rooms array, you can use the Residence subscript to access the actual items in the rooms array through optional chaining:
 */

let johnsHouse = ResidenceClazz()
johnsHouse.rooms.append(Room(name: "living room"))
johnsHouse.rooms.append(Room(name: "kitchen"))
john2.residence = johnsHouse

if let firstRoomName = john2.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrieve the first room name")
}

/**
    Accessing subscripts of Optional Type
 If a subscript returns a value of optional type - such as the key subscript of Swift's Dictionary type - place a question mark after the subscript's closing bracket to chain on its optional return value:
 */
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brain"]?[0] = 72


/**
    Linking Multiple Levels of Chaining
 
 */


//: [Next](@next)
