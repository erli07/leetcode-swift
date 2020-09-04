import UIKit

var str = "Hello, playground"

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public var random: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
        self.random = nil
    }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}


//725. Split Linked List in Parts
func splitListToParts(_ root: ListNode?, _ k: Int) -> [ListNode?] {
    var len = 0, node = root, res = Array<ListNode?>(repeating: nil, count: k)
    while node != nil {
        len += 1
        node = node?.next
    }
    node = root
    
    var q = len / k, r = q % k, prev = node, i = 0
    while i < k && node != nil {
        res[i] = node
        for _ in 0..<(q + r > 0 ? 1 : 0) {
            prev = node
            node = node?.next
        }
        i += 1
        r -= 1
        prev?.next = nil
    }
    
    return res
}

//86. Partition List
func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
    
    let dummy1 = ListNode(0), dummy2 = ListNode(0)
    var h1 = dummy1, h2 = dummy2, head = head
    
    while head != nil {
        if head!.val < x {
            h1.next = head
            h1 = h1.next!
        } else {
            h2.next = head
            h2 = h2.next!
        }
        head = head?.next
    }
        
    h2.next = nil
    h1.next = dummy2.next
    
    return dummy1.next
}

//445. Add Two Numbers II
func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
 
    var len1 = 0, len2 = 0, list1 = l1, list2 = l2
    while list1 != nil {
        len1 += 1
        list1 = list1?.next
    }
    
    while list2 != nil {
        len2 += 1
        list2 = list2?.next
    }
    
    var l = len1 > len2 ? l1 : l2, s = len1 > len2 ? l2 : l1,
    long = max(len1, len2), short = min(len1, len2), stack = [Int]()
    while long > 0 {
        if long <= short {
            stack.append(l!.val + s!.val)
            s = s?.next
        } else {
            stack.append(l!.val)
        }
        l = l?.next
        long -= 1
    }
    
    let dummy = ListNode(0)
    var carry = 0
    while !stack.isEmpty {
        let val = stack.removeLast() + carry
        carry = val / 10
        dummy.next = ListNode(val % 10, dummy.next)
    }
    
    if carry > 0 { dummy.next = ListNode(carry, dummy.next) }
    return dummy.next
    
}

//143. Reorder List
func reorderList(_ head: ListNode?) {
 
    var slow = head, fast = head
    while fast?.next != nil && fast?.next?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
    }
    
    let mid = slow, cur = slow?.next
    while cur?.next != nil {
        let next = cur?.next
        cur?.next = next?.next
        next?.next = mid?.next
        mid?.next = next
    }
    
    var h1 = head, h2 = mid?.next
    while h2 != nil  {
        let next = h1?.next
        h1?.next = h2
        h2 = h2?.next
        mid?.next = h2
        h1?.next?.next = next
        h1 = next
    }
    
}

do {
    func mergeSort(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        let dummy = ListNode(0)
        var prev = dummy, l1 = l1, l2 = l2
        while l1 != nil && l2 != nil {
            if l1!.val < l2!.val {
                prev.next = l1
                l1 = l1?.next
            } else {
                prev.next = l2
                l2 = l2?.next
            }
            prev = prev.next!
        }
        
        if l1 != nil { prev.next = l1 }
        if l2 != nil { prev.next = l2 }
        
        return dummy.next
    }
    
    func sortList(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil { return head }
        var fast = head, slow = head, mid = head
        while fast != nil && fast?.next != nil {
            fast = fast?.next?.next
            mid = slow
            slow = slow?.next
        }
        
        mid?.next = nil
        let l1 = sortList(head)
        let l2 = sortList(slow)
        
        return mergeSort(l1, l2)
    }

}

do {
    func insertionSortList(_ head: ListNode?) -> ListNode? {
        let dummy = ListNode(0)
        var cur = head
        var pre = dummy, next = head
        while cur != nil {
            next = cur?.next
            while pre.next != nil && pre.next!.val < cur!.val {
                pre = pre.next!
            }
            cur?.next = pre.next
            pre.next = cur
            pre = dummy
            cur = next
        }
        return dummy.next
    }
}

do {
    func nextLargerNodes(_ head: ListNode?) -> [Int] {
        var vals = [Int]()
        var head = head
        while head != nil {
            vals.append(head!.val)
            head = head?.next
        }
        
        let size = vals.count
        var res = Array(repeating: 0, count: size)
        var s = [Int]()
        
        for i in 1...size {
            let val = vals[size-i]
            while !s.isEmpty && s.last! <= val {
                s.removeLast()
            }
            res[size-i] = s.last ?? 0
            s.append(val)
        }
        
        return res
        
    }
    
    func getDecimalValue(_ head: ListNode?) -> Int {
        
        var sum = 0
        var head = head
        while head != nil {
            sum <<= 1
            sum += head!.val
            head = head?.next
        }
        return sum
    }
    
    let sio = getDecimalValue(ListNode(1, ListNode(1, ListNode(0))))
}

do {
    var successor: ListNode?
    func reverseN(_ head: ListNode?, _ n: Int) -> ListNode? {
        if n == 1 {
            successor = head
            return head
        }
//        if head?.next == nil { return head }
        let last = reverseN(head?.next, n-1)
        head?.next?.next = head
        head?.next = successor
        
        return last
    }
    
    func reverseBetween(_ head: ListNode?, _ m: Int, _ n: Int) -> ListNode? {
        
        var cur = head
        var temp: ListNode?
        for _ in 1..<m {
            temp = cur
            cur = cur?.next
        }
        
        var tail: ListNode? = nil
        var pre: ListNode? = nil
        for _ in m..<n {
            
            if tail == nil { tail = cur }
            let next = cur?.next
            cur?.next = pre
            pre = cur
            cur = next
        }
        tail?.next = cur
        
        if m == 1 { return pre }
        temp?.next = pre
        return head
    }
    
    func buildBST(_ head: ListNode?, _ tail: ListNode?)  {
        if head === tail { return }
        
        var fast = head, slow = head
        while fast !== tail && fast?.next !== tail {
            fast = fast?.next?.next
            slow = slow?.next
        }
    }
    
    func sortedListToBST(_ head: ListNode?) {
        
        var fast = head, slow = head
        while fast != nil {
            fast = fast?.next?.next
            slow = slow?.next
        }
        
        var root = slow
        slow = head
        
    }
    
    
    func swapPairs(_ head: ListNode?) -> ListNode? {
        if head != nil && head?.next != nil { return head }
        let next = head?.next
        head?.next = swapPairs(next?.next)
        next?.next = head
        return next
    }
    
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        
        let dummy = ListNode(0)
        dummy.next = head
        var pre = dummy
        var cur = head
        
        while cur != nil && cur?.next != nil {
            while cur?.val == cur?.next?.val {
                cur = cur?.next
            }
            if pre.next === cur { //cur not duplicate
                pre = pre.next!
            } else {
                pre.next = cur?.next
            }
            cur = cur?.next
        }
        
        return dummy.next
    }
    
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        
        var count = 0
        var tail = head
        while tail != nil {
            count += 1
            tail = tail?.next
        }
        tail?.next = head
        
        var head = head
        var offset = count - (k % count)
        while offset > 1 {
            offset -= 1
            head = head?.next
        }
        defer {
            head?.next = nil
        }
        return head?.next
    }
    
    func copyRandomList(_ head: ListNode?) -> ListNode? {
        
        //copy
        var h1 = head
        while h1 != nil {
            let temp = ListNode(h1!.val)
            temp.next = h1?.next
            h1?.next = temp
            h1 = h1?.next?.next
        }
        
        //random
        var h2 = head
        while h2 != nil {
            let temp = h2?.next
            let next = temp?.next
            temp?.random = h2?.random?.next
            h2 = next
        }
        
        //next
        let dummy = ListNode(0)
        var h3 = head, new_head = dummy
        while h3 != nil {
            let temp = h3?.next
            let next = temp?.next
            
            new_head.next = temp
            
            h3?.next = next
            h3 = next
            new_head = temp!
        }

        return dummy.next
    }
    
    var carry = 0
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {

        if l1 == nil && l2 == nil {
            return carry > 0 ? ListNode(carry) : nil
        }
        let sum = (l1?.val ?? 0) + (l2?.val ?? 0) + carry
        carry = sum / 10
        let node = ListNode(sum % 10, addTwoNumbers(l1?.next, l2?.next))
        return node
        
    }
    
    
    func oddEvenList(_ head: ListNode?) -> ListNode? {
        
        var odd = head, even = head?.next
        let evenhead = even
        
        while even != nil && even?.next != nil {
            odd?.next = even?.next
            odd = odd?.next
            even?.next = odd?.next
            even = even?.next
        }
        odd?.next = evenhead
        
        return odd
    }
    
    func isPalindrome(_ head: ListNode?) -> Bool {
        var vals = [Int]()
        var head = head
        while head != nil {
            vals.append(head!.val)
            head = head?.next
        }
        
        var left = 0, right = vals.count-1
        while left < right {
            if vals[left] != vals[right] { return false }
            left += 1
            right -= 1
        }
        
        return true
    }
    
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        var cur = head
        while cur != nil {
            if cur?.next?.val == val {
                cur?.next = cur?.next?.next
            }
            cur = cur?.next
        }
        return head?.val == val ? head?.next : head
    }
    
    func reverseList(_ head: ListNode?) -> ListNode? {
//        if head?.next == nil { return head }
//        let last = reverseList(head?.next)
//        head?.next?.next = head
//        head?.next = nil
        
        var pre: ListNode? = nil
        var cur = head
        while cur != nil {
            let next = cur?.next
            cur?.next = pre
            pre = cur
            cur = next
        }
        
        return pre
    }
    
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        var pa = headA, pb = headB
        while pa !== pb {
            pa = (pa ?? pb)?.next
            pb = (pb ?? pa)?.next
        }
        return pa
    }
    
    func detectCycle(_ head: ListNode?) -> ListNode? {
        var slow = head
        var fast = head
        while fast != nil && fast?.next != nil {
            if fast === slow {
                var slow2 = head
                while slow2 !== fast {
                    slow2 = slow2?.next
                    fast = fast?.next
                }
                return fast
            }
            fast = fast?.next?.next
            slow = slow?.next
        }
        return nil
    }
    
    func hasCycle(_ head: ListNode?) -> Bool {
        var slow = head
        var quick = head?.next
        while slow != nil && quick != nil {
            if quick?.next?.val == slow?.val { return true }
            quick = quick?.next
            slow = slow?.next
        }
        return false
    }
}




class MyLinkedList {

    class Node {
        var val: Int
        var next: Node?
        init(_ val: Int) { self.val = val; self.next = nil; }
        init(_ val: Int, _ node: Node?) { self.val = val; self.next = node; }
    }
    
    var head: Node?
    var tail: Node?
    var size = 0
    
    /** Initialize your data structure here. */
    init() {
        
    }
    
    /** Get the value of the index-th node in the linked list. If the index is invalid, return -1. */
    func get(_ index: Int) -> Int {
        if let node = getNodeAtIndex(index) {
            return node.val
        }
        return -1
    }
    
    /** Add a node of value val before the first element of the linked list. After the insertion, the new node will be the first node of the linked list. */
    func addAtHead(_ val: Int) {
        let node = Node(val, head)
        head = node
        if tail == nil {
            tail = node
        }
        size += 1
    }
    
    /** Append a node of value val to the last element of the linked list. */
    func addAtTail(_ val: Int) {
        if var tail = tail {
            let node = Node(val)
            tail.next = node
            tail = node
            size += 1
        } else {
            addAtHead(val)
        }
    }
    
    /** Add a node of value val before the index-th node in the linked list. If index equals to the length of linked list, the node will be appended to the end of linked list. If index is greater than the length, the node will not be inserted. */
    func addAtIndex(_ index: Int, _ val: Int) {
        if index == 0 {
            addAtHead(val)
        } else if index == size {
            addAtTail(val)
        } else {
            if let node = getNodeAtIndex(index-1) {
                node.next = Node(val, node.next)
                size += 1
            }
        }
    }
    
    /** Delete the index-th node in the linked list, if the index is valid. */
    func deleteAtIndex(_ index: Int) {
        guard size > index else { return }
        if index == 0 { //delete head
            head = head?.next
            if size == 1 { tail = nil }
        } else if let node = getNodeAtIndex(index-1) {
            node.next = node.next?.next
            if index == size-1 { tail = node }
        }
        size -= 1
    }
    
    func getNodeAtIndex(_ index: Int) -> Node? {
        var node = head
        var idx = index
        while node != nil && idx >= 0 {
            if idx == 0 { return node }
            node = node?.next
            idx -= 1
        }
        return nil
    }
}

/**
 * Your MyLinkedList object will be instantiated and called as such:
 * let obj = MyLinkedList()
 * let ret_1: Int = obj.get(index)
 * obj.addAtHead(val)
 * obj.addAtTail(val)
 * obj.addAtIndex(index, val)
 * obj.deleteAtIndex(index)
 */
