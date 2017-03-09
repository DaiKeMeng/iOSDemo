//: Playground - noun: a place where people can play

import UIKit

// ======== 泛型 =========
// 是指任何类型的参数都能执行出一个任意类型的数组
func repeatAction<ItemType>(item : ItemType ,times : Int) -> [ItemType] {
    
    var result = [ItemType]()
    for _ in 0...times {
        result.append(item)
    }
    return result
}
repeatAction(item: [1,2] ,times: 4)


enum OptionalValus<T> {
    case None
    case Some(T)
}
var possibleInteger : OptionalValus<Int> = .None
possibleInteger = .Some(100)








