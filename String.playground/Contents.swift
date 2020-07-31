import UIKit

//28. Implement strStr()
func strStr(_ haystack: String, _ needle: String) -> Int {
    guard needle != "" else { return 0 }
    
    let haystack = Array(haystack), needle = Array(needle)
    for i in 0..<haystack.count-needle.count {
        for j in 0..<needle.count {
            if haystack[i+j] != needle[j] { break }
            if j == needle.count-1 { return i }
        }
    }
    
    return -1
}

//20. Valid Parentheses
func isValid(_ s: String) -> Bool {
    guard s.count%2 == 0 else { return false }
    let map: [Character: Int] = ["(": 1, ")": 2, "{": 3, "}": 4, "[": 5, "]": 6]
    var brackets = [Character]()
    for ch in s {
        let n = map[ch]!
        if n%2 == 1 {
            brackets.append(ch)
        } else {
            if brackets.isEmpty || map[brackets.removeLast()]!+1 != n {
                return false
            }
        }
    }
    return brackets.isEmpty
}


//13. Roman to Integer
func romanToInt(_ s: String) -> Int {

    let mapping = ["I": 1, "V": 5, "X": 10, "L": 50, "C": 100, "D": 500, "M": 1000]
    var prev = 0, res = 0
    for ch in s {
        let n = mapping[String(ch)]!
        prev *= n > prev ? -1 : 1
        res += prev
        prev = n
    }
    
    return res+prev
}



//14. Longest Common Prefix
func longestCommonPrefix(_ strs: [String]) -> String {
    guard strs.count > 1 else { return strs.first ?? "" }
    let s = strs.sorted (by: { return $0.count < $1.count }).first!
    for (i, ch) in s.enumerated() {
        for str in strs {
            if Array(str)[i] != ch {
                return String(Array(s)[..<i])
            }
        }
    }
    
    return s
}

//6. ZigZag Conversion
func convert(_ s: String, _ numRows: Int) -> String {
    guard numRows > 1 else { return s }
    var row = 0, col = 0, res = Array(repeating: "", count: numRows)
    for ch in s {
        res[row] += String(ch)
        if col%(numRows-1) == 0 && row < numRows-1 {
            row += 1
        } else {
            row -= 1
            col += 1
        }
    }
    
    return res.reduce("", +)
}
convert("PAYPALISHIRING", 4)


//22. Generate Parentheses
func generateParenthesis(_ n: Int) -> [String] {
    
    var res = [String]()
    func helper(_ str: String, _ open: Int, _ close: Int) {
        
        if close == n {
            res.append(str)
            return
        }
        
        if open < n {
            helper(str+"(", open+1, close)
        }
        if close < open {
            helper(str+")", open, close+1)
        }
    }
    
    helper("", 0, 0)
    
    return res
}


//17. Letter Combinations of a Phone Number
func letterCombinations(_ digits: String) -> [String] {
    return []
}

//8. String to Integer (atoi)
func myAtoi(_ str: String) -> Int {
 
    var res = 0, sign = 1, hasSign = false
    for ch in Array(str) {
        if ch == " " && res == 0 { continue }
        if (ch == "-" || ch == "+") && res == 0 && !hasSign {
            sign = (ch == "-" ? -1 : 1)
            hasSign = true
            continue
        }
        if ch.isNumber {
            if !hasSign { hasSign = true }
            res = res * 10 + ch.wholeNumberValue!
        }
    }
    return max(min(res*sign, Int(Int32.max)), Int(Int32.min))
}

func reverse(_ x: Int) -> Int {
 
    let sign = x > 0 ? 1 : -1
    let res = Int(String(abs(x).description.reversed()))! * sign
    if res > Int32.max || res < Int32.min {
        return 0
    }
    return res
}

reverse(-12)

//3. Longest Substring Without Repeating Characters
func lengthOfLongestSubstring(_ s: String) -> Int {

    let s = Array(s)
    var set = Set<Character>()
    var lo = 0, hi = 0, res = 0
    while hi < s.count {
    
        let ch = s[hi]
        if set.contains(ch) {
            set.remove(s[lo])
            lo += 1
        } else {
            set.insert(ch)
            hi += 1
            res = max(res, set.count)
        }

    }
    
    return res
}
