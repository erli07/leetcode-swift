import UIKit


func solve(_ board: inout [[Character]]) {
    let row = board.count
    if row < 3 { return }
    let col = board.first!.count
    if col < 3 { return }
    
    func check(_ board: inout [[Character]], _ row: Int, _ col: Int) {
        if row < 0 || col < 0 || row == board.count || col == board.first?.count { return }
        if board[row][col] == "O" {
            board[row][col] = "1"
            check(&board, row+1, col)
            check(&board, row-1, col)
            check(&board, row, col+1)
            check(&board, row, col-1)
        }
    }
    
    for i in 0..<row {
        check(&board, i, 0)
        check(&board, i, col-1)
    }
    for i in 0..<col {
        check(&board, 0, i)
        check(&board, row-1, i)
    }

    for i in 0..<row {
        for j in 0..<col {
            if board[i][j] == "1" {
                board[i][j] = "O"
            } else {
                board[i][j] = "X"
            }
        }
    }
    
}


//127. Word Ladder
func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {

    let wordList = Set(wordList)
    if !wordList.contains(endWord) { return 0 }
    var beginSet = Set([beginWord]), endSet = Set([endWord]), visited = Set([beginWord]), ladder = 1
    
    while !beginSet.isEmpty {
        var set = Set<String>()
        for word in beginSet {
            
            var word = Array(word)
            for i in 0..<word.count {
                let ch = word[i]
                for j in 0..<26 {
                    word[i] = Character(UnicodeScalar(97 + j)!)
                    let target = String(word)
                    if endSet.contains(target) { return ladder+1 }
                    if !visited.contains(target) && wordList.contains(target) {
                        set.insert(target)
                        visited.insert(target)
                    }
                }
                word[i] = ch
            }
        }
        
        beginSet = set.count < endSet.count ? set : endSet
        endSet = set.count < endSet.count ? endSet : set
        ladder += 1
    }
    
    return 0
}
