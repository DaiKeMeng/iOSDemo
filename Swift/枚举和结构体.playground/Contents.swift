//: Playground - noun: a place where people can play

import UIKit

//==============枚举============
// enum 是枚举的标识符
enum Rank : Int{
    case Ace = 1
    case Two,Three,Four,Five,Six,Seven,Eight,Nine,Ten
    case Jake, Queen, King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jake:
            return "jake"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
// rawValue 表示的是此枚举在枚举表中的位置
let ace = Rank.Ace
let jake = Rank.Jake
let aceRawValue = ace.rawValue
let jakeRawValue = jake.rawValue


if let convertedRank = Rank(rawValue: 3){
    // simpleDescription 是对自身进行描述
    let threeDescription = convertedRank.simpleDescription()
}
// 拿到枚举中下标是3的枚举值
let convertedRank = Rank(rawValue: 3)!

//======练习
enum Suit{
    case Spades ,Hearts ,Diamonds, Clubs
    
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
    
    func Colors() -> String
    {
        switch self
        {
        case .Spades , .Clubs:
            return "black"
        case .Diamonds , .Hearts:
            return "red"
        }
    }
}

let hearts = Suit.Hearts

let HeartsDescription = hearts.simpleDescription()
let colorDescription = hearts.Colors()



// ============ 结构体 ==========
struct Card {
    var rank : Rank
    var suit : Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}

let threeOfSpades = Card(rank: .Three, suit: .Clubs)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()



// 练习  判断日出和日落时间

enum ServerResponse {
    case Result(String ,String)
    case Error(String)
}

let success = ServerResponse.Result("6.00 am", "8.09 pm")
let error = ServerResponse.Error("Out of Time")

switch success {
    
case let .Result(sunrise ,sunset):
    
    let serverResonse = "Sunrise is at \(sunrise) and sunset is at \(sunset)"
case let .Error(error):
    
    let serverResponse = "Failure .. \(error)"
}



protocol ExampleProtocol{
    var simpleDescription: String{
        get
    }
    mutating func adjust()
}

class SimpleClass : ExampleProtocol{
    var simpleDescription: String = "A very simple class."
    var anotherProperty : Int = 69105
    
    func adjust(){
        simpleDescription += "Now 100% adjusted."
    }
}

var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription
struct SimpleStructure : ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += "(adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription


