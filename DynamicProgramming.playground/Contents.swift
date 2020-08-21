import UIKit

//279. Perfect Squares
func numSquares(_ n: Int) -> Int {
    var dp = Array(repeating: Int.max, count: n+1)
    dp[0] = 0
    for i in 1...n {
        var j = 1
        while j * j <= i {
            dp[i] = min(dp[i], dp[i-j*j] + 1)
            j += 1
        }
    }
    return dp[n]
}

//213. House Robber II
func rob2(_ nums: [Int]) -> Int {
    if nums.count < 2 { return nums.last ?? 0 }
    func rob(_ nums: [Int], _ lo: Int, _ hi: Int) -> Int {
        var a = 0, b = 0
        for i in lo..<hi {
            let temp = b
            b = max(a+nums[i], b)
            a = temp
        }
        return b
    }
    return max(rob(nums, 0, nums.count-1), rob(nums, 1, nums.count))
}


//198. House Robber
func rob(_ nums: [Int]) -> Int {
    var a = 0, b = 0
    for val in nums {
        let temp = b
        b = max(a+val, b)
        a = temp
    }
    return b
    
//    let n = nums.count
//    if n == 0 { return 0 }
//    for i in 0..<n {
//        if i % 2 == 0 {
//            a1 = max(a1+nums[i], a2)
//        } else {
//            a2 = max(a2+nums[i], a1)
//        }
//    }
//    return max(a1, a2)
    
//    var dp = Array(repeating: 0, count: n+1)
//    dp[1] = nums[0]
//    for i in 2...n {
//        dp[i] = max(dp[i-1], dp[i-2] + nums[i-1])
//    }
//    return dp[n]
}


//139. Word Break
func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
    let n = s.count, s = Array(s), wordDict = Set(wordDict)
    var dp = Array(repeating: false, count: n+1)
    dp[0] = true
    for i in 1...n {
        for j in 0..<i {
            if dp[j] &&  wordDict.contains(String(s[j..<i])) {
                dp[i] = true
                break
            }
        }
    }
    
    return dp[n]
}


//91. Decode Ways
func numDecodings(_ s: String) -> Int {
    var dp = Array(repeating: 0, count: s.count+1), s = Array(s)
    dp[0] = 1
    dp[1] = s[0] == "0" ? 0 : 1
    if s.count < 2 { return dp[1] }
    for i in 2...s.count {
        if s[i-1].wholeNumberValue! > 0 {
            dp[i] += dp[i-1]
        }
        let val = s[i-2].wholeNumberValue! * 10 + s[i-1].wholeNumberValue!
        if val >= 10 && val <= 26 {
            dp[i] += dp[i-2]
        }
    }
    return dp[s.count]
}


//63. Unique Paths II
func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
    
    var dp = obstacleGrid.map { (grids) -> [Int] in
        grids.map({ ($0+1)%2 })
    }
    
    let m = dp.count, n = dp.first!.count
    var grid = obstacleGrid
    for i in 0..<m {
        for j in 0..<n {
            
            if grid[i][j] == 1 { grid[i][j] = 0 }
            else if i == 0 && j == 0 { grid[i][j] = 1 }
            else if i == 0 { dp[i][j] = dp[i][j-1] }
            else if j == 0 { dp[i][j] = dp[i-1][j] }
            else { dp[i][j] = dp[i-1][j] + dp[i][j-1] }
            
        }
    }
    
    for i in 0..<m {
        for j in 0..<n {
            
            if dp[i][j] == 0 { continue }
            if i == 0 && j == 0 { continue }
            if i == 0 { dp[i][j] = dp[i][j-1] }
            else if j == 0 { dp[i][j] = dp[i-1][j] }
            else { dp[i][j] = dp[i-1][j] + dp[i][j-1] }
        }
    }
    
    return dp.last?.last ?? 0
}


//62. Unique Paths
func uniquePaths(_ m: Int, _ n: Int) -> Int {
    
    var dp = Array(repeating: Array(repeating: 1, count: n), count: m)
    
    for i in 1..<m {
        for j in 1..<n {
            dp[i][j] = dp[i-1][j] + dp[i][j-1]
        }
    }
    return dp[m-1][n-1]
}
uniquePaths(7, 3)



//5. Longest Palindromic Substring
func longestPalindrome(_ s: String) -> String {
 
    guard s.count > 1 else { return s }
    var lo = 0, len = 0, s = Array(s)
    func helper(_ s: [Character], _ i: Int, _ j: Int) {
        var i = i, j = j
        while i >= 0 && j < s.count && s[i] == s[j]  {
            i -= 1
            j += 1
        }
        
        if j-i-1 > len {
            lo = i+1
            len = j-i-1
        }
    }
    
    for i in 0..<s.count-1 {
        helper(s, i, i)
        helper(s, i, i+1)
    }
    
    return String(s[lo..<lo+len])
}

longestPalindrome("abbs")


//121. Best Time to Buy and Sell Stock
do {
    func maxProfit(_ k: Int, _ prices: [Int]) -> Int {
        let n = prices.count
        //dp = [Int][n][k+1][2]
        var dp = Array(repeating: Array(repeating: Array(repeating:0, count: 2), count: k+1), count: n)
        for i in 0..<n {
            var k = k
            while k > 0 {
                if i == 0 {
                    dp[i][k][0] = 0
                    dp[i][k][1] = Int.min
                    k -= 1
                    continue
                }
                dp[i][k][0] = max(dp[i-1][k][0], dp[i-1][k][1] + prices[i])
                dp[i][k][1] = max(dp[i-1][k][1], dp[i-1][k-1][0] - prices[i])
                k -= 1
            }
        }
        return dp.last?[k][0] ?? 0
    }
}
func maxProfit(_ prices: [Int]) -> Int {
 
    let n = prices.count
    //dp[n][0/1] n: prices.count 0:未持有 1:持有
    var dp = Array(repeating: Array(repeating: 0, count: 2), count: n)
    
    var dp_i1_0 = 0
    var dp_i1_1 = Int.min
    var dp_i2_0 = 0
    var dp_i2_1 = Int.min
    for price in prices {
        dp_i2_0 = max(dp_i2_0, dp_i2_1 + price)
        dp_i2_1 = max(dp_i2_1, dp_i1_0 - price)
        dp_i1_0 = max(dp_i1_0, dp_i1_1 + price)
        dp_i1_1 = max(dp_i1_1, -price)
    }
    return dp_i2_0
    
    
    var dp_i_0 = 0, dp_i_1 = Int.min
    for i in 0..<n {
        let temp = dp_i_0
        dp_i_0 = max(dp_i_0, dp_i_1 + prices[i])
        dp_i_1 = max(dp_i_1, temp - prices[i])
    }
    return dp_i_0
    
    for i in 0..<n {
        if i == 0 {
            dp[i][0] = 0
            dp[i][1] = -prices[i]
            continue
        }
        //第i天未持有 = max(rest, sell)
        //rest = 第i-1天未持有， sell = 第i-1天持有 + 当天卖出价格（prices[i]）
        dp[i][0] = max(dp[i-1][0], dp[i-1][1] + prices[i])
        
        //第i天持有 = max(rest, buy)
        //rest = 第i-1天持有， bug = 第i-1天未持有 + 当天买入价格（prices[i]）
        dp[i][1] = max(dp[i-1][1], dp[i-1][0] - prices[i])
    }
    return dp[n-1][0]
    

}

maxProfit([6,2,8,4,6,3,9])


//300. Longest Increasing Subsequence
func lengthOfLIS(_ nums: [Int]) -> Int {
    var res = 0, dp = Array(repeating: 1, count: nums.count)
    for i in 0..<nums.count {
        for j in 0..<i {
            if nums[i] > nums[j] {
                dp[i] = max(dp[i], dp[j]+1)
            }
        }
        res = max(res, dp[i])
    }
    return res
}

//152. Maximum Product Subarray

func maxProduct(_ nums: [Int]) -> Int {
    
    var array = Int(0)
    
    return 0
}



//64. Minimum Path Sum
func minPathSum(_ grid: [[Int]]) -> Int {
    
    //dp solution
    var grid = grid
    let m = grid.count, n = grid.first!.count
    for i in 0..<m {
        for j in 0..<n {
            if i != 0 && j != 0 {
                grid[i][j] = min(grid[i-1][j], grid[i][j-1]) + grid[i][j]
            } else if i != 0 {
                grid[i][j] = grid[i-1][j] + grid[i][j]
            } else if j != 0 {
                grid[i][j] = grid[i][j-1] + grid[i][j]
            }
        }
    }
    return grid.last?.last ?? 0
    
    // recursion solution with memo
    var aux = Array(repeating: Array(repeating: 0, count: grid[0].count), count: grid.count)
    func helper(_ grid: [[Int]], _ row: Int, _ column: Int) -> Int {
        
        if aux[row][column] == -1 {
            if column == 0 && row == 0 { aux[row][column] = grid[row][column] }
            else if column == 0 { aux[row][column] = helper(grid, row-1, column) + grid[row][column] }
            else if row == 0 { aux[row][column] = helper(grid, row, column-1) + grid[row][column] }
            else { aux[row][column] = min(helper(grid, row-1, column), helper(grid, row, column-1)) + grid[row][column] }
        }
        return aux[row][column]
    }
    return helper(grid, grid.count-1, grid.first!.count-1)
}


do {
    func maxProfit(_ prices: [Int]) -> Int {
        var curMin = Int.max, profit = 0
        for v in prices {
            curMin = min(curMin, v)
            profit = v - curMin
        }
        return profit
    }
}

//70. Climbing Stairs
func climbStairs(_ n: Int) -> Int {
    guard n > 0 else { return 0 }
    var prev = 1, cur = 1
    for _ in 2..<n {
        let sum = prev + cur
        prev = cur
        cur = sum
    }
    return cur
}

//53. Maximum Subarray
func maxSubArray(_ nums: [Int]) -> Int {
    
    var curSum = nums[0]
    var maxSum = nums[0]
    for i in 1..<nums.count {
        curSum = max(nums[i], nums[i]+curSum)
        maxSum = max(maxSum, curSum)
    }

    return maxSum
}
