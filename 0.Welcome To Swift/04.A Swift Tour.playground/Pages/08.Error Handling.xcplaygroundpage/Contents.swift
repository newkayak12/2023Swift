//: [Previous](@previous)
/*: # Error Handling*/
/**
 You represent errors using any type that adopts the Error protocol
 */

enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}

/**
 Use throw to throw an error and throws to mark a function that can throw an error. If you throw an error in a function, the function returns immediately and the code that function the error.
 */

func send( job: Int, toPrinter printerName: String ) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    return "Job sent"
}

/**
 There are several ways to handle errors. One way is to use 'do-catch'. Inside the 'do' block, you mark code that can throw an error by writing try in front of it. Inside the catch lbock, the error is automatically given the name 'error' unless you give it a different name.
 */

do {
    let printResponse = try send(job: 1040, toPrinter: "Bi Sheng")
    print(printResponse)
    try send(job: 1040, toPrinter: "Never Has Toner")
} catch {
    print ( error )
}


/**
 You can provide multiple catch blocks that handle specific errors. you write a pattern after 'catch' just as you do after 'case' in a switch.
 */

do {
    let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
    print(printerResponse)
} catch PrinterError.onFire {
    print("I'll just put this over here, with the rest of the fire.")
} catch let printError as PrinterError {
    print("PRINT ERROR: \(printError)")
} catch {
    print(error)
}

/**
 Use 'defer' to write a block of code that's executed after all other code in the function, just before the function returns. The code is executed regardless of whether the function throws an error. You can use 'defer' to write setup and cleanup code next to each other, even though they need to be executed at different times.
 */


var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers"]

func fridgeContains( _ food: String ) -> Bool {
    fridgeIsOpen = true
    
    defer {
        fridgeIsOpen = false
    }
    
    let result = fridgeContent.contains(food)
    return result
}

fridgeContains("banana")
print(fridgeIsOpen)


//: [Next](@next)
