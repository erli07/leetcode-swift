import UIKit

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
