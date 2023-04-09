//: [Previous](@previous)
/*: # String*/
/**
    Strings are value type
 Swift's string type is a value type. If you create a new string value, that string value is copied when it's apssed to a function or method, or when it's assigned to a constant or variable. In each case, a new copy of the existing string value is created, and the new copy is passed or assigned, not the original version. Value type described in "Structures and Enumerations are Value Types."
 
 Swift's copy-by-default string behavior ensures that when a function or method passes you a string value, it's clear that you own that exact string value, regardless of where it came from. You can be confident that the string you are passed won't be modified unless you modify it yourself
 
 Behind the scenes, Swift's compiler optimizes string usage so that actual copying takes place only when absolutely necessary. This means you always get great performance when working with strings as value types.
 
 
    Accessing and Modifying a String
 You access and modify a string through its mothods and properties, or by using subscript syntax.
 
    String Indices
 Each String value has an associated index type, String.Index, which corresponds to the position of each Character in the string
 */

let greeting = "Guten Tag!"
greeting[greeting.startIndex]
greeting[greeting.index(before: greeting.endIndex)]
greeting[greeting.index(after: greeting.startIndex)]

let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]

/**
    ‘You can use the startIndex and endIndex properties and the index(before:), index(after:), and index(_:offsetBy:) methods on any type that conforms to the Collection protocol. This includes String, as shown here, as well as collection types such as Array, Dictionary, and Set.’
 
 
    Inserting and Removing
 To insert a single character into a string at a specified index, use the insert(_:at:) method, and to insert the contents of another string at a specified index, use the insert(contentsOf:at:) method.
 
 */

var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))

/**
 To remove a single character from a string at a specified index, use the remove(at:) method, and to remove a substring at a specified range, use the removeSubrange(_:) method:
 */

welcome.remove(at: welcome.index(before: welcome.endIndex))

let range = ( welcome.index(welcome.endIndex, offsetBy: -6) ..< welcome.endIndex )
welcome.removeSubrange(range)

/**
    Prefix and Suffix Equality
 To check whether a string ahs a particular string prefix or suffix, call the string's hasPrefix(_:) and hasSuffix(_:) methods, both of which take a single argument of type string and return a Boolean value.
 
 */

let remoeAndJueliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0;
var mansionCount = 0;
var cellCount = 0;
for scene in remoeAndJueliet {
   
    if scene.hasPrefix("Act 1") {
        act1SceneCount += 1;
    }
    
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1;
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1;
    }
    
}

print(act1SceneCount)
print(mansionCount)
print(cellCount)


//: [Next](@next)
