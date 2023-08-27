//
//  ButtonSizeInputView.swift
//  tic tac toe
//
//  Created by Ярослав Вербило on 2023-03-04.
//

import UIKit

class ButtonSizeViewController: UIViewController {

    let labelPlayer1 = UILabel()
    let labelPlayer2 = UILabel()
    let Player1TextField = UITextField()
    let Player2TextField = UITextField()
    let addButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan
        
        
        labelPlayer1.text = "Enter player 1 name (X)"
        labelPlayer1.font = .systemFont(ofSize: 30)
        labelPlayer1.textColor = .black
        view.addSubview(labelPlayer1)
        
        
        
        
        Player2TextField.borderStyle = .roundedRect
        Player2TextField.placeholder = "Enter player 2 name"
        Player2TextField.keyboardType = .default
        Player2TextField.delegate = self
        Player2TextField.font = .systemFont(ofSize: 30)
        Player2TextField.backgroundColor = .cyan
        Player2TextField.layer.borderWidth = 1
        view.addSubview(Player2TextField)
        
        
        
        
        labelPlayer2.text = "Enter player 2 name (O)"
        labelPlayer2.font = .systemFont(ofSize: 30)
        labelPlayer2.textColor = .black
        view.addSubview(labelPlayer2)
        
        
        
        Player1TextField.borderStyle = .roundedRect
        Player1TextField.placeholder = "Enter player 1 name"
        Player1TextField.keyboardType = .default
        Player1TextField.delegate = self
        Player1TextField.font = .systemFont(ofSize: 30)
        Player1TextField.backgroundColor = .cyan
        Player1TextField.layer.borderWidth = 1
        view.addSubview(Player1TextField)
        
        
        
        

        addButton.setTitle("Start", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 50)
        addButton.tintColor = .black
        addButton.layer.borderColor = UIColor.black.cgColor
        addButton.layer.borderWidth = 2
        addButton.layer.backgroundColor = UIColor.cyan.cgColor
        addButton.layer.cornerRadius = 15
        addButton.addTarget(self, action: #selector(addButtonsTouched(_:)), for: .touchUpInside)
        view.addSubview(addButton)

        // Add constraints to position the textField and addButton
        Player2TextField.translatesAutoresizingMaskIntoConstraints = false
        Player2TextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Player2TextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        
        
        Player1TextField.translatesAutoresizingMaskIntoConstraints = false
        Player1TextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Player1TextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200).isActive = true
        
        
        
        labelPlayer1.translatesAutoresizingMaskIntoConstraints = false
        labelPlayer1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelPlayer1.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -260).isActive = true
        
        
        
        
        labelPlayer2.translatesAutoresizingMaskIntoConstraints = false
        labelPlayer2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelPlayer2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        
        
        
        
        

        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -153),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            addButton.heightAnchor.constraint(equalToConstant: 109),
            
        ])
//        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        addButton.topAnchor.constraint(equalTo: Player2TextField.bottomAnchor, constant: 16).isActive = true
    }

    @objc func addButtonsTouched(_ sender: UIButton) {
        

        
        
        
            let stackViewController = StackViewController()
        
        stackViewController.NOUGHT = String(Player2TextField.text ?? "0")
        stackViewController.CROSS = String(Player1TextField.text ?? "0")
            navigationController?.pushViewController(stackViewController, animated: true)
        
        
        }
    }

    extension ButtonSizeViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }
