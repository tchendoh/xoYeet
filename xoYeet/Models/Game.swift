//
//  Game.swift
//  xoYeet
//
//  Created by Eric Chandonnet on 2024-04-18.
//

import Foundation

enum SquarePosition: CaseIterable {
    case topLeft
    case topMiddle
    case topRight
    case middleLeft
    case middle
    case middleRight
    case bottomLeft
    case bottomMiddle
    case bottomRight
}

enum GameStatus {
    case teamPicking
    case gameOn
    case gameOver
}

enum Team {
    case x, o
    case ready
    case notPickedYet
}

struct Player {
    var team: Team = .notPickedYet
    var score: Int = 0
}

struct PlayerMove {
    let squarePosition: SquarePosition
    var mark: SquareValue
}

enum Turn {
    case x
    case o
        
    func getMark() -> SquareValue {
        switch self {
        case .x:
            return .x
        case .o:
            return .o
        }
    }
    
    func getExpiringMark() -> SquareValue {
        switch self {
        case .x:
            return .expiringO
        case .o:
            return .expiringX
        }
    }
    
    mutating func toggle() {
        switch self {
        case .x:
            self = .o
        case .o:
            self = .x
        }
    }
}

struct Game {
    
    var board: [SquarePosition:SquareValue] = [:]
    
    init() {
        createBoard()
    }
    
    mutating func createBoard() {
        for position in SquarePosition.allCases {
            board[position] = .empty
        }
    }
}
