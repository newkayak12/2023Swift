//: [Previous](@previous)
/*: # Type Casting*/
/**
 Type casting is a way to check the type of an instance, or to treat that instance as a different superclass or subclass from somewhere else in its own class hierachy.
 
 Type casting in Swift is implemented with the 'is' and 'as' operators. These two operators provide a simple and expressive way to check the type of a value or cast a value to a difference type.
 
 You can also use type casting to check whether a type conforms to a protocol, as described in Checking for Protocol Conformance.
 
 
    Defining a Class Hierachy for Type Casting
 You can use type casting with a hierachy of classes and subclasses to check the type of a particular class instance and to cast that instance to another class within the same hierachy. The three code snippets below define a hierachy of classes and an array containing instances of those classes, for use in an example of type casting.
 
 The first snippet defines a new base class called MediaItem. this class provides basic functionality for any kind of item that appears in a digital media libaray. Specifically, it decalres a name proeprty of type String, and init name initializer.
 */

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

/**
 The next snippet defines two subclasses of MediaItem. The first subclass, Movie, encapsulates additional information about a movie or film. It adds a director proeprty on tope of the base MediaItem class, with a corresponding initializer. The second subclass, Song, adds an artist property and initializer on top of the base class:
 */

class Movie: MediaItem {
    
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

/**
 The final snippet creats a constant array called library, which contains two Movie instances and three Song instances. The type of the library array is inferred by initializing it with contents of an array literal. Swift's type checker is able to deduce that Movie and Song have a common superclass of MediaItem, and so it infers a type of [MediaItem] for the library array:
 */

let library = [
    Movie(name: "Csablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley"),
] //type: MediaItem
/**
 The items stored in library are still Movie and Song instances behind the scenes. However, if you iterate over the contents of this array, the items you receive back are typed as MediaItem, and not as Movie or Song. In order to work with them as their native type, you need to check their type, or downcast them to a differnt type, as described below.
 
 
    Checking Type
 Use the type check operator (is) to check whether an instance is of a certain subclass type. The type check operator returns true if the instance is of that subclass type and flase if it's not.
 
 The example below defines two variables, movieCount and songCount, which count the number of Movie and Song instance in the libarary array:
 */

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print(movieCount, songCount)

/**
 This example iterates through all items in the libaray array. On each pass, the for-in loop sets the item constant to the next MediaItem in the array.
 
 
    Downcasting
 A constant or variable of a certain class type may actually refer to an instance of a subclass behind the scenes. Where you believe this is the case, you can try to downcast to the subclass type with a type cast operator (as? or as!)
 
 Because downcasting can fail, the type cast operator comes in two different forms. The conditional form, as?, returns an optional value of the type you are trying to downcsat to. The foreced form, as!, attempts the downcast and force-unwraps the result as a single compound action.
 
 Use the forced form of the type cast operator (as!) only when you are sure that the downcast wil always succeed. This form of the operator will trigger a runtime error if you try to downcast to an incorrect class type.
 
 The example below iterates over each MediaItem in library, and prints an appropriate description for each item. To do this, it needs to access each item as a true Movie or Song, and not just as a MediaItem. This is necessary in order for it to be able to access the director or artist property of a Movie or Song for use in the description.
 
 */
for item in library {
    if let movie = item as? Movie {
        print( "Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}

/**
    Type Casting for Any and AnyObject
 Swift provdes two special types for working with nonspecific types:
 
    - Any can represnet an instance of any type at all, including function types.
    - AnyObject can represent an istance of any class type.
 
 Use Any and AnyObject only when you explicitly need the behavior and capabilities they provide. It's always better to be specific about the types you expect to work with in your code.
 
 Here's an example of using Any to work with a mix of different types including function types and nonclass types.
 
 */

var things: [Any] = []
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.141952)
things.append("Hello")
things.append((3.0, 5.0))
things.append(Movie(name: "GhostBusters", director: "Ivan Reitman"))
things.append({(name:String) -> String in "hello, \(name)"})

/**
 To discover the specific type of a constant or variable that's known only to be of type Any or AnyObject, you can use an is or as pattern in a swift statement's cases. The example below iterates over the items in the things array and queries the type of each item with a switch statement. Several of the switch statemen's cases bind their matched value to a constant of the specified type to enable its value to be printed:
 */

for thing in things {
    switch thing {
        case 0 as Int:
            print("zero as an Int")
        case 0 as Double:
            print("zero as an Double")
        case let someInt as Int:
            print("Int")
        case let someDouble as Double where someDouble > 0:
            print("Positive Double")
        case is Double:
            print("Double")
        case let someString as String:
            print("String")
        case let (x,y) as (Double, Double):
            print("tuple")
        case let movie as Movie:
            print("Movie")
        case let stringConverter as (String) -> String:
            print("closure")
        default:
            break;
    }
}


//: [Next](@next)
