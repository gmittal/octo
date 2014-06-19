// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

enum AllColors : String {
    case Turquoise = "Turq", Dryers = "dryers", Toasters = "toasters"
    
    static let allValues = [Turquoise, Dryers, Toasters]
}

var myColor = AllColors.Turquoise
println("\(myColor)")
myColor.toRaw()

//var string:String = myColor

enum Suit: Int {
    case Spades = 1
    case Hearts, Diamonds, Clubs
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
}

