import UIKit

//283. Move Zeroes
func moveZeroes(_ nums: inout [Int]) {

    var idx = 0
    for i in 0..<nums.count {
        if nums[i] != 0 {
            if i == idx { continue }
            nums[idx] = nums[i]
            idx += 1
        }
    }
    
    while idx < nums.count {
        nums[idx] = 0
        idx += 1
    }
}


//268. Missing Number
func missingNumber(_ nums: [Int]) -> Int {
    
    var t1 = 0, t2 = 0
    for i in 0..<nums.count {
        t1 += (i+1)
        t2 += nums[i]
    }
    return t1 - t2
}


//189. Rotate Array
func rotate(_ nums: inout [Int], _ k: Int) {
    
    func reverse(_ nums: inout [Int], _ lo: Int, _ hi: Int) {
        var lo = lo, hi = hi
        while lo < hi {
            nums.swapAt(lo, hi)
            lo += 1
            hi -= 1
        }
    }
    let k = k % nums.count
    reverse(&nums, 0, nums.count-1-k)
    reverse(&nums, nums.count-k, nums.count-1)
    reverse(&nums, 0, nums.count-1)
}


//169. Majority Element
func majorityElement(_ nums: [Int]) -> Int {

    var major = 0,  count = 0
    for n in nums {
        if count == 0 {
            major = n
            count += 1
        } else if major == n {
            count += 1
        } else {
            count -= 1
        }
    }
    return major
}


//118. Pascal's Triangle
func generate(_ numRows: Int) -> [[Int]] {
    guard numRows > 0 else { return [] }
    var prev = [Int](), res = [[1]]
    if numRows == 1 { return res }
    for i in 2...numRows {
        var arr = Array(repeating: 1, count: i)
        for j in 1..<i-1 {
            arr[j] = prev[j-1]+prev[j]
            //arr[j] = res[i-1][j-1]+res[i-1][j]
        }
        res.append(arr)
        prev = arr
    }

    return res
}


//88. Merge Sorted Array
func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    
    var i = m-1, j = n-1, k = m+n-1
    while i >= 0 && j >= 0 {
        if nums1[i] > nums2[j] {
            nums1[k] = nums1[i]
            i -= 1
        } else {
            nums1[k] = nums2[j]
            j -= 1
        }
        k -= 1
    }
    while j >= 0 {
        nums1[k] = nums2[j]
        k -= 1
        j -= 1
    }
}

//66. Plus One
func plusOne(_ digits: [Int]) -> [Int] {
    
    var i = digits.count-1, digits = digits
    while i >= 0 && digits[i] == 9 {
        digits[i] = 0
        i -= 1
    }
    
    if i == -1 {
        digits.insert(1, at: 0)
    } else {
        digits[i] += 1
    }
    
    return digits
}


//26. Remove Duplicates from Sorted Array
func removeDuplicates(_ nums: inout [Int]) -> Int {
    guard nums.count > 0 else { return 0 }
    var i = 0
    for j in 1..<nums.count {
        if nums[i] != nums[j] {
            i += 1
            nums[i] = nums[j]
        }
    }
    return i+1
}


//
func numDecodings(_ s: String) -> Int {

    
    return 0
}

//55. Jump Game
func canJump(_ nums: [Int]) -> Bool {
    
    var dis = 0, i = 0
    while i < dis {
        dis = max(i+nums[i], dis)
        if dis >= nums.count { return true }
        i += 1
    }
    return false
}


//73. Set Matrix Zeroes
func setZeroes(_ matrix: inout [[Int]]) {
    var rz = false, cz = false
    for i in 0..<matrix.count {
        if matrix[i][0] == 0 {
            cz = true
            break
        }
    }
    for n in matrix.first! {
        if n == 0 {
            rz = true
            break
        }
    }
    
    for i in 1..<matrix.count {
        for j in 1..<matrix.first!.count {
            if matrix[i][j] == 0 {
                matrix[i][0] = 0
                matrix[0][j] = 0
            }
        }
    }
    
    for i in 1..<matrix.count {
        for j in 1..<matrix.first!.count {
            if matrix[i][0] == 0 || matrix[0][j] == 0 {
                matrix[i][j] = 0
            }
        }
    }
    
    if rz {
        for i in 0..<matrix[0].count {
            matrix[0][i] = 0
        }
    }
    
    if cz {
        for i in 0..<matrix.count {
            matrix[i][0] = 0
        }
    }
    
    
}



//56. Merge Intervals
func merge(_ intervals: [[Int]]) -> [[Int]] {
    guard intervals.count > 1 else { return intervals }
    var prev = [Int](), res = [[Int]]()
    for interval in intervals.sorted(by: { return $0.first! < $1.first! }) {
        
        if interval[0] <= prev.last ?? Int.min {
            prev[1] = max(prev[1], interval[1])
        } else {
            if prev.count != 0 {
                res.append(prev)
            }
            prev = interval
        }
    }
    res.append(prev)
    
    return res
}


//54. Spiral Matrix
func spiralOrder(_ matrix: [[Int]]) -> [Int] {
    guard matrix.count > 1 else { return matrix.first ?? [] }
    let m = matrix.count, n = matrix.first?.count ?? 0
    var row_start = 0, row_end = m-1, col_start = 0, col_end = n-1, res = [Int]()
    
    while row_start < row_end || col_start < col_end {
        for i in col_start...col_end {
            res.append(matrix[row_start][i])
        }
        row_start += 1
        if row_start > row_end { break }
        
        for i in row_start...row_end {
            res.append(matrix[i][col_end])
        }
        col_end -= 1
        if col_start > col_end { break }
        
        for i in (col_start...col_end).reversed() {
            res.append(matrix[row_end][i])
        }
        row_end -= 1
        if row_start > row_end { break }
        
        for i in (row_start...row_end).reversed() {
            res.append(matrix[i][col_start])
        }
        col_start += 1
        print("row_start:\(row_start), row_end:\(row_end), col_start:\(col_start), col_end:\(col_end)")
    }

    return res
}


//48. Rotate Image
func rotate(_ matrix: inout [[Int]]) {
    
    let k = matrix.count
    
    for m in 0..<k {
        for n in m..<k {
            let t = matrix[m][n]
            matrix[m][n] = matrix[n][m]
            matrix[n][m] = t
        }
    }
    
    for m in 0..<k {
        for n in 0...k/2 {
            matrix[m].swapAt(n, k-n-1)
        }
        
    }
    
}



//11. Container With Most Water
func maxArea(_ height: [Int]) -> Int {
 
    var l = 0, r = height.count-1, area = 0
    while l < r {
        let h1 = height[l], h2 = height[r]
        area = max(area, min(h1, h2) * (r-l))
        if h1 > h2 {
            r -= 1
        } else {
            l += 1
        }
    }
    return area
}


func nSum(_ nums: [Int], _ target: Int, _ k: Int, _ lo: Int, _ hi: Int) -> [[Int]] {
    var res = [[Int]](), nums = nums
    
    for i in lo...nums.count-k {
        if nums[i] > 0 { break }
        if i == lo || nums[i] != nums[i-1] {
            if k > 2 {
                nSum(nums, target-nums[i], k-1, i+1, hi)
            } else {
                var lo = lo, hi = hi, sum = target-nums[i]
                while lo < hi {
                    let s = nums[lo] + nums[hi]
                    if s == sum {
                        
                    }
                }
                
            }
        }
        
    }
    
    
    return res
}

//18. 4Sum
func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
    guard nums.count > 3 else { return [] }
    var res = [[Int]](), nums = nums
    nums.sort()
    for i in 0..<nums.count-3 {
        if target > 0 && nums[i] > target { break }
        if i == 0 || nums[i] != nums[i-1] {
            //three sum
            for j in i+1..<nums.count-2 {
                if target - nums[i] > 0 && nums[j] > target - nums[i] { break }
                if j == i+1 || nums[j] != nums[j-1] {
                    
                    var lo = j+1, hi = nums.count-1, sum = target-nums[i]-nums[j]
                    while lo < hi {
                        let s = nums[lo] + nums[hi]
                        if s == sum {
                            res.append([nums[i], nums[j], nums[lo], nums[hi]])
                            while lo < hi && nums[lo] == nums[lo+1] { lo += 1 }
                            while lo < hi && nums[hi] == nums[hi-1] { hi -= 1 }
                            lo += 1
                            hi -= 1
                        } else if s < sum {
                            lo += 1
                        } else {
                            hi -= 1
                        }
                    }
                    
                }
            }
            
        }
    }

    return res
}

//15. 3Sum
func threeSum(_ nums: [Int]) -> [[Int]] {
    var res = [[Int]](), nums = nums
    nums.sort()
    for i in 0..<nums.count-2 {
        if nums[i] > 0 { break }
        if i == 0 || nums[i] != nums[i-1] {
            var lo = i+1, hi = nums.count-1, sum = -nums[i]
            while lo < hi {
                let s = nums[lo] + nums[hi]
                if s == sum {
                    res.append([nums[i], nums[lo], nums[hi]])
                    while lo < hi && nums[lo] == nums[lo+1] { lo += 1 }
                    while lo < hi && nums[hi] == nums[hi-1] { hi -= 1 }
                    lo += 1
                    hi -= 1
                } else if s < sum {
                    lo += 1
                } else {
                    hi -= 1
                }
            }
        }
    }
    
    return res
}
