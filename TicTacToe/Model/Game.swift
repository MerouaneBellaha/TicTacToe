//
//  Game.swift
//  TicTacToe
//
//  Created by Merouane Bellaha on 09/05/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation


class Game {

    // MARK: - Properties

    let players = [Player(.one), Player(.two)]
    var activePlayer: Player {
        tour % 2 == 0 ? players[0] : players[1]
    }
    var winner: Player?

    var board: [[String]] =  [
        ["", "", ""],
        ["", "", ""],
        ["", "", ""],
        ]{
        didSet {
            updateBoardHandler?(board)
        }
    }
    var tour = 0

    // MARK: - Variable Réactive 

    var errorHandler: ((String, Bool) -> Void)?
    var updateBoardHandler: (([[String]]) -> Void)?

    // MARK: - Methods

    func play(at cell: Int) {
        guard board[cell/3][cell%3].isEmpty else {
            errorHandler?("Impossible de jouer ici. Recommencez !", false)
            return }
        board[cell/3][cell%3] = activePlayer.mark
        gameHaveAWinner()
        guard winner == nil else {
            errorHandler?("Winner is Player \(winner?.order.rawValue ?? "Error")", true)
            return }
        guard tour < 8 else {
            errorHandler?("Tie !", true)
            return
        }
        tour += 1
    }

    private func gameHaveAWinner() {
           for index in 0..<3 {
               if board[index][0] == activePlayer.mark && board[index][1] == activePlayer.mark && board[index][2] == activePlayer.mark {
                   winner = activePlayer
                   return
               }
               if board[0][index] == activePlayer.mark && board[1][index] == activePlayer.mark && board[2][index] == activePlayer.mark {
                   winner = activePlayer
                   return
               }
               if index == 0 && board[index][index] == activePlayer.mark && board[index+1][index+1] == activePlayer.mark && board[index+2][index+2] == activePlayer.mark {
                   winner = activePlayer
                   return
               }
               if index == 2 && board[index][index-2] == activePlayer.mark && board[index-1][index-1] == activePlayer.mark && board[index-2][index] == activePlayer.mark {
                   winner = activePlayer
                   return
               }
           }
       }

    func restart() {
        for row in board.enumerated() {
            for cell in row.element.enumerated() {
                board[row.offset][cell.offset] = ""
            }
        }
        tour = 0
        winner = nil
    }
}
