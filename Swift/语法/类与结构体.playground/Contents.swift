//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


// 类与结构体
//  相同点
/**
 1. 定义属性用于储存值
 2. 定义方法用于提供功能
 3. 定义下标用于通过下标语法访问值
 4. 定义初始化器用于生成初始化值
 5. 通过扩展以增加默认实现的功能
 6. 符合协议以对某类提供标准功能
 */

//  不同点
/**
 1. 继承       允许一个类继承另一个类的特征
 2. 类型转换    允许在运行时检查和解释一个类实例的类型
 3. 取消初始化器 允许一个类实例释放任何其所被分配的资源
 4. 引用计数    允许对一个类的多次引用
 */


// 结构体
struct DKMSPerson{
    var name : String
    var age : Int
    var sex : String
}

var sPerson = DKMSPerson(name: "小明", age: 18, sex: "男")


extension DKMSPerson {
}




// 类
class DKMCPerson : NSObject{
    var name : String?
    var age : Int = 0
    var sex : String?
    
    init(name : String ,age : Int , sex : String) {
        self.name = name
        self.age  = age
        self.sex  = sex
    }
}

extension DKMCPerson{
     func propertyList() {
        var count: UInt32 = 0
        let prolist = class_copyPropertyList(self.classForCoder, &count)
        for i in 0..<Int(count) {
            let pro = prolist?[i]
            // 获取 `属性` 的名称C语言字符串
            let proString = property_getName(pro!)
            // 转化成 String的字符串
            let proName = String(utf8String: proString!)
            print(proName!)
        }
        // 释放 C 语言的对象
        free(prolist)
    }
}

var cPerson = DKMCPerson(name: "小红", age: 19, sex: "女")
cPerson.propertyList()



class DKMCPerson1:DKMCPerson{
}


// 字典的操作过程中的copy
/**
 1. 字典的键值如果都是值类型 则字典赋值的时候就是copy操作
 */
var ages = ["peter":23,"wei":35,"anish":44]
let copiesAges = ages
ages["peter"] = 20
copiesAges["peter"]

// 2. 如果值是引用类型
var person = ["person": cPerson]
let copiesP = person
person["person"]?.age = 30
copiesP["person"]?.age

// 数组操作工程中的copy
// 1. 在数组中元素如果是值类型，都是值类型copy,都是独立的
// 2. 元素如果是类，则都是引用类型，一次修改，别的地方也都进行了修改
var a = [cPerson,2,3] as [Any]
let b = a
let c = a
(a[0] as! DKMCPerson).age = 25
(b[0] as! DKMCPerson).age
(c[0] as! DKMCPerson).age

a.append(4)
a[0] = 77
b[0]
c[0]





