//: [Previous](@previous)
//: # Advanced Operators

 /**
    Result Builders
 A `result builder` is a type you define that adds syntax for creating nested data, like a list or tree, in a natrual, decalartive way. The code that uses the result builder can include ordinary Swift syntax, like `if` and `for`, to handle conditional or repeated pieces of data.
  
 The code below defines a few types for drawing on a single line using stars and text.
  
 */

protocol Drawable {
    func draw() -> String
}
struct Line: Drawable {
    var elements: [Drawable]
    func draw() -> String {
        return elements.map { $0.draw() }.joined(separator: "")
    }
}

struct Text: Drawable {
    var content: String
    init( _ content: String ) { self.content = content }
    func draw() -> String {
        return content
    }
}
 
struct Space: Drawable {
    func draw() -> String {
        return " "
    }
}

struct Stars: Drawable {
    var length: Int
    func draw() -> String {
        return String(repeating: "*", count: length)
    }
}

struct AllCaps: Drawable {
    var content: Drawable
    func draw() -> String {
        return content.draw().uppercased()
    }
}

let name: String? = "Ravi Patel"
let manualDrawing = Line(elements: [
    Stars(length: 3),
    Text("Hello"),
    Space(),
    AllCaps(content: Text((name ?? "World") + "!")),
    Stars(length: 2)
])
 
print(manualDrawing.draw())
 
 /**
  The deeply nested parentheses after `AllCaps` are hard to read. The fallback logic to sue "World" when `name` is `nil` has to be done inline using the `??` operator, which would be difficult with anything more complex. If you needed to include switches or `for` loops to build up part of the drawing, there's no way to do that. A result builder lets you rewrite code like this so that it looks like normal Swift code.
  
  To define a result builder, you write the `@resultBuilder` attrivute on a type declaration. For example, this code defines a result builder called `DrawingBuilder`, which lets you use a declarative syntax to describe a drawing:
  */

@resultBuilder
struct DrawingBuilder {
    static func buildBlock ( _ components: Drawable...) -> Drawable {
        return Line(elements: components)
    }
    static func buildEither(first: Drawable) -> Drawable {
        return first
    }
    static func buildEither(second: Drawable) -> Drawable {
        return second
    }
}


/**
    The `DrawingBuilder` structure defines three methods that implement part of the result builder syntax. The `buildBlock(_:)` method adds support for writing a series of lines in a block of code. It combines the components in that block into a Line. The `buildEither(first:)` and `buildEither(second:)` add support for if-else.
 
    
 */
func draw( @DrawingBuilder content: () -> Drawable ) -> Drawable {
    return content()
}

func caps( @DrawingBuilder content: () -> Drawable ) -> Drawable {
    return AllCaps(content: content())
}

func makeGreeting(for name: String? = nil) -> Drawable {
    let greeting = draw {
        Stars(length: 3)
        Text("Hello")
        Space()
        caps {
            if let name = name {
                Text(name + "!")
            } else {
                Text("World!")
            }
        }
        Stars(length: 2)
    }
    return greeting
}

let personalGreeting = makeGreeting(for: "Ravi Patel")
print(personalGreeting.draw())

/**
 When you call those which is marked with the @DrawingBuilder attribute functions, you use the special syntax that `DrawingBuilder` defines. Siwft transforms that declarative description of a drawing into series of calls to the methods on `DrawingBuilder` to build up the value that's passed as the function argument.
 */

let capsDrawing = caps {
    let partialDrawing: Drawable
    if let name = name {
        let text = Text(name + "!")
        partialDrawing = DrawingBuilder.buildEither(first: text)
    } else {
        let text = Text("World!")
        partialDrawing = DrawingBuilder.buildEither(second: text)
    }
    return partialDrawing
}

/**
 Swift transforms the `if-else` block into calls to `buildEither(first:)` and `buildEither(second:)` methods. Although you don't call these mehtods in your own code, showing the result of the transformation makes it eaiser to see how Swift transforms your code when you use the `DrawingBuilder` syntax.
 
 To add support for writing `for` loops in the special drawing syntax, add a `buildArray(_:)` method.
 
 */


extension DrawingBuilder {
    static func buildArray(_ components: [Drawable]) -> Drawable {
         return Line(elements: components)
    }
}

let manyStars = draw {
    Text("Stars:")
    for length in 1 ... 3 {
        Space()
        Stars(length: length)
    }
}

print(manyStars)
//: [Next](@next)
