import UIKit

class MinStack {
    
    var nums = [Int]()
    var minVal = Int.max
    /** initialize your data structure here. */
    init() {
        
    }

    func push(_ x: Int) {
        if x <= minVal {
            nums.append(minVal)
            minVal = x
        }
        nums.append(x)
    }

    func pop() {
        if (minVal == nums.removeLast()) {
            minVal = nums.removeLast()
        }
    }

    func top() -> Int {
        return nums.last!
    }

    func getMin() -> Int {
        return minVal
    }
    
}
