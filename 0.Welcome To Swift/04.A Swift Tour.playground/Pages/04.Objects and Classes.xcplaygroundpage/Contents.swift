//: [Previous](@previous)
//:  # Objects and Classes

/**
 Use class follwed by the class's name to create a class. A property declaration in a class is written the same way as a constant or variable declaration. except that it's in the context of class. Likewise, method and function declarations are written the same way.
 */
 
class Shape {
    var numberOfSides = 0
    let staticNumber = 10
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides"
    }
    func printStaticNumber() -> String {
        return "Number : \(self.staticNumber)"
    }
}

var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()

/**
 This version of the 'Shape' class is missing something important: an initializer to set up the class when an instance is created. Use init to create one
 */

class NamedShape {
    var numberOfSides: Int = 0;
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides"
    }
}

/**
 Notice how 'self' is used to ditinguish the 'name' property from the 'name' arguement to the initializer. The arguemnts to the initializer are passed like a function call when you create an instance of the class. Every property needs a value assigned - either in its declaration (as with 'numberofSides') or in the initializer (as with 'name').
 
 Use 'deinit' to create a deinitializer if you need to perform some cleanup before the object is deallocated.
 
 Subclasses include their superclass name after their class name, separated by a colon. There's no requirement for classes to subclass any standard root class, so you can include or omit a superclass as needed.
 
 Method on a subclass that override the superclass's implementation are marked with 'override'-overriding a method by accident, without 'override', is detected by the compiler as an error. The compiler also detects methods with 'override' that don't actually override any method in th superclass.
 */

class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength;
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A sqaure with sides of length \(sideLength)"
    }
}

let test = Square(sideLength: 5.2, name: "myTestSquare")
test.area()
test.simpleDescription()


class Circle: NamedShape {
    private let radius: Double;
    
    init(radius: Double, name: String) {
        self.radius = radius
        super.init(name: name)
        numberOfSides = 0
    }
    
    func area() -> Double {
        return radius * radius * Double.pi
    }
    
    override func simpleDescription() -> String {
        return "A Circle with side of raius \(radius)"
    }
}
let test2 = Circle(radius: 1.2, name: "CIRCLE")
test2.area()
test2.simpleDescription()

/**
    In addition to simple properties that are stored, properties can have a getter and a setter
 */

class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get{
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)"
    }
}

var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)
triangle.perimeter = 9.9
print(triangle.sideLength)

/**
 In the setter for 'perimeter', the new value has the implicit name 'newValue'. You can provide an explicit name in parentheses after 'set'.
 
 Notice that the initializer for the EquilateraTriangle class has three different setps
 
    1. Setting the value of perperties that the subclass declares.
    2. Calling the superclass's initializer.
    3. Changing the value of properties defined by the superclass. Any additional setup work that uses methods, getters, or setters can also be done at this point.
 */

class TriangleAndSquare {
    
}



//: [Next](@next)
