//: Playground - noun: a place where people can play

import UIKit

// =========== 接口 ========

/**
 1. 简单的类实现protocol的方法 不需要mutating修饰方法，因为类的属性和实现都是透明的
 2. 声明的mutating关键字标记会修改结构体的方法，是因为要表示在方法中可以修改结构体和枚举的属性
 */
protocol ExampleProtocol {
    var simpleDescription : String{get}
    mutating func adjust()
}


class SimpleClass : ExampleProtocol{
    var simpleDescription : String = "A simple structure"
    var anotherProperty : Int = 1069
    func adjust() {
        anotherProperty += 10
        simpleDescription += "100% "
    }
}

var aa = SimpleClass()
aa.adjust()
aa.simpleDescription

let aDescription = aa.simpleDescription

struct SimpleStructure : ExampleProtocol{
    var simpleDescription: String = "B simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}

var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription


enum Rank : ExampleProtocol{
    case  First, Second, Third, Fouth
    //
    mutating internal func adjust() {

    }
    // 协议中有的属性
    var simpleDescription: String {
        get{
            switch self{
            case .First:
                return "first"
            case .Second:
                return "second"
            case .Third:
                return "third"
            case .Fouth:
                return "fouth"
            }
        }
        set {
            simpleDescription += newValue
        }
    }
}
var r = Rank.Second
r.simpleDescription
r.adjust()









    



// =============== 扩展 =======
/**
 1. extension 表示为现有的类型添加功能
*/
extension Int : ExampleProtocol
{
    var simpleDescription: String{
        return "The number \(self)"
    }
    
    mutating func adjust() {
        self += 42
    }
}

var abc : Int = 5
abc.simpleDescription
abc.adjust()

//======= Double的信息 =======
extension Double : ExampleProtocol{
    mutating internal func adjust() {
        
    }
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func absoluteValue() -> Double{
        if self > 0 {
            return self
        }else{
            return (self * -1)
        }
    }
}
var bb :Double = 5
bb.adjust()
bb.simpleDescription

var cc : Double = -1
cc.simpleDescription
cc.absoluteValue()


