//
//  ViewController.swift
//  TicTacToe
//
//  Created by Merouane Bellaha on 09/05/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game = Game()
    
    @IBOutlet var cells: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.errorHandler = updateError
        game.updateBoardHandler = updateCells
    }
    
    @IBAction func cellTapped(_ sender: UIButton) {
        game.play(at: sender.tag)
    }
    
    func updateCells(with board: [[String]]) {
        var index = 0
        for row in board.enumerated() {
            for cell in row.element.enumerated() {
                cells[index].setTitle(board[row.offset][cell.offset], for: .normal)
                index += 1
            }
        }
    }
    
    func updateError(with message: String, restart: Bool) {
        let alertVc = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            if restart {
                self.game.restart()
            }
        }))
        self.present(alertVc, animated: true)
    }
}

