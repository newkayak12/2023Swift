//: [Previous](@previous)
/*: # Subscript*/
/**
 Classes, structures, and enumerations can define 'subscript', which are shortcuts for accessing the member elements of a collection, list, or sequence. You use subscripts to set and retrieve values by index without needing separate methods for setting and retrieval.
 
 You can define multiple subscripts for a single type, and the appropriate subscript overload to use is selected base on the type of index value you pass to the subscript. Subscripts aren't limited to a ingle dimension, and you can define subscripts with multiple input parameters to suit you custom type's needs.
 
 
    Subscript Syntax
 Subscript enable you to query instances of a type by writing one or more values in sqaure brackets after the instance name. Their syntax is similar to both instance method syntax and computed property syntax. You write subscript definitions with the 'subscript' keyword, and specify one or more input parameters and a return type, in the same way as instance methods. Unlike instance methods, subscripts can be read-write or read-only. This behavior is communicated by a getter and setter in the same way as for computed properties:
 */

//subscript(index: Int) -> Int {
//    get {
//
//    }
//    set(newValue) {
//
//    }
//}

/**
 The type of 'newValue' is the same as the return value of the subscript. As with computed properties, you can choose not to specify the setter's '(newValue)' parameter. A default parameter called 'newValue' is provided to you setter if you don't provide one yourself.
 
 As with read-only computed properties, you can simplify the declaration of a read-only subscript by removing the 'get' keyword and its braces:
 */

//subscript(index: Int) -> Int {
//    //return an appropriate subscript value here
//    return 0
//}

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")


/**
    Subscript Usage
 The exact meaning of “subscript” depends on the context in which it’s used. Subscripts are typically used as a shortcut for accessing the member elements in a collection, list, or sequence. You are free to implement subscripts in the most appropriate way for your particular class or structure’s functionality.
 
 For example, Swift's Dictionary type implements a subscript to set and retrieve the values sotred in a Dictionary instance. You can set a value in a dictionary by providing a key of the dictionary's key type within subscript brackets, and assigning a value of the dictionary's value type to the subscript:
 */

var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2

/**
 The example above defines a variable called 'numberOfLegs' and initializes it with a dictionary literal containing three key-value pairs. The type of the numberOfLegs dictionary is inferred to be [String: Int]. After creating the dictionary, this example uses subscript assignment to add a String key of "bird" and an Int value of 2 to the dictionary.
 
        Swift's Dictionary type implements its key-value subscripting as a subscript that takes and returns an optional type.
 
 
    Subscript Options
 Subscripts can take any number of input parameters, and these input parameters can be of any type. Subscripts can also return a value of any type.
 
 Like functions, subscripts can take a varying number of parameters and provide default values for their parameters, as discussed in Variadic Parameters and Default Parameter Values. However, unlike functions, subscript can't use in-out parameters.
 
 A class or structure can provide as many subscript implementations as it needs, and the appropriate subscript to be used will be inferred based on the types of the value or values that are contained within the subscript brackets at the point that the subscript is used. This definition of multiple subscripts is known as subscript overloading.
 */

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int){
        self.rows = rows
        self.columns = columns
        
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

/**
 Matix provides an initializer that takes two parameters called rows and columns, and create an array that's large enough to store 'rows * columns' values of type Doulbe. Each position in the matrix is given an initial value of 0.0. To archieve this, the array's size, and an initial cell value of 0.0, are passed to an array initializer that creates and initializes a new array of the correct size. This initializer is described in more detail in Creating Array with a Default Value.
 
 */
var matrix = Matrix(rows: 2, columns: 2)

/**
 
 The example above creates a new Matrix instance with two rows and two columns. The grid array for this 'Matrix' instance is effectively a flattened version of the matrix, as read from top lef to bottom right:
 
 
 
 
    Type Subscript
 Instance subscripts, as described above, are subscripts that you call on an instance of a particular type. You can also define subscripts that are called on the type itself. This kind of subscript is called a type subscript. You indicate a type subscript by writing the 'static' keyword before the 'subscript' keyword. Classes can use the 'class' keyword instead, to allow subcalsses to override the superclass's implementation of that subscript.
 */
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}

let mars = Planet[4]
print(mars)


//: [Next](@next)
