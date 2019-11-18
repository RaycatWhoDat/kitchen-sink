package tictactoe;

import kotlin.math.*

enum class Player { X, O }

const val PLAYER_X_MARK_VALUE = 1
const val PLAYER_O_MARK_VALUE = -1

class Game(var board: MutableList<Int>) {
    var currentPlayer: Player = Player.X
    var winningPlayer: Player? = null
    
    fun addMark(x: Int, y: Int) {
        val boardIndex = (y * 3) + x
        board[boardIndex] = if (currentPlayer == Player.X) PLAYER_X_MARK_VALUE else PLAYER_O_MARK_VALUE
    }

    fun nextPlayer() {
        currentPlayer = if (currentPlayer == Player.X) Player.O else Player.X
    }

    fun displayBoard() {
        for ((yIndex, row) in board.chunked(3).withIndex()) {
            for ((xIndex, space) in row.withIndex()) {
                val columnSeparator = if (xIndex < 2) " | " else "\n"
                val currentSpace = when (space) {
                    PLAYER_X_MARK_VALUE -> "X"
                    PLAYER_O_MARK_VALUE -> "O"
                    else -> " "
                }
                
                print("$currentSpace$columnSeparator")
            }

            if (yIndex < 2) println("--+---+--")
        }
    }

    fun assignWinner(summation: Int) {
        winningPlayer = when (summation.sign) {
            PLAYER_X_MARK_VALUE -> Player.X
            PLAYER_O_MARK_VALUE -> Player.O
            else -> winningPlayer
        }
    }

    fun checkWinner(): Player? {
        val winningRow = board
            .chunked(3) {
                it.sum()
            }.filter {
                Math.abs(it) == 3
            }.elementAtOrElse(0) { 0 }
        
        assignWinner(winningRow)
        
        val winningColumn = (0..2)
            .map {
                val startIndex = 0 + it
                val endIndex = 8 + it
                board.slice(startIndex..endIndex step 3).sum()
            }.filter {
                Math.abs(it) == 3
            }.elementAtOrElse(0) { 0 }
        
        assignWinner(winningColumn)

        val firstDiagonal = board.slice(0..8 step 4).sum()
        val otherDiagonal = board.slice(6 downTo 2 step 2).sum()

        if (firstDiagonal == 3) assignWinner(firstDiagonal)
        if (otherDiagonal == 3) assignWinner(otherDiagonal)
        
        return winningPlayer;
    }

    fun start() {
        inputLoop@ while (checkWinner() == null && board.contains(0)) {
            displayBoard()
            println("Player $currentPlayer, make your move (X Y):")
            val input = readLine()!!
            if (input.split(" ").size < 2) continue@inputLoop
            
            val (xCoordinate, yCoordinate) = input.split(" ")
            val parsedX = xCoordinate.toInt()
            val parsedY = yCoordinate.toInt()

            if (parsedX >= 0 && parsedX <= 2 && parsedY >= 0 && parsedY <= 2) {
                if (board[parsedY * 3 + parsedX] != 0) continue@inputLoop
                addMark(parsedX, parsedY)
                nextPlayer()
            }
        }

        displayBoard()
        
        when (checkWinner()) {
            Player.X -> "Player X wins!"
            Player.O -> "Player O wins!"
            else -> "No-one won! It's a tie game!"
        }.also(::println)
    }
}

fun newGame(): Game {
    return Game(generateSequence() { 0 }.take(9).toMutableList())
}

fun main() {
    newGame().start()
}

// Local Variables:
// compile-command: "kotlinc -include-runtime -d tictactoe.jar tictactoe.kt && java -jar tictactoe.jar"
// End:
