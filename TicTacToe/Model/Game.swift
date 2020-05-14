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
//    var formattedWinner: String? {
//        winner?.order == .one ? "Player One" : "Player two"
//    }
    var board: [[String]] =  [
        ["", "", ""],
        ["", "", ""],
        ["", "", ""],
        ]{
        didSet {
            NotificationCenter.default.post(name: .updateBoardNotification, object: nil, userInfo: ["board": board])
        }
    }

    var tour = 0

    // MARK: - Methods

    func play(at cell: Int) {
        guard board[cell/3][cell%3].isEmpty else {
            NotificationCenter.default.post(name: .errorNotification, object: nil, userInfo: ["message": "Impossible de jouer ici, essayer encore !", "restart": false])
            return }
        board[cell/3][cell%3] = activePlayer.mark

        gameHaveAWinner()
        guard winner == nil else {
            NotificationCenter.default.post(name: .errorNotification, object: nil, userInfo: ["message": "Winner is Player \(winner?.order.rawValue ?? "Error") ", "restart": true])
            return }
        guard tour < 8 else {
             NotificationCenter.default.post(name: .errorNotification, object: nil, userInfo: ["message": "Tie", "restart": true])
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
