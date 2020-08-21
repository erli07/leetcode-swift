import UIKit


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
