import UIKit


func reverseString(_ s: inout [Character]) {
    let len = s.count
    for i in 0..<len/2 {
        s.swapAt(i, len-1-i)
    }
}
