//: [Previous](@previous)
/*: # Tuples*/

/**
 
 
 Tuples
 
 'Tuples' group mutliple values into a single compound value. The values within a tuple can be of any type and don't have to be of the same type as each other.
 
 In this example, (404, "Not Found") is a tuple that describes an HTTP status code. An Http status code is a special value returned by a web server whenever you request a web page. A status code of 404 Not Found is returned if you request a webpage that doesn't exist.
 */

let http404Error = (404, "Not Found")

/**
 The (404, "Not Found") tuple groups together an 'Int' and a 'String' to give the HTTP status code two sperate values: a number and a human-readable description. It can be described as "a tupe of type '(Int, String)'.
 
 You can create tuples from any permutation of types, and they can contain as many different type as you like There's nothing stopping you from have a tuple of type '(Int, Int, Int)', or '(String, Bool)', or indeed any other permutation you require.
 
 You can decompose a tuple's contents into seperate constants or variables, which you then access as usual:
 */

let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")


/**
 If you onley need some of the tuple's value, ignore part of the tuple with an underscore(_) when you decompose the tuple:
 */
let (justTheStatusCode, _) = http404Error
print("The status code is \(statusCode)")

/**
 Alterenatively, access the individual element values in a tuple using index number starting at zero:
 */
print("The status code is \(http404Error.0)")
print("The status message is \(http404Error.1)")

/**
 You can name the individual elements in a tuple when the tuple is defined:
 */

let http200Status = ( statusCode: 200, description: "OK" )

/**
 If you name the elements in a tuple, you can use the element names to access the values of those elements:
 */

print(http200Status.statusCode, http200Status.description)

//: [Next](@next)
