//: Playground - noun: a place where people can play

import UIKit


// ======== 类型别名 =======
// typealias 是给原有的类进行名字更改
typealias DKMString = String

var name : DKMString = "DKM"

// String 要转换成为字符才能拿取长度
let count = name.characters.count

for item in name.characters
{
    print(item)
}
/**
 swift 中判断句只能是Bool类型，不能进行整数类型(没有非空及真的概念)
 */
// ========== 元祖的概念
let http404Error = (404,"Not Found")

// 取出元祖里面的元素可以用下标
http404Error.0
http404Error.1

// 如果不用的参数可以用 _ 表示
let (statusCode,_) = http404Error

print("The status code is \(statusCode)")

//print("The status code is \(statusMessage)")

// 可以给元祖里面的元素添加参数名

let http200Status = (statusCode : 200 ,description : "OK")
// 取值可以进行下标和参数名，跟字典的概念很像
http200Status.0
http200Status.statusCode

http200Status.1
http200Status.description





// =========== optionals ==============
//  当数值无法判定为空的时候进行的一种容错措施

// 当有值的时候就用值，没值的时候就取空nil

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)

if (convertedNumber != nil) {
    print("\(possibleNumber) has an integer value of \(convertedNumber)")
}else{
    print("\(possibleNumber) could not be converted to an integer")
}


//  =========== 断言 =========
func absertActionFun(item : AnyObject) -> Bool
{
    if item != nil {
        return true
    }else{
        return false
    }
}
var aString  = String()
absertActionFun(item: aString as AnyObject)




// ======== 区间运算符
/**
 1. 区间运算符 : a...b 包括a和b的区间  a..b 包括a但是不包括b
 */
let names = ["xiaowang","xiaoli","xiaoming","xiaohong"]
let nCount = names.count

//for index in 0...nCount-1{
//    print("第\(index + 1)个人叫\(names[index])")
//}

//  结构体 值类型
struct CRectangle{
    var width : Int
}
var cRect = CRectangle(width : 200)
cRect.width

//  类    引用类型
class SRectangle{
    var width = 200
}
var s = SRectangle()
s.width


// 组合逻辑

let result1 = false
let result2 = false
let result3 = true


if result1 && result2 || result3 {
    print("正确")
}else{
    print("错误")
}


let valueString = "小红，小王，小孩"
// 获取字符串的长度
valueString.characters.count

let names1 = ["小红","小孩","小强","小明"]
for (index,value) in names1.enumerated(){
    print("Item \(index + 1) : value : \(value)")
}

var strArrays = [AnyObject]()

strArrays.append("小明" as AnyObject)
strArrays.append(18 as AnyObject)

if String(describing: strArrays.first!) == "小明"{
   print("是小明")
}else{
    print("不是")
}

if strArrays[1] as! NSNumber == 18{
    print("是18岁")
}else{
    print("不是")
}

// fallthrough  贯穿，主要是在switch语句中为了激活下一个case
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2,3,4,5,6,7,8,9:
    description += " a prime number, and alse "
    fallthrough
case 10,11:
    description += " a  "
    
default:
    description += "an integer"
}

