import UIKit

//131. Palindrome Partitioning
func partition(_ s: String) -> [[String]] {
    
    func isPalindrome(_ s: [Character], _ left: Int, _ right: Int) -> Bool {
        var left = left, right = right
        while left < right {
            if s[left] != s[right] { return false }
            left += 1
            right -= 1
        }
        return true
    }
    
    func backtrack(_ res: inout [[String]], _ tracks: inout [String], _ s: [Character], _ start: Int) {
        if start == s.count {
            res.append(tracks)
            return
        }
        
        for i in start..<s.count {
            if isPalindrome(s, start, i) {
                tracks.append(String(s[start...i]))
                backtrack(&res, &tracks, s, i+1)
                tracks.removeLast()
            }
        }
    }
    
    var res = [[String]](), tracks = [String]()
    backtrack(&res, &tracks, Array(s), 0)
    
    return res
}


//79. Word Search
func exist(_ board: [[Character]], _ word: String) -> Bool {
 
    func backtrack(_ board: inout [[Character]], _ m: Int, _ n: Int, _ idx: Int) -> Bool {
        
        if idx == word.count { return true }
        if m < 0 || m >= board.count || n < 0 || n >= board.first!.count { return false }
        if board[m][n] != Array(word)[idx] { return false }
        
        board[m][n] = "*"
        if backtrack(&board, m-1, n, idx+1) || backtrack(&board, m+1, n, idx+1) ||
            backtrack(&board, m, n-1, idx+1) || backtrack(&board, m, n+1, idx+1) {
            return true
        }
        board[m][n] = Array(word)[idx]
        
        return false
    }
    
    var board = board
    for i in 0..<board.count {
        for j in 0..<board.first!.count {
            if backtrack(&board, i, j, 0) {
                return true
            }
        }
    }
    
    return false
}

exist([["a", "b", "c", "e"],["s", "f", "c", "s"],["a", "d", "e", "e"]], "abcb")


//78. Subsets
func subsets(_ nums: [Int]) -> [[Int]] {

    return nums.reduce([[]]) { (result, num) in
        print(result)
        return result + result.map({ $0 + [num] })
    }
    
    var res = [[Int]](), track = [Int]()
    func backtrack(_ track: inout [Int], _ start: Int) {
        if track.count > 0 {
            print(track)
            res.append(track)
        }
        for i in start..<nums.count {
            track.append(nums[i])
            backtrack(&track, i+1)
            track.removeLast()
        }
    }
    backtrack(&track, 0)

    return res
    
}

let res = subsets([1,2,2])
print(res)



//46. Permutations
func permute(_ nums: [Int]) -> [[Int]] {
    
    var res = [[Int]](), track = [Int]()
    func backtrack(_ list: inout [Int]) {
        if list.count == nums.count {
            res.append(list)
            return
        }
        
        for n in nums {
            if list.contains(n) { continue }
            list.append(n)
            backtrack(&list)
            list.removeLast()
        }
    }
    backtrack(&track)
    
    return res
}


//17. Letter Combinations of a Phone Number
func letterCombinations(_ digits: String) -> [String] {
    
    var res = [String]()
    let mapping = ["", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"]
    res.append("")
    for ch in digits {
        let letters = mapping[ch.wholeNumberValue!]
        var temp = [String]()
        while !res.isEmpty {
            let str = res.removeLast()
            for letter in letters {
                temp.append(str+String(letter))
            }
        }
        res = temp
    }
    
    return res
}
