import UIKit

//387. First Unique Character in a String
func firstUniqChar(_ s: String) -> Int {
    var dict = [Character: Int]()
    s.forEach({ dict[$0, default: 0] += 1 })
    for (i, ch) in s.enumerated() {
        if dict[ch] == 1 { return i }
    }
    return -1
}


//242. Valid Anagram
func isAnagram(_ s: String, _ t: String) -> Bool {
 
    var dict = [Character: Int]()
    s.forEach({ dict[$0, default: 0] += 1 })
    t.forEach({ dict[$0, default: 0] -= 1 })
    for n in dict.values {
        if n != 0 { return false }
    }
    return true
}

//217. Contains Duplicate
func containsDuplicate(_ nums: [Int]) -> Bool {
    var set = Set<Int>()
    for n in nums {
        if !set.insert(n).inserted {
            return true
        }
    }
    return false
}

//204. Count Primes
func countPrimes(_ n: Int) -> Int {
    if n < 2 { return 0 }
    var isPrime = Array(repeating: true, count: n), count = 0
    for i in 2..<n {
        if isPrime[i] {
            count += 1
            var j = 2
            while i * j < n {
                isPrime[i*j] = false
                j += 1
            }
        }
    }
    return count
}


//202. Happy Number
func isHappy(_ n: Int) -> Bool {
    var set = Set<Int>(), n = n
    while set.insert(n).inserted {
        var sum = 0
        while n > 9 {
            sum += (n % 10) * (n % 10)
            n /= 10
        }
        if n == 1 { return true }
    }
    return false
}

//36. Valid Sudoku
func isValidSudoku(_ board: [[Character]]) -> Bool {
    let m = board.count, n = board.first!.count
    for i in 0..<m {
        for j in 0..<n {
            if !isValid(board, i, j) {
                return false
            }
        }
    }
    return true
}

func isValid(_ board: [[Character]], _ row: Int, _ col: Int) -> Bool {
    let val = board[row][col]
    if val.isWholeNumber {
        for i in 0..<row {
            if board[i][col] == val { return false }
        }
        
        for j in 0..<col {
            if board[row][j] == val { return false }
        }
        
        for i in row/3*3...row {
            for j in col/3*3..<col/3*3+3 {
                if i == row && j == col { return true }
                if board[i][j] == val { return false }
            }
        }
        
    }
    return true
}
