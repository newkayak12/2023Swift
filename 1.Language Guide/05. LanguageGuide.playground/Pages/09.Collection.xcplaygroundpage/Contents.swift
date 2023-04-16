//: [Previous](@previous)
/*: # Collection*/

/**
    Collection Types
    
 Swift provides three primary collection types, known as array, sets, and dictionaries, for storing collections of values. Arrays are ordered collectoins of values. Sets are unordered collectoins of unique values. Dictionaries are unordered collections of key-value associations
 
 Arrays, sets and dictionaries in Swift are always clear about the types of values and keys that they can store. this means that you can't insert a value of the wrong type into a collection by mistake. It also means you can be confident about the type of values you will retrieve from a collection.
 

    Mutablility of Collections
 If you create an array, a set, or a dictionary, and assign it to a variable, the collection that's created will be mutable. This means that you can  change (or mutable) the collection after it's create by adding, removing, or changing items in the collection. If you assign an array, a set, or a dictionary to a constant, that collection is immutable, and its size and contents can't be changed.
*/


/*: ## Array*/
/**
 
    Arrays
 an Array stores value of the same type in an ordered list. the same value can appear in an array multiple times at different positions.
 */
//Creating an Empty Array
var someInt: [Int] = []

//Creating an Array witha Default value
var threeDoubles = Array(repeating: 0.0, count: 3)

//Creating an Array by Adding Two Arrays Together
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)

var sixDoubles = threeDoubles + anotherThreeDoubles

//Create an Array with an Array Literal
var shoppingList: [String] = ["Eggs", "Milk"]

/**
    Accessing and Modifying an Array
 You access and modify an array through its methods and properties, or by using subscript syntax.
 
 To find out the number of items in an array, check its read-only count property:
 */
print("The shopping list contains \(shoppingList.count) items.")

/**
Use the Boolean isEmpty property as a shortcut for checking whether the count property is equal to 0:
 */
print(shoppingList.isEmpty)

//You can add a new item to the end of and Array by calling the array's append(_:) method
shoppingList.append("Orange")

// Alternatively, append an array of one or more compatible items with the addition assignment operator (+=):
shoppingList += ["BakingPowder"]

/**
 Retrieve a value from the array by using subscript syntax, passing the index of the value you want to retrieve within square brackets immediately after the name of the array:
 */

var firstItem = shoppingList[0]
shoppingList[0] = "Six eggs"

/**
When you use subscript syntax, the index you specify needs to be valid. For example, writing shoppingList[shoppingList.count] = "Salt" to trey to append an item to the end of the array results in a runtime error.
 
 You can also use subscript syntax to change a range of values at once, even if the replacement set of values has a different length than the range you are replacing. The following example replaces "Chocolate Spread", "Cheese" and "Butter" with "Bannas" and "Apple"
 */
print(shoppingList)
//shoppingList[4...6] = ["Bannas", "Apple"] //not work

/**
 To insert an item into the array at a specified index, call the array's insert(_:at:) method
 */
shoppingList.insert("Maple Syrup", at: 0)

/**
 Similarly, you remove an item from the array with the remove(at:) method. This method removes the item at the specified index and returns the removed item(altough you can ignore the returned value if you don't need it)
 
 
        ‘If you try to access or modify a value for an index that’s outside of an array’s existing bounds, you will trigger a runtime error. You can check that an index is valid before using it by comparing it to the array’s count property. The largest valid index in an array is count - 1 because arrays are indexed from zero—however, when count is 0 (meaning the array is empty), there are no valid indexes.’
 
 
    Iterating Over an Array
 
 You can iterate over the entire set of values in an array with the for-in loop:
 */

for item in shoppingList {
    print(item)
}

/**
 If you need the integer index of each item as well as its value, use the enumerated(0 method to iterate over the array instead. For each item in the array, the enumerated(0 method returns a typle composed of an integer and item. The integers start at zero an count up by one for each item; if you enumerate over a whole array. these integers match the item's indices. You can decompose the tuple into temporary constants or variables as part of the iteration.
 */

for (index, value) in shoppingList.enumerated() {
    print("\(index) : \(value)")
}


/*: ## Sets*/
/**
 A set sotres distinct values of the same type in a collection with no defined ordering. You can use a set instead of an array when the order of items isn't important, or when you need to ensure that an item only appears once
 
        Swift's Set type is bridged to Foundation's NSSet class
 
    Hash values for Set Types
 A type must be hashable in order to be stored in a set-that is, the type must provide a way to compute a hash value for itself. A hash value is an Int value that's the same for all objects that compare equally, such that if a == b, the hash value of 'a' is equal to the hash value of 'b'
 
 All of Swift's basic types (String, Int, Double and Bool) are hashable by default, and can be used as set value types or dictionary key types. Enumeration case values without associated value are also hashable by default
 
 
    Set Type Syntax
 The type of a Swift set is written as Set<Element>, where Element is the type that the set is allowed to store. Unlike arrays, sets dont'have an equivalent shorthand form.
 
    Creating and Initializing an Empty Set
 */
var letters = Set<Character>();

/**
    Creating a Set with an Array Literal
 You can aloso initialize a set with an array literal, as a shorthand way to write on or more values as a set collection.
 */

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]

/**
 The 'favoriteGenres' variable is decalred as "a set of String values", written as Set<String>. Because this particular set has specified a value type of 'String', it's only allowed to stroe String values. Here, the 'favoriteGenres' set is initialized with three 'String' values, written within an array literal.
 
 
        The favoriteGenres set is declared as a variable (with the var introducer) and not a constant (with the let introducer) because items are added and removed in the example below.
 
 A set type can't be inferred from an array literal alone, so the type 'Set' must be explicitly decalred. However, because of Swift's type inference, you dont' have to write the type of the set's elements. if you're initilaizing it with an array literal that contains value of just one type. The initialization of 'favoriteGenres' could have been written in a shorter form instaed:
 */

var favoriteGenres2: Set = ["Rock", "Classical", "Hip hop"]

/**
 Because all values in the array literal are of the smae type, Swift can infer the Set<String> is the correct type to use for the 'favortieGenres' variable.
 
        
        Accessing and Modifying a Set
 You access and modify a set through its methods and properties.
 To find out the number of items in a set, check its read-only 'count' property:
 
 >> favoriteGenres2.count
 
 Use the Boolean 'isEmpty' property as a shortcut for checking whether the count property is equal to 0:
 
 >> favoriteGenres2.isEmpty
 
 You can add a new item into a set by calling the set's insert(_:) method:
 
 >> favoriteGenres2.insert("Jazz")
 
 You can remove an item from a set by calling the set's remove(_:) method, which removes the item if it's a member of the set, and returns the removed value, or returns nil if the set didn't contain it. Alternatively, all items in a set can be removed with its 'removeAll()' method.
 
 >> favoriteGenres2.remove("Rock")
 
 To check whether a set contains a particular item, use the contains(_:) method.
 
 >> favoriteGenres2.contains("Funk")
 
 
        Iterating Over a Set
 You can iterate over the values in a set with a 'for-in' loop.
 
 
        Performing Set Operations
 You can efficiently perform fundamental set operations, such as combining two set together, determining wich values two sets have in common, or determining whether two sets contain all, some, or none of the same values.
 
        Fundamental Set Operations
 - Intersaction : Use the intersaction(_:) method to create a new set with only values common to both sets.
 - SymmetricDifference : Use the symmetricDifference(_:) method to create a new set with values in either set, but not both.
 - Union : Use the union(_:) method to create a new set with all of the vales in both sets.
 - Substracting : Use the substracting(_:) method to create a new set with values not in the specified set
 
 
        Set Membershop and Equality
 */
/*: ![img](set.png)*/
/**
 - Use the "is equal" operator ( == ) to determine whether two sets contain all of same values.
 - Use the isSubset(of:) method to determine whether all of the values of a set are contained in the specified set.
 - Use the isSuperset(of:) method to determine wheter a set contains all of the values in a specified set.
 - Use the isStrictSubset(of:) or isStrictSuperset(of:) methods to determine whether a set is a subset or superset, but not equal to, a specified set.
 - Use the isDisjoint(with:) method to determine whether two sets have no values in common.
 */


/*: # Dictionaries*/
/**
 A dictionary stores associations between keys of the same type and values of the same type in a collection with no defined ordering Each value is associated with a unique key, which acts as an identifier for that value within the dictionary. Unlike items in an array, items in a dictionary don't have a specified order. You use a dictionary when you need to look up values based on their identifier, in much the same way that a real-world dictionary is sued to loock up the definition for a particular word.
 
        Swift's Dictionary type is bridged to Foundation's NSDictionary class.
 
 
    Dictionary Type Shorthand Syntax
 The type of a Swift dictionary is written in full as Dictionary<Key, Value>, where Key is the type of value that can be used as a dictionary key, and 'Values' is the type of value that the dictionary stores for those keys.
 */




//: [Next](@next)
