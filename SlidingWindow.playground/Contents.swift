import UIKit


//1004. Max Consecutive Ones III
func longestOnes(_ A: [Int], _ K: Int) -> Int {
    var start = 0, end = 0, maxCount = 0, k = K
    while end < A.count {
        if A[end] == 1 || k > 0 {
            if A[end] == 0 { k -= 1 }
            end += 1
        } else {
            maxCount = max(maxCount, end - start)
            k += A[start] == 0 ? 1 : 0
            start += 1
        }
    }
    return max(maxCount, end - start)
}


//567. Permutation in String
func checkInclusion(_ s1: String, _ s2: String) -> Bool {
    var s2 = Array(s2), len1 = s1.count, len2 = s2.count
    var count = Array(repeating: 0, count: 26)
    for ch in s1 {
        count[Int(ch.asciiValue! - Character("a").asciiValue!)] += 1
    }
    
    func isAllZero() -> Bool {
        for n in count {
            if n != 0 { return false }
        }
        return true
    }
    
    for i in 0..<len2 {
        count[Int(s2[i].asciiValue! - Character("a").asciiValue!)] -= 1
        if i >= len1 { count[Int(s2[i-len1].asciiValue! - Character("a").asciiValue!)] += 1 }
        if isAllZero() { return true }
    }
    
    return false
}


//219. Contains Duplicate II
func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
    var set = Set<Int>()
    for i in 0..<nums.count {
        if i > k { set.remove(nums[i-k-1]) }
        if !set.insert(nums[i]).inserted { return true }
    }
    return false
}


//76. Minimum Window Substring
func minWindow(_ s: String, _ t: String) -> String {
    var window = [Character: Int](), s = Array(s)
    var slow = 0, fast = 0, start = 0, len = Int.max, counter = t.count
    t.forEach({ window[$0, default: 0] += 1 })
    
    while fast < s.count {
        if window[s[fast], default: 0] > 0 { counter -= 1 }
        window[s[fast], default: 0] -= 1
        while slow < fast && counter == 0 {
            if fast - slow + 1 < len {
                start = slow
                len = fast - slow + 1
            }
            if window[s[slow]]! == 0 { counter += 1 }
            window[s[slow]]! += 1
            slow += 1
        }
        fast += 1
    }
    
    return len == Int.max ? "" : String(s[start...start+len-1])
}
