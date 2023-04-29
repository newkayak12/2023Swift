//: [Previous](@previous)
/*: # Deinitialization*/
/**
 A Deinitializer is called immediately before a class instance is deallocated. You write deinitializers with the deinit keyword, similar to how initializers are written with the init keyword. Deinitializers are only available on class types.
 
 
    How Deinitializatoin Works
 Swift automatically deallocates you instances when they're no longer needed, to free up resources. Swift handles ths memory management of instances through automatic reference counting(ARC). Typically you don't need to perform manual clean up when your instances are deallocated. However, when you are working with your own resources, you might need to perform some additional cleanup yourself. For example, if you create a custom class to open a file and write some data to it, you might need to close the file before the class instance is deallocated.
 
 Class definitions can have at most one deinitializer per class. The deinitializer doesn't take any parameters and is written without parentheses:
 */

//deinit {
//    // perform the deinitializer
//}

/**
 Deinitializers are called automatically, just before instance deallocation takes place. You aren't allowed to call a deinitializer yourself. Superclass deinitializers are inherited by their subclasses, and the superclass deinitializer is called automatically at the end of a subclass deinitializer implementatino. Superclass deinitializers are always called, even if a subclass doesn't provide its own deinitializer.
 
 Becuase an instance isnt' deallocated until after its deinitializer is called, a deinitailzier can access all properties of the instance it's called on and can modify its behavior based on those properties
 
 
    Deinitializers in Action
 Here's an example of a deinitializer in action. This example defines two new types, Bank and Player, for a simple game. The Bank class manages a made-up currency, which can nevner have more than 10_000 coins in circulation. There can only ever be one Bank in the game, and so the Bank is implemented as a class with type properties and methods to store and manager its current state:
 
 */
class Bank {
    static var coinsInBank = 10_000
    static func distribute( cons numberOfCoinsRequested: Int ) -> Int {
        let numberOfCoinsToVend = min( numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

/**
 Bank keeps track of the current number of coins it holds with its coinsInBank property: It also offers two methods - distribute(coins:) and receive(coins:) - to handle the distribution and collection of coins.
 
 The distribute(coins:) method checks that there are enough coins in the bank before distiributing them. If there aren't enough coins, Bank returns a smaller number than the number that was requested. It returns an integer value to indicate the actual number of coins that were provided.
 
 The receive(coins:) method simply adds the received number of coins back into the bank's coin store.
 
 The Player class desribes a player in the game. Each player has a certain number of coins stored in their purse at any time. This is represented by the player's conInPurse property:
 
 */

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(cons: coins)
    }
    func win(coins: Int){
        coinsInPurse += Bank.distribute(cons: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}

//: [Next](@next)
