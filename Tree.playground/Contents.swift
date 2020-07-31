import UIKit

class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public var next: TreeNode?
    public var children: [TreeNode] = []
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

do {
    func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
        guard let root = root else { return false }
        var map = [Int: Int]()
        var queue = [root]
        while !queue.isEmpty {
            var next = [TreeNode]()
            for node in queue {
                if let _ = map[k-node.val] {
                    return true
                }
                map[node.val] = 1
                if let left = node.left {
                    next.append(left)
                }
                if let right = node.right {
                    next.append(right)
                }
            }
            queue = next
        }
        
        return false
    }
}

do {
    func addOneRow(_ root: TreeNode?, _ v: Int, _ d: Int) -> TreeNode? {
        
        func helper(_ root: TreeNode?, depth: Int) {
            guard let root = root else { return }
            if depth == d {
                root.left = TreeNode(v, root.left, nil)
                root.right = TreeNode(v, nil, root.right)
                return
            }
            helper(root.left, depth: depth+1)
            helper(root.right, depth: depth+1)
        }
        helper(root, depth: 1)
        return root
    }
    
    //"1(2()(4))(3)"
    func tree2str(_ t: TreeNode?) -> String {
        guard let t = t else { return "()" }
        if t.left == nil && t.right == nil { return "\(t.val)" }
        if t.left == nil { return "\(t.val)()(\(tree2str(t.right)))" }
        if t.right == nil { return "\(t.val)(\(tree2str(t.left)))" }
        return "\(t.val)(\(tree2str(t.left)))(\(tree2str(t.right)))"
    }
    
    func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
        if t1 == nil && t2 == nil { return nil }
        var node: TreeNode
        if t1 == nil { node = TreeNode(t2!.val) }
        else if t2 == nil { node = TreeNode(t1!.val) }
        else { node = TreeNode(t1!.val + t2!.val) }
        node.left = mergeTrees(t1?.left, t2?.left)
        node.right = mergeTrees(t1?.right, t2?.right)
        return node
        
    }
    
    func pruneTree(_ root: TreeNode?) -> TreeNode? {
        
        guard let root = root else { return nil }
        root.left = pruneTree(root.left)
        root.right = pruneTree(root.right)
        if root.left == nil && root.right == nil {
            return nil
        }
        return root
    }
    
    func minDiffInBST(_ root: TreeNode?) -> Int {
     
        var diff = Int.max
        var preVal: Int?
        func inorder(_ root: TreeNode?) {
            guard let root = root else { return }
            inorder(root.left)
            if let preVal = preVal {
                diff = min(diff, root.val-preVal)
            }
            preVal = root.val
            inorder(root.right)
        }
        return diff
    }
    
    func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard let root = root else { return TreeNode(val) }
        if root.val > val {
            root.left = insertIntoBST(root.left, val)
        } else {
            root.right = insertIntoBST(root.right, val)
        }
        return root
        
    }
    
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        
        guard let root = root,
            let p = p,
            let q = q else { return nil }
        
        if p.val > root.val && q.val > root.val {
            return lowestCommonAncestor(root.right, p, q)
        } else if p.val < root.val && q.val < root.val {
            return lowestCommonAncestor(root.left, p, q)
        }
        return root
    }
    
    func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        guard let root = root else { return -1 }
        var res = 0
        var count = k
        
        func helper(_ root: TreeNode?) {
            guard let root = root, count > 0 else { return }
            helper(root.left)
            count -= 1
            if count == 0 {
                res = root.val
            }
            helper(root.right)
        }
        
        helper(root)
        
        return res
    }
    
    func findMode(_ root: TreeNode?) -> [Int] {
        return []
    }
    
    func findFrequentTreeSum(_ root: TreeNode?) -> [Int]{
        var vals = [Int: Int]()
        func helper(_ root: TreeNode?) -> Int {
            guard let root = root else { return 0 }
            let val = root.val + helper(root.left) + helper(root.right)
            vals[val] = vals[val, default: 0] + 1
            return val
        }
        helper(root)
        if let val = vals.values.max() {
            return vals.filter { $0.value == val }.keys.map { Int($0) }
        }
        return []
    }
    
    func getMinimumDifference(_ root: TreeNode?) -> Int {
        var diff = Int.max
        var preNode: TreeNode?
        func inorder(_ root: TreeNode?) {
            
            guard let root = root else { return }
            inorder(root.left)
            if let preNode = preNode {
                diff = min(diff, abs(preNode.val-root.val))
            }
            inorder(root.right)
            
        }
        inorder(root)
        return diff
    }
}


do {
    
    func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard let root = root else { return nil }
        if root.val == val { return root }
        return searchBST(root.val > val ? root.right : root.left, val)
    }
    
    func preorder(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        func helper(_ root: TreeNode?, res: inout [Int]) {
            guard let root = root else { return }
            res.append(root.val)
            for node in root.children {
                helper(node, res: &res)
            }
        }
        helper(root, res: &res)
        return res
    }
    
    func postorder(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        func helper(_ root: TreeNode?, res: inout [Int]) {
            guard let root = root else { return }
            for node in root.children {
                helper(node, res: &res)
            }
            res.append(root.val)
        }
        helper(root, res: &res)
        return res
    }
}


do {
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else { return nil }
        let left = root.left
        root.left = root.right
        root.right = left
        invertTree(root.left)
        invertTree(root.right)
        return root
    }
}

do {
    func rightSideView(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        var res = [Int]()
        var queue = [TreeNode]()
        queue.append(root)
        while !queue.isEmpty {
            let count = queue.count
            var val: Int!
            for _ in 0..<count {
                let node = queue.removeFirst()
                val = node.val
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            res.append(val)
        }
        return res
    }
}

do {
    func helper(_ root: TreeNode?, val: Int, vals: inout [Int]) {
        guard let root = root else { return }
        let n = val * 10 + root.val
        if root.left == nil && root.right == nil {
            vals.append(n)
        } else {
            helper(root.left, val: n, vals: &vals)
            helper(root.right, val: n, vals: &vals)
        }
    }
    
    func helper(_ root: TreeNode?, sum: Int) -> Int {
        guard let root = root else { return sum }
        let curSum = sum * 10 + root.val
        if root.left == nil && root.right == nil {
            return curSum
        }
        return helper(root.left, sum: curSum) + helper(root.right, sum: curSum)
    }

    func sumNumbers(_ root: TreeNode?) -> Int {
        var vals = [Int]()
        helper(root, val: 0, vals: &vals)
        return vals.reduce(0, +)
    }
}


do {
    var pre: TreeNode?
    func flatten(_ root: TreeNode?) {
        guard let root = root else { return }
        flatten(root.left)
        flatten(root.right)
        if let pre = pre {
            root.right = pre
        }
        pre = root
    }
}

do {
    func helper(_ root: TreeNode?, vals: [Int], target: Int, res: inout [[Int]]) {
        guard let root = root else { return  }
        guard target >= 0 else { return }
        if root.left == nil && root.right == nil {
            if root.val == target {
                res.append(vals+[root.val])
            }
            return
        }
        helper(root.left, vals: vals+[root.val], target: target-root.val, res: &res)
        helper(root.right, vals: vals+[root.val], target: target-root.val, res: &res)
    }
    
    func pathSum(_ root: TreeNode?, _ sum: Int) -> [[Int]] {
        var res = [[Int]]()
        helper(root, vals: [], target: sum, res: &res)
        return res
    }
    
}

do {
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }
        var res = [[Int]]()
        var queue = [TreeNode]()
        queue.append(root)
        var zigzag = false
        while !queue.isEmpty {
            var vals = [Int]()
            let size = queue.count
            for _ in 0..<size {
                let node = queue.removeFirst()
                if zigzag {
                    vals.insert(node.val, at: 0)
                } else {
                    vals.append(node.val)
                }
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            res.append(vals)
            zigzag = !zigzag
        }
        return res
    }
}

do {
    
    func isValidBST(_ root: TreeNode?, min: TreeNode?, max: TreeNode?) -> Bool {
        guard let root = root else { return true }
        if min != nil && root.val <= min!.val { return false }
        if max != nil && root.val >= max!.val { return false }
        return isValidBST(root.left, min: min, max: root) && isValidBST(root.right, min: root, max: max)
    }
    
    func isValidBST(_ root: TreeNode?) -> Bool {
        guard let root = root else { return true }
        return isValidBST(root, min: nil, max: nil)
    }
    
    func BST(_ nums: [Int], low: Int, high: Int) -> TreeNode? {
        guard low <= high else { return nil }
        let mid = (low + high) / 2
        let node = TreeNode(nums[mid])
        node.left = BST(nums, low: low, high: mid-1)
        node.right = BST(nums, low: mid+1, high: high)
        return node
    }
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        return BST(nums, low: 0, high: nums.count-1)
    }
}

do {
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil { return true }
        if p?.val != q?.val { return false }
        return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
    }
    
    var p: TreeNode? = TreeNode(1)
    var q: TreeNode? = nil
    print(p?.val == q?.val)
    
    p = TreeNode(1, TreeNode(2), TreeNode(3))
    q = TreeNode(1, TreeNode(2), TreeNode(3))
    print(isSameTree(p, q))
    
}

do {
    func serialize(_ root: TreeNode?) -> String {
        
        var vals = [String]()
        var queue = [TreeNode?]()
        queue.append(root)
        while !queue.isEmpty {
            if let node = queue.removeFirst() {
                vals.append(node.val.description)
                queue.append(node.left)
                queue.append(node.right)
            } else {
                vals.append("nil")
            }
        }
        
        return vals.joined(separator: ",")
    }
    
    func deserialize(_ data: String) -> TreeNode? {
        guard data != "nil" else { return nil }
        var queue = [TreeNode]()
        let vals = data.split(separator: ",").map { String($0) }
        let root = TreeNode(Int(vals[0])!)
        queue.append(root)
        var idx = 1
        while !queue.isEmpty {
            let node = queue.removeFirst()
            if vals[idx] != "nil" {
                node.left = TreeNode(Int(vals[idx])!)
                queue.append(node.left!)
            }
            idx += 1
            if vals[idx] != "nil" {
                node.right = TreeNode(Int(vals[idx])!)
                queue.append(node.right!)
            }
            idx += 1
        }
        
        return root
    }
    
//    let node = TreeNode(1, TreeNode(2), TreeNode(3, TreeNode(4), TreeNode(5)))
    let node: TreeNode? = nil
    print(serialize(node))
    print(serialize(deserialize(serialize(node))))
    let denode = deserialize(serialize(node))
    
    func traverse(_ root: TreeNode?) {
        guard let root = root else {
            return
        }
        traverse(root.left)
        traverse(root.right)
        print(root.val)

    }
    
    traverse(denode)
    
}

do {
    
    func connect(_ root: TreeNode?) -> TreeNode? {
        
        guard let root = root else { return nil}
        
        var cur_level = [TreeNode]()
        cur_level.append(root)
        
        while !cur_level.isEmpty {
            for index in 0..<cur_level.count-1 {
                cur_level[index].next = cur_level[index+1]
            }
            
            var next_level = [TreeNode]()
            for node in cur_level {
                if let left = node.left {
                    next_level.append(left)
                }
                if let right = node.right {
                    next_level.append(right)
                }
            }
            cur_level = next_level
        }
        
        return root
    }
}

do {
    
    //pre:  [3, 9, 20, 15, 7]
    //in: [9, 3, 15, 20, 7]
    //post: [9, 15, 7, 20, 3]
    var preidx = 0
    func buildTree(preorder: [Int], postorder: [Int], postleft: Int, postright: Int) -> TreeNode? {
        
        if postleft > postright { return nil }
        let val = preorder[preidx]
        let node = TreeNode(val)
        preidx += 1
        if postleft == postright { return node }
        let val1 = preorder[preidx]
        if let postidx = postorder.firstIndex(of: val1) {
            node.left = buildTree(preorder: preorder, postorder: postorder, postleft: postleft, postright: postidx)
            node.right = buildTree(preorder: preorder, postorder: postorder, postleft: postidx+1, postright: postright-1)
        }
        
        return node
    }
    func buildTree(preorder: [Int], postorder: [Int]) -> TreeNode? {
        preidx = 0
        return buildTree(preorder: preorder, postorder: postorder, postleft: 0, postright: postorder.count-1)
    }
    
    
    var postend = 0
    func buildTree(inorder: [Int], postorder: [Int], inleft: Int, inright: Int) -> TreeNode? {
        if inleft > inright { return nil }
        
        let val = postorder[postend]
        guard let mid = inorder.firstIndex(of: val) else { return nil }
        postend -= 1
        let node = TreeNode(val)
        node.right = buildTree(inorder: inorder, postorder: postorder, inleft: mid+1, inright: inright)
        node.left = buildTree(inorder: inorder, postorder: postorder, inleft: inleft, inright: mid-1)
        
        return node
    }
    
    func buildTree(inorder: [Int], postorder: [Int]) -> TreeNode? {
        postend = postorder.count-1
        return buildTree(inorder: inorder, postorder: postorder, inleft: 0, inright: inorder.count-1)
    }
    
    //pre:  [3, 9, 20, 15, 7]
    //in: [9, 3, 15, 20, 7]
    var prestart = 0
    func buildTree(preorder: [Int], inorder: [Int], inleft: Int, inright: Int) -> TreeNode? {
        if inleft > inright { return nil }
        
        let val = preorder[prestart]
        let node = TreeNode(val)
        guard let mid = inorder.firstIndex(of: val) else { return nil }
        prestart += 1
        node.left = buildTree(preorder: preorder, inorder: inorder, inleft: inleft, inright: mid-1)
        node.right = buildTree(preorder: preorder, inorder: inorder, inleft: mid+1, inright: inright)
        return node
    }
    
    func buildTree(preorder: [Int], inorder: [Int]) -> TreeNode? {
        prestart = 0
        return buildTree(preorder: preorder, inorder: inorder, inleft: 0, inright: inorder.count-1)
        
    }

    
//    let root = buildTree(inorder: [9, 3, 15, 20, 7], postorder: [9, 15, 7, 20, 3])
//    let root = buildTree(preorder: [3, 9, 20, 15, 7], inorder: [9, 3, 15, 20, 7])
//    let root = buildTree(preorder: [1, 2, 4, 5, 3, 6, 7, 1], postorder: [4, 5, 2, 6, 7, 3, 1]) //4,2,5,1,6,3,7
        let root = buildTree(preorder: [3, 9, 20, 15, 7], postorder: [9, 15, 7, 20, 3])

    
    func traverse(_ root: TreeNode?) {
        guard let root = root else {
            return
        }
        traverse(root.left)

        print(root.val)

        traverse(root.right)

    }
    
    traverse(root)
}

do {

    var answer = 1
    func topdown(_ root: TreeNode?, depth: Int) {
        guard let root = root else { return }
        answer = max(answer, depth)
        topdown(root.left, depth: depth + 1)
        topdown(root.right, depth: depth + 1)
    }
    
    func topdown(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        topdown(root, depth: 1)
        return answer
    }
    
    func downtop(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        return max(downtop(root.left), downtop(root.right)) + 1
    }
    

    
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [[]] }
        var res = [[Int]]()
        var cur_level = [TreeNode]()
        cur_level.append(root)
        while !cur_level.isEmpty {
            var list = [Int]()
            var next_level = [TreeNode]()
            for node in cur_level {
                list.append(node.val)
                if let left = node.left {
                    next_level.append(left)
                }
                if let right = node.right {
                    next_level.append(right)
                }
            }
            res.append(list)
            cur_level = next_level
        }
        return res
    }
    
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        if let root = root {
            res.append(root.val)
            if let left = root.left {
                res.append(contentsOf: preorderTraversal(left))
            }
            if let right = root.right {
                res.append(contentsOf: preorderTraversal(right))
            }
        }
        return res
    }
    
//    let node = TreeNode(1, nil, TreeNode(2, TreeNode(3), TreeNode(4)))
//    print(preorderTraversal(node))
//    print(topdown(node))
//    print(downtop(node))
}

