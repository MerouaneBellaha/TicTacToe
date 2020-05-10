//
//  Player.swift
//  TicTacToe
//
//  Created by Merouane Bellaha on 09/05/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

struct Player {

    let order: playerOrder
    var mark: String {
        order == .one ? "X" : "O"
    }

    enum playerOrder {
        case one, two
    }

    init(_ order: playerOrder) {
        self.order = order
    }
}
