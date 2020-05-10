//
//  PlayerTestCase.swift
//  TicTacToeTests
//
//  Created by Merouane Bellaha on 09/05/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import XCTest
@testable import TicTacToe

class PlayerTestCase: XCTestCase {

    var player: Player!

    override func setUp() {
        super.setUp()
        player = Player(.one)
    }

    func testGivenPlayerInstanceIsCreated_WhenPlayerOrderIsOne_ThenPlayerMarkIsX() {
        XCTAssertEqual(player.mark, "X")
    }
}
