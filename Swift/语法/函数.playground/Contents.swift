//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// 第一个父类 它的全部属性都要初始赋值
class NamedSquare {
    var name : String = ""
    var circle : Double = 0.0
    
    init(name : String , circle : Double) {
        self.name = name
        self.circle = circle
    }
    
    func descriptionNamed() -> String {
        return "A and B is brother"
    }
}


// 继承父类的时候，如果多定义了属性，必须在调用super.init方法之前对定义的属性进行赋值，继承父类的属性，在调用方法后赋值

/**   原因
 1. 因为构造器的
 */
class Circle : NamedSquare {
    var sideLength : Double
    init(sideLength : Double , name : String , circle : Double) {
        self.sideLength = sideLength
        super.init(name: name, circle: circle)
        self.circle = circle
        self.name = name
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func descriptionNamed() -> String {
        return "继承了父类的方法"
    }
}

var circle = Circle(sideLength: 20.0, name: "LiSijun", circle: 15)
circle.descriptionNamed()
circle.area()


//  属性的getter和setter方法

class EquilateralTriangle: NamedSquare
{
    var sideLength : Double = 0.0
    
    init(sideLength:Double ,name : String,circle :Double) {
        self.sideLength = sideLength
        super.init(name: name ,circle: circle)
    }
    
    var perimeter :Double{
        get{
            return 3.0 * sideLength
        }
        set{
            sideLength = newValue
        }
    }
    
    override func descriptionNamed() -> String {
        return "An equilateral triagle with sides of length \(sideLength)"
    }
}


var triangle = EquilateralTriangle(sideLength: 20, name: "wanghongwei", circle: 10)
triangle.perimeter
triangle.perimeter = 10
triangle.sideLength

// 保证三角形的边长和正方形的边长相等
/** 做法
 1. 设置一个父类
 2.
 3. 三角形和正方形的边长进行setter和getter方法
 4. 初始化父类的方法，传入参数有边长
 5. 在父类的初始化的时候把传入的参数 当作三角形和正方形的初始化的参数传入
 */

/****
  前提就是三角形和正方形都具有边长的属性，并且初始化方法中包含边长的参数
*/
// 1. 设置一个公共类
class TrangleAction{
    // 2. 三角形和正方形继承父类
    var triangle : EquilateralTriangle{
        //2.1 重写自身的setter方法
        willSet{
            triangle.sideLength = newValue.sideLength
        }
    }
    
    var square :EquilateralTriangle{
        //2.2 重写自身的setter方法
        willSet{
            square.sideLength = newValue.sideLength
        }
    }
    // 3. 设置公共类的初始化方法
    init(size : Double,name : String) {
        // 3.1 公共类的初始化方法中的参数传入到三角形和正方形的初始化方法中
        square = EquilateralTriangle(sideLength: size, name: name, circle: 20)
        triangle = EquilateralTriangle(sideLength: size, name: name, circle: 20)
    }
    
    var count : Int = 0
    func incrementBy(amount : Int,name : String) {
        count += amount
    }
}



var trangleAction = TrangleAction(size: 20, name: "LiLi")
trangleAction.square.sideLength
trangleAction.triangle.sideLength

trangleAction.incrementBy(amount: 10, name: "xiaohua")




func pragramsAction(name : String, age : Int){
    print("\(name) + \(age)")
}
pragramsAction(name: "丽丽", age: 18)



/**
    类中的参数和方法中的参数全部都要补全，不能省略第一个参数
 */
class Counter {
    var count: Int = 0
    func incrementBy(amount: Int, numberOfTimes
        times: Int) {
        count += amount * times
    }
}
var counter = Counter()
counter.incrementBy(amount: 2, numberOfTimes: 7)


/**
 输入输出参数 
 
 */

func swapTwoInts( a : inout Int, b : inout Int){
    let temporaryA = a
    a = b
    b = temporaryA
}


var aCount = 10
var bCount = 100

swap(&aCount, &bCount)

print("aCount : \(aCount)  bCount : \(bCount)")


