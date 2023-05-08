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

//: [Next](@next)
