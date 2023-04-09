//: [Previous](@previous)
/*: # Operator*/
/**
    Terminology
 Operators are unary, binary or ternary:
 
    - Unary operator operate on a single target (such as -a), Unary prefix operator appear immediately before their target (such as !b), and unary postfix operators appear immediately after their target (such as c!)
 
    - Binary operators operate on two targets (such as 2 + 3) and infix becuase they appear in between their two targets.
 
    - Ternary operators operate on three targets. Like C, Swift has only one ternary operator, the tenrary conditonal operator ( a ? b : c)
 
 
 
    Nil-Coalescing Operator
 The nil-coalescing operator ( a ?? b ) unwraps an optional a if it contains a value, or return a default value b if a is nil. The expression a is always of an optional type. The expression b must match the type that's stored inside a.
 The nil-coalescing operator is shorthan for the code belowL
 */

// a != nil ? a! : b

/**
 The nil-coalescing operator provides a more elegant way to encapsulate this conditional checking and unwrapping in a concise and readable form.
 
    
 
        ‘If the value of a is non-nil, the value of b isn’t evaluated. This is known as short-circuit evaluation.’
 
 
 */





//: [Next](@next)
