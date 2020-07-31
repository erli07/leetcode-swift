import UIKit

var str = "Hello, playground"

func lengthOfLIS(_ nums: [Int]) -> Int {

    return 1
}

func hIndex(_ citations: [Int]) -> Int {
    let citations = citations.sorted(by: >)
    let count = citations.count
    var i = 0
    while i < count && citations[count-1-i] > i {
        i += 1
    }
    return i
}

func hIndex2(_ citations: [Int]) -> Int {
    var l = 0, r = citations.count-1, count = r+1
    while l <= r {
        let mid = (l + r) >> 1
        if citations[mid] == count-mid {
            return count-mid
        } else if citations[mid] < count-mid {
            l = mid + 1
        } else {
            r = mid - 1
        }
    }
    return count - l
}

//240. Search a 2D Matrix II
func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
    var row = matrix.count
    guard row > 0 else { return false }
    let column = matrix[0].count
    guard column > 0 else { return false }
    
    row = row-1
    var col = 0
    while row >= 0 && col < column {
        if matrix[row][col] == target {
            return true
        }
        if matrix[row][col] < target {
            col += 1
        } else {
            row -= 1
        }
    }
    return false
}

//209. Minimum Size Subarray Sum
func minSubArrayLen(_ s: Int, _ nums: [Int]) -> Int {
    
    var res = Int.max
    var l = 0, r = 0
    var sum = 0
    while r < nums.count {
        while sum < s && r < nums.count {
            sum += nums[r]
            r += 1
        }
                
        if sum >= s {
            while sum >= s && l < r {
                sum -= nums[l]
                l += 1
            }
            res = min(res, r-l+1)
        }
        
    }
    
    return res == Int.max ? 0 : res
}

func search(_ nums: [Int], _ target: Int) -> Bool {

    var l = 0, r = nums.count-1
    while l < r {
        let mid = (l + r) >> 1
        if nums[mid] == target {
            return true
        } else if nums[l] == nums[r] {
            r -= 1
        } else if nums[mid] >= nums[l] {
            if nums[mid] > target && nums[l] <= target {
                r = mid - 1
            } else {
                l = mid + 1
            }
        } else {
            if nums[mid] < target && nums[r] >= target {
                l = mid + 1
            } else {
                r = mid - 1
            }
        }
    }
    
    return nums[l] == target
}

func divide(_ dividend: Int, _ divisor: Int) -> Int {
    var sign = 1, dividend = dividend, divisor = divisor
    if dividend < 0 {
        dividend = -dividend
        sign *= -1
    }
    if divisor < 0 {
        divisor = -divisor
        sign *= -1
    }
    
    var res = 0
    while dividend >= divisor {
        var temp = divisor, m = 1
        while temp << 1 <= dividend {
            temp <<= 1
            m <<= 1
        }
        res += m
        dividend -= temp
    }
    
    return res*sign > INT32_MAX ? Int(INT32_MAX) : res*sign
}

func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    guard nums1.count > 0, nums2.count > 0 else { return [] }
    var maps = [Int: Int]()
    var res = [Int]()
    nums1.forEach { maps[$0, default: 0] += 1 }
    nums2.forEach {
        if let val = maps[$0], val > 0 {
            res.append($0)
            maps[$0] = val-1
        }
    }
    return res
}

func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var maps = [Int: Int]()
    nums1.forEach { maps[$0] = 1 }
    if maps.count == 0 { return [] }
    nums2.forEach {
        if let _  = maps[$0] {
            maps[$0]! += 1
        }
    }
    return Array(maps.filter { $0.value > 1 }.keys)
}




func nextGreatestLetter(_ letters: [Character], _ target: Character) -> Character {
    var l = 0, r = letters.count
    while l < r {
        let mid = (l + r) >> 1
        if letters[mid] <= target {
            l = mid + 1
        } else {
            r = mid
        }
    }
    return l == letters.count ? letters[0] : letters[l]
}

func findClosestElements(_ arr: [Int], _ k: Int, _ x: Int) -> [Int] {
    var arr = arr
    arr.sort { return abs($0-x) < abs($1-x) }
    return Array(arr[0..<k])
}

func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
    var res = [-1, -1]
    guard nums.count > 0 else { return res }
    var l = 0, r = nums.count-1
    while l < r {
        let mid = (l + r) >> 1
        if nums[mid] >= target {
            r = mid
        } else {
            l = mid + 1
        }
    }
    if nums[l] != target { return res }
    res[0] = l
    
    r = nums.count-1
    while l < r {
        let mid = (l + r) >> 1
        if nums[mid] <= target {
            l = mid + 1
        } else {
            r = mid
        }
    }
    res[1] = l
    
    return res
}

func search(_ nums: [Int], _ target: Int) -> Int {
    guard nums.count > 0 else { return -1 }
    var l = 0, r = nums.count-1
    while l < r {
        let mid = (l + r) >> 1
        if mid == target {
            return mid
        } else {
            
            if nums[l] < nums[mid] {
                if nums[mid] > target && nums[l] < target {
                    r = mid - 1
                } else {
                    l = mid + 1
                }
            } else {
                if nums[mid] < target && nums[r] > target {
                    l = mid + 1
                } else {
                    r = mid - 1
                }
            }
        }
    }
    return nums[l] == target ? l : -1
}

func mySqrt(_ x: Int) -> Int {
    var l = 0, r = Int.max
    while l < r {
        let mid = (l + r) >> 1
        let square = mid * mid
        if square == x {
            return mid
        } else if square > x {
            r = mid - 1
        } else {
            l = mid
        }
    }
    return l
}

do {
    func search(_ nums: [Int], _ target: Int) -> Int {
        var left = 0, right = nums.count
        while left < right {
            let mid = (left + right) >> 1
            if nums[mid] == target {
                return mid
            } else if nums[mid] < target {
                left = mid+1
            } else {
                right = mid-1
            }
        }
        return -1
    }
    
    let idx = search([-1,0,3,5,9,12], 9)
    print(idx)
}
