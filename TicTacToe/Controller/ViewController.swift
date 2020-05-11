//
//  ViewController.swift
//  TicTacToe
//
//  Created by Merouane Bellaha on 09/05/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    private var game = Game()

    static let errorNotification = Notification.Name("error")
    static let updateBoardNotification = Notification.Name("updateBoard")

    @IBOutlet var cells: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateAlertMessage(notification:)), name: ViewController.errorNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBoard(notification:)), name: ViewController.updateBoardNotification, object: nil)

    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func cellTapped(_ sender: UIButton) {
        game.play(at: sender.tag)
    }

    @objc
    private func updateBoard(notification: Notification) {
        guard let board = notification.userInfo?["board"] as? [[String]] else { return }
        var index = 0
        for row in board.enumerated() {
            for cell in row.element.enumerated() {
                cells[index].setTitle(board[row.offset][cell.offset], for: .normal)
                index += 1
            }
        }
    }

    @objc
    private func updateAlertMessage(notification: Notification) {
        guard let message = notification.userInfo?["message"] as? String,
            let restart = notification.userInfo?["restart"] as? Bool
            else { return }
        let alertVc = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alertVc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                if restart {
                    self.game.restart()
                }
            }))
            present(alertVc, animated: true)
        }

}

// stop observing a specific notification
//NotificationCenter.default.removeObserver(self, name: MainViewController.notificationName, object: nil)

// stop observing all notification
//NotificationCenter.default.removeObserver(self)
