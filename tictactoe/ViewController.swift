//
//  ViewController.swift
//  крестики нолики
//
//  Created by Ярослав Вербило on 2023-03-02.
//

import UIKit

class ViewController: UIViewController {
    
   
    
    let buttonSizeTextField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSizeTextField.placeholder = "Enter button size"
        buttonSizeTextField.borderStyle = .roundedRect
        buttonSizeTextField.keyboardType = .numberPad
        

       
        view.addSubview(buttonSizeTextField)
        
        let addButton = UIButton(type: .system)
        addButton.setTitle("Add buttons", for: .normal)
        addButton.addTarget(self, action: #selector(addButtons), for: .touchUpInside)
 

        view.addSubview(addButton)
        
        
        
        // Add constraints to position the text field and button
        buttonSizeTextField.translatesAutoresizingMaskIntoConstraints = false
        buttonSizeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonSizeTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        buttonSizeTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
    }

    let user1Color = UIColor(red: 0.99, green: 0.30, blue: 0.30, alpha: 1.0)
    let user2Color = UIColor(red: 0.35, green: 0.69, blue: 0.84, alpha: 1.0)
    var activeUser = 1
    
        @objc func addButtons() {
            
            view.endEditing(true)
            
            let controller = StackViewController()
            navigationController?.pushViewController(controller, animated: true)
            
            
            
            guard let buttonSizeText = buttonSizeTextField.text,
                  let buttonSize = Int(buttonSizeText) else {
                return
            }
            
            let rows = 3
            let columns = 3

            let outerStackView = UIStackView()
            outerStackView.axis = .vertical
            outerStackView.alignment = .center
            outerStackView.distribution = .fillEqually
            
            

            for _ in 0..<rows {
                let innerStackView = UIStackView()
                innerStackView.axis = .horizontal
                innerStackView.alignment = .center
                innerStackView.distribution = .fillEqually

                for _ in 0..<columns {
                    let button = UIButton(type: .system)
                    button.backgroundColor = .white
                    button.layer.borderColor = UIColor.black.cgColor
                    button.layer.borderWidth = 1
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
                    button.titleLabel?.adjustsFontSizeToFitWidth = true
                    button.addTarget(self, action: #selector(buttonTouched(sender:)), for: [ .touchUpInside])
                    button.widthAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
                    button.heightAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
                    innerStackView.addArrangedSubview(button)
                }

                outerStackView.addArrangedSubview(innerStackView)
            }

            view.addSubview(outerStackView)
            
            
            

            // Add constraints to position the stackView
            outerStackView.translatesAutoresizingMaskIntoConstraints = false
            outerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            outerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    
    
    
    
    @objc func buttonTouched(sender: UIButton) {
        if activeUser == 1 {
            sender.backgroundColor = user1Color
            sender.setTitle("X", for: .normal)
            sender.setTitleColor(.white, for: .normal)
            sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: sender.bounds.width / 2)
            activeUser = 2
        } else {
            sender.backgroundColor = user2Color
            sender.setTitle("O", for: .normal)
            sender.setTitleColor(.white, for: .normal)
            sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: sender.bounds.width / 2)
            activeUser = 1
        }
    }
    
  
}




