//
//  GameViewModel.swift
//  xoYeet
//
//  Created by Eric Chandonnet on 2024-04-18.
//

import Foundation
import Observation

@Observable class GameViewModel {
    var game: Game
    var turn: Turn
    var currentMarks: [PlayerMove] = []
    var winningLine: [SquarePosition] = []
    var gameStatus: GameStatus = .teamPicking
    var playerTop: Player = Player()
    var playerBottom: Player  = Player()

    init() {
        game = Game()
        turn = .x
    }
    
    func startGame() {
        assignRandomTeamsToPlayers()
        gameStatus = .gameOn
    }
    
    func assignRandomTeamsToPlayers() {
        let shuffledTeams = [Team.x, Team.o].shuffled()
        
        playerTop.team = shuffledTeams[0]
        playerBottom.team = shuffledTeams[1]
    }
    
    func play(position: SquarePosition) {
        placeNewMark(position: position)
        
        if detectWin() {
            gameStatus = .gameOver
        }
        else {
            expireOldMark()
            turn.toggle()
        }
        
    }
    
    func placeNewMark(position: SquarePosition) {
        game.board[position] = turn.getMark()
        currentMarks.append(PlayerMove(squarePosition: position, mark: turn.getMark()))
    }

    func expireOldMark() {
        if currentMarks.count > 6 {
            let removedMark = currentMarks.removeFirst()
            game.board[removedMark.squarePosition] = .empty
        }
        if currentMarks.count > 5 {
            game.board[currentMarks[0].squarePosition] = turn.getExpiringMark()
        }

    }
    
    func detectWin() -> Bool {
        guard currentMarks.count > 4 else {
            return false
        }
        // Horizontal (3)
        if (turn.getMark() == game.board[.topLeft] &&
            turn.getMark() == game.board[.topMiddle] &&
            turn.getMark() == game.board[.topRight]) {
            winningLine = [.topLeft, .topMiddle, .topRight]
            }
        else if (turn.getMark() == game.board[.middleLeft] &&
            turn.getMark() == game.board[.middle] &&
            turn.getMark() == game.board[.middleRight]) {
            winningLine = [.middleLeft, .middle, .middleRight]
        }
        else if (turn.getMark() == game.board[.bottomLeft] &&
                 turn.getMark() == game.board[.bottomMiddle] &&
                 turn.getMark() == game.board[.bottomRight]) {
            winningLine = [.bottomLeft, .bottomMiddle, .bottomRight]
        }
        // Vertical (3)
        else if (turn.getMark() == game.board[.topLeft] &&
                 turn.getMark() == game.board[.middleLeft] &&
                 turn.getMark() == game.board[.bottomLeft]) {
            winningLine = [.topLeft, .middleLeft, .bottomLeft]
        }
        else if (turn.getMark() == game.board[.topMiddle] &&
                 turn.getMark() == game.board[.middle] &&
                 turn.getMark() == game.board[.bottomMiddle]) {
            winningLine = [.topMiddle, .middle, .bottomMiddle]
        }
        else if (turn.getMark() == game.board[.topRight] &&
                 turn.getMark() == game.board[.middleRight] &&
                 turn.getMark() == game.board[.bottomRight]) {
            winningLine = [.topRight, .middleRight, .bottomRight]
        }
        // Diagonal (2)
        else if (turn.getMark() == game.board[.topLeft] &&
                 turn.getMark() == game.board[.middle] &&
                 turn.getMark() == game.board[.bottomRight]) {
            winningLine = [.topLeft, .middle, .bottomRight]
        }
        else if (turn.getMark() == game.board[.topRight] &&
                 turn.getMark() == game.board[.middle] &&
                 turn.getMark() == game.board[.bottomLeft]) {
            winningLine = [.topRight, .middle, .bottomLeft]
        }

        if !winningLine.isEmpty {
            return true
        }
        return false
    }

}
