//
//  ButtonGridView.swift
//  tic tac toe
//
//  Created by Ярослав Вербило on 2023-03-04.
//



import UIKit

class StackViewController: UIViewController {
    
    
    enum Turn {
            case Nought
            case Cross
        }
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    var turnLabel = UILabel()
    var playerLabel = UILabel()
    var NOUGHT : String = ""
    var CROSS  : String = ""
    var noughtScore = 0
    var crossScore = 0
    
    let boardSize = 3
    var board = [[String?]]()
    var currentPlayer = "x"
    var gameEnded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
               view.backgroundColor = .cyan
        
        
        CROSS += " (X)"
        NOUGHT += " (O)"
        
        
        print(NOUGHT)
        print(CROSS)
        
        
        view.addSubview(turnLabel)
                view.addSubview(playerLabel)
        
                turnLabel.text = "Turn"
                turnLabel.numberOfLines = 0
                turnLabel.font = UIFont(name: "Arial", size: 30)
        
        
                playerLabel.text = CROSS
                playerLabel.font = UIFont.systemFont(ofSize: 40)
        
                turnLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    turnLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    turnLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 48)
                ])
        
                playerLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    playerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    playerLabel.topAnchor.constraint(equalTo: turnLabel.bottomAnchor, constant: 0)
                ])
        
        
        
        
        

    }
    
    func setupGame() {
        board = Array(repeating: Array(repeating: nil, count: boardSize), count: boardSize)
        gameEnded = false
        
        currentPlayer = "X"
        drawBoard()
    }
    
    func drawBoard() {
        // Remove existing buttons
        for view in view.subviews {
            if let button = view as? UIButton {
                button.removeFromSuperview()
            }
        }
        
        // Add new buttons
        let buttonSize: CGFloat = 80
        let spacing: CGFloat = 10
        let xOffset = (view.frame.width - (buttonSize * CGFloat(boardSize) + spacing * CGFloat(boardSize - 1))) / 2
        let yOffset = (view.frame.height - (buttonSize * CGFloat(boardSize) + spacing * CGFloat(boardSize - 1))) / 2
        
        for i in 0..<boardSize {
            for j in 0..<boardSize {
                let button = UIButton(type: .system)
                button.frame = CGRect(x: xOffset + CGFloat(j) * (buttonSize + spacing),
                                      y: yOffset + CGFloat(i) * (buttonSize + spacing),
                                      width: buttonSize,
                                      height: buttonSize)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 50)
                button.setTitleColor(.black, for: .normal)
                button.layer.borderWidth = 1
                button.tag = i * boardSize + j
                button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                
                if let title = board[i][j] {
                    button.setTitle(title, for: .normal)
                    button.isEnabled = false
                }
                
                view.addSubview(button)
            }
        }
        
        // Add reset button
        let resetButton = UIButton(type: .system)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        resetButton.layer.borderColor = UIColor.black.cgColor
        resetButton.layer.borderWidth = 2
        resetButton.layer.backgroundColor = UIColor.cyan.cgColor
        resetButton.layer.cornerRadius = 15
        resetButton.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
        view.addSubview(resetButton)
        
        
        
        
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            resetButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            //resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            resetButton.heightAnchor.constraint(equalToConstant: 40),
            resetButton.widthAnchor.constraint(equalToConstant: 80)
            
        ])
    }
    
    @objc func buttonTapped(sender: UIButton) {
        
        addToBoard(sender)
        
        guard !gameEnded else {
            return
        }
        
        let row = sender.tag / boardSize
        let col = sender.tag % boardSize
        
        guard board[row][col] == nil else {
            return
        }
        
        board[row][col] = currentPlayer
        sender.setTitle(currentPlayer, for: .normal)
        sender.isEnabled = false
        
        let winner = checkForWinner()
        var winnerTitle = ""
        if winner != nil {
            
            
            if winner == "X"{
                crossScore += 1
                winnerTitle = CROSS
            }else {
                noughtScore += 1
                winnerTitle = NOUGHT
            }
            
            
            
            
            
            let title = "\(winnerTitle) wins!"
            let message = "\n\(CROSS): " + String(crossScore) + "\n\n\(NOUGHT): " + String(noughtScore)
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            gameEnded = true
            resetGame(sender)
            playerLabel.text = CROSS
            currentTurn = Turn.Cross
        } else {
            // Check for a tie
            var isTie = true
            
            for i in 0..<boardSize {
                for j in 0..<boardSize {
                    if board[i][j] == nil {
                        isTie = false
                    }
                }
            }
            if isTie {
                
                
                
                
                
                
                
                
                let message = "\n\(CROSS): " + String(crossScore) + "\n\n\(NOUGHT): " + String(noughtScore)
                let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                gameEnded = true
                resetGame(sender)
                
                playerLabel.text = "X"
                currentTurn = Turn.Cross
                
            } else {
                // Switch players
                currentPlayer = currentPlayer == "X" ? "O" : "X"
            }
        }
        
    }
    
    func checkForWinner() -> String? {
        // Check rows and columns
        for i in 0..<boardSize {
            var rowMatches = true
            var colMatches = true
            
            for j in 0..<boardSize {
                if board[i][j] != currentPlayer {
                    rowMatches = false
                }
                if board[j][i] != currentPlayer {
                    colMatches = false
                }
            }
            
            if rowMatches || colMatches {
                return currentPlayer
            }
        }
        
        // Check diagonals
        var diagonalMatches1 = true
        var diagonalMatches2 = true
        
        for i in 0..<boardSize {
            if board[i][i] != currentPlayer {
                diagonalMatches1 = false
            }
            if board[boardSize - i - 1][i] != currentPlayer {
                diagonalMatches2 = false
            }
        }
        
        if diagonalMatches1 || diagonalMatches2 {
            return currentPlayer
        }
        
        return nil
    }

    
    @objc func resetGame(_ sender: UIButton) {
        
        
        
        // Reset the board
        board = Array(repeating: Array(repeating: nil, count: boardSize), count: boardSize)
        
        // Re-enable all buttons and clear their titles
        sender.setTitle("", for: .normal)
                    sender.isEnabled = true
        
        // Reset the game state
        gameEnded = false
        currentPlayer = "X"
        drawBoard()
    }



    @objc func addToBoard(_ sender: UIButton) {
            if(sender.title(for: .normal) == nil)
            {
                if(currentTurn == Turn.Nought)
                {
                    sender.setTitle(NOUGHT, for: .normal)
                    currentTurn = Turn.Cross
                    playerLabel.text = CROSS
                }else if(currentTurn == Turn.Cross) {
                    sender.setTitle(CROSS , for: .normal)
                    currentTurn = Turn.Nought
                    playerLabel.text = NOUGHT
                }
                sender.isEnabled = false
    
            }
        }
    
    
   
    
    
}
