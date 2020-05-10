//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by Merouane Bellaha on 09/05/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import XCTest
@testable import TicTacToe

class TicTacToeTests: XCTestCase {

    private var game: Game!

    override func setUp() {
        super.setUp()
        game = Game()
    }

    func addMarkFor(p1: [Int] = [], p2: [Int] = []) {
        for index in 0..<p1.count {
            game.play(at: p1[index])
            if index < p2.count {
                game.play(at: p2[index])
            }
        }
    }

    var isEmpty: Bool {
        for row in game.board.enumerated() {
            for cell in row.element.enumerated() {
                guard game.board[row.offset][cell.offset] == "" else { return false }
            }
        }
        return true
    }

    func testGivenNewInstanceOfGameIsCreated_When_ThenGameShouldHaveTwoPlayers() {
        XCTAssertEqual(game.players.count, 2)
    }

    func testGivenNewInstanceOfGameIsCreated_WhenTourIsPair_ThenActivePlayerIsPlayerOne() {
        game.tour = 0
        XCTAssertEqual(game.activePlayer.order, .one)
    }

    func testGivenActivePlayerIsPlayerOne_WhenPlayAt5_ThenBoardContainsACrossAtIndexX1Y2() {
        game.play(at: 5)

        XCTAssertEqual(game.board[1][2], "X")
    }

    func testGivenGameTourIs0_WhenAddingAMark_ThenGameTourIs1() {

        addMarkFor(p1: [2])

        XCTAssertEqual(game.tour, 1)
    }

    func testGivenGameTourIs8_WhenAddindAMark_ThenGameTourIs0AndBoardIsEmpty() {
        addMarkFor(p1: [0, 1, 2, 3], p2: [4, 5, 6, 7])

        addMarkFor(p1: [8])

        XCTAssertEqual(game.tour, 0)
        XCTAssertTrue(isEmpty)

    }

    func testGivenPlayer1PlayAt5AndPlayer2PlayAt6_WhenPlayerOnePlayAt4_ThenIndexX1Y1IsACrossAndIndexX1Y2IsACircle() {
        addMarkFor(p1: [5], p2: [6])

        addMarkFor(p1: [4])

        XCTAssertEqual(game.board[1][1], "X")
        XCTAssertEqual(game.board[2][0], "O")
    }

    func testGivenIndexX0Y2IsACross_WhenPlayer2PlayAtIndexX0Y2_ThenIndexX0Y2IsStillACrossAndActivePlayerIsStillPlayer2() {
        addMarkFor(p1: [2])

        addMarkFor(p2: [2])

        XCTAssertEqual(game.activePlayer.order, .two)
        XCTAssertEqual(game.board[0][2], "X")
    }

    func testGivenPlayerOneHaveCell0And1_WhenPlayerOneTakeCell2_ThenWinnerIsPlayerOne() {
        addMarkFor(p1: [0, 1], p2: [4, 5])

        addMarkFor(p1: [2])

        XCTAssertEqual(game.winner?.order, .one)
    }

    func testGivenPlayerOneHaveCell0And3_WhenPlayerOneTakeCell6_ThenWinnerIsPlayerOne() {
        addMarkFor(p1: [0, 3], p2: [4, 5])

        addMarkFor(p1: [6])

        XCTAssertEqual(game.winner?.order, .one)
    }

    func testGivenPlayerOneHaveCell0And4_WhenPlayerOneTakeCell8_ThenWinnerIsPlayerOne() {
        addMarkFor(p1: [0, 4], p2: [3, 5])

        addMarkFor(p1: [8])

        XCTAssertEqual(game.winner?.order, .one)
    }

    func testGivenPlayerOneHaveCell2And4_WhenPlayerOneTakeCell6_ThenWinnerIsPlayerOne() {
          addMarkFor(p1: [2, 4], p2: [3, 5])

          addMarkFor(p1: [6])

          XCTAssertEqual(game.winner?.order, .one)
      }

}
