//
//  ViewController.swift
//  hanged
//
//  Created by Juan Barragan on 01/05/2018.
//  Copyright © 2018 Juan Barragan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var numLetters = 5
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBAction func stepperChanged(_ sender: UIStepper) {
        numLetters = Int(sender.value)
        label.text = Int(sender.value).description
    }
    
    @IBAction func goToGame(_ sender: UIButton) {
        print ("going to game")
        performSegue(withIdentifier: "gameSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? GameViewController {
            destination.numLetters = numLetters
        }
        print ("Assigning value")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepper.autorepeat = true
    }
}

