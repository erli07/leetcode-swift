import UIKit

var str = "Hello, playground"

NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/" + String(Date().timeIntervalSince1970)
NSTemporaryDirectory() + "1233132"
NSString(string: NSTemporaryDirectory()).appendingPathComponent("123")

func exchange(_ nums: inout [Int], _ i: Int, _ j: Int) {
    let t = nums[i]
    nums[i] = nums[j]
    nums[j] = t
//    nums.swapAt(i, j)
}

func bubble(_ nums: inout [Int]) {
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            if nums[i] > nums[j] {
                exchange(&nums, i, j)
            }
        }
    }
}

func selection(_ nums: inout [Int]) {
    for i in 0..<nums.count {
        var min = i
        for j in i+1..<nums.count {
            if nums[j] < nums[min] {
                min = j
            }
        }
        exchange(&nums, i, min)
    }
}

func insertion(_ nums: inout [Int]) {
    for i in 1..<nums.count {
        for j in 0..<i {
            if nums[i-j] < nums[i-j-1] {
                exchange(&nums, i-j, i-j-1)
            }
        }
    }
}

func merge(_ nums: inout [Int]) {
    
    var aux = Array(repeating: 0, count: nums.count)
    
    func merge1(_ nums: inout [Int], _ lo: Int, _ mid: Int, _ hi: Int) {
        for i in lo...hi {
            aux[i] = nums[i]
        }
        var i = lo, j = mid+1
        for k in lo...hi {
            if i > mid || j <= hi && aux[i] > aux[j] { //左半区已取完 or aux[i] > aux[j]
                nums[k] = aux[j]
                j += 1
            } else /*if j > hi || lo <= mid && aux[i] < aux[j]*/ { //右半区已取完
                nums[k] = aux[i]
                i += 1
            }
        }
    }
    
    func sort(_ nums: inout [Int], _ lo: Int, _ hi: Int) {
        if lo >= hi { return }
        let mid = (lo + hi) >> 1
        sort(&nums, lo, mid)
        sort(&nums, mid+1, hi)
        merge1(&nums, lo, mid, hi)
    }
    
    sort(&nums, 0, nums.count-1)
}

func quick(_ nums: inout [Int]) {
    
    func partition(_ nums: inout [Int], _ lo: Int, _ hi: Int) -> Int {
        
        var v = nums[lo], i = lo+1, j = hi
        while true {
            while nums[i] < v {
                if i == hi { break }
                i += 1
            }
            while nums[j] > v {
                if j == lo { break }
                j -= 1
            }
            if i >= j { break }
            nums.swapAt(i, j)
        }
        nums.swapAt(lo, j)
        return j
    }
    
    func sort(_ nums: inout [Int], _ lo: Int, _ hi: Int) {
        if lo >= hi { return }
        let j = partition(&nums, lo, hi)
        sort(&nums, lo, j-1)
        sort(&nums, j+1, hi)
    }
    
    sort(&nums, 0, nums.count-1)
}

func heap(_ nums: inout [Int]) {
    
    func sink(_ nums: inout [Int], _ k: Int, _ len: Int) {
        var k = k
        while k*2 <= len {
            var j = k*2
            if j < len && nums[j-1] < nums[j+1-1] { j += 1}
            if nums[k-1] >= nums[j-1] { break }
            exchange(&nums, k-1, j-1)
            k = j
        }
    }
    
    var len = nums.count
    var k = len/2
    while k >= 1 {
        sink(&nums, k, len)
        k -= 1
    }
    
    while len > 1 {
        exchange(&nums, 1-1, len-1)
        len -= 1
        sink(&nums, 1, len)
    }
    
}

var a = [3,9,6,1,8,5,7,2]
heap(&a)
print("heap: \(a)")




func sortColors(_ nums: inout [Int]) {
    var left = 0, right = nums.count-1, cur = 0
    while cur < right {
        if nums[cur] == 0 {
            nums.swapAt(cur, left)
            left += 1
        }
        if nums[cur] == 2 {
            nums.swapAt(cur, right)
            right -= 1
        }
        cur += 1
    }

}
