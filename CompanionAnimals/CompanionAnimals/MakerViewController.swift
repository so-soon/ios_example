//
//  MakerViewController.swift
//  CompanionAnimals
//
//  Created by soonhyuk on 2020/02/26.
//  Copyright © 2020 soonhyuk. All rights reserved.
//

import UIKit

class MakerViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptionTextView.text = "야호 https://www.google.com"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchUpInsideDimissButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
