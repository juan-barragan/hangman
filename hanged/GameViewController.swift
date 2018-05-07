//
//  GameViewController.swift
//  hanged
//
//  Created by Juan Barragan on 05/05/2018.
//  Copyright © 2018 Juan Barragan. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var guessLabel: UILabel!
    var numLetters = 0
    var buttons = [UIButton]()
    var dh = DicoHandler.getInstance()
    @IBOutlet weak var presence: UISwitch!
    var lettersPositions = Set<Int>()
    var words = [String]()
    var currentGuess: Character = "?"
    var alreadyChosen = Set<Character>()
    override func viewDidLoad() {
        super.viewDidLoad()
        words = dh.start(withNumber: numLetters)
        currentGuess = dh.getMostCommunLetter(inTheseWords: words, alreadySeen: Set<Character>())
        alreadyChosen.insert(currentGuess)
        guessLabel.text = String(currentGuess)
        buildLetterButtons(numberOf: numLetters, width: 25, height: 25, offset: 5)
    }
    
    @IBAction func okButton(_ sender: Any) {
        if presence.isOn {
            // Check letter positions and filter
            words = dh.filter(forWords: words, withChar: currentGuess, inPosition: Array(lettersPositions))
            for button in buttons {
                if lettersPositions.contains(button.tag) {
                    button.setTitle(String(currentGuess), for: UIControlState.normal)
                }            }
            currentGuess = dh.getMostCommunLetter(inTheseWords: words, alreadySeen: alreadyChosen)
            print(currentGuess)
            alreadyChosen.insert(currentGuess)
            guessLabel.text = String(currentGuess)
        }
    }
    
    func buildLetterButtons(numberOf: Int, width: Int, height: Int, offset: Int) {
        let totalWidth = numberOf*width + (numberOf-1)*offset
        var xPosition = (Int(view.bounds.size.width) - totalWidth)/2
        for i in 1...numberOf {
            let button = UIButton(frame: CGRect(x: xPosition, y: 100, width: width, height: height))
            button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            button.setTitle(String(i), for: UIControlState.normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            self.view.addSubview(button)
            button.tag = i
            buttons.append(button)
            xPosition += width + offset
        }
    }
    @objc func buttonAction(sender: UIButton!) {
        if presence.isOn {
            // Take into account the letters and positions
            if sender.backgroundColor == #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) {
                sender.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                lettersPositions.insert(sender.tag-1)
            }  else {
               sender.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                lettersPositions.remove(sender.tag-1)
            }
            
            print (lettersPositions)
        }
    }
}
