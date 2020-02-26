//
//  ViewController.swift
//  UpDown
//
//  Created by soonhyuk on 2020/02/25.
//  Copyright © 2020 soonhyuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- Properties
    //MARK:IBOutlets
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var turnCountLabel: UILabel!
    @IBOutlet var inputField: UITextField!
    
    //MARK:- Variables
    var randomNumber: Int = Int.random(in: 1...100)
    var turnCount: Int = 0
    
    //MARK:- Methods
    @IBAction func touchUpSubmitButton(_ sender: UIButton){
        print("touch up submit button")
        
        if let submitString: String = self.inputField.text
        {
            let submitNumber: Int = Int(submitString) ?? -1
            if submitNumber == self.randomNumber{
                self.resultLabel.text = "congratulation"
            }
            else
            {
                self.turnCount += 1
                self.turnCountLabel.text = String(self.turnCount)
                if submitNumber > self.randomNumber{
                    self.resultLabel.text = "down"
                }
                else{
                    self.resultLabel.text = "up"
                }
            }
        }else{
         self.resultLabel.text = "plz insert number"
            
        }
    }
    
    @IBAction func touchUpResetButton(_ sender: UIButton) {
        print("touch up reset button")
        self.randomNumber = Int.random(in: 1...100)
        self.turnCount = 0
        self.resultLabel.text = "result"
        self.turnCountLabel.text = "0"
    }
    
    @IBAction func tapBackground(_ sender: UITapGestureRecognizer) {
        print("tap background view")
        self.inputField.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

