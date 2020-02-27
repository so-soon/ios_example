//
//  MainViewController.swift
//  CompanionAnimals
//
//  Created by soonhyuk on 2020/02/26.
//  Copyright © 2020 soonhyuk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    private enum ButtonTag: Int{
        case dog = 101
        case cat,rabbit,hedgehog
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func animalInfo(for tag: ButtonTag) -> AnimalInfo?{
        let assetName: String
        
        switch tag {
        case ButtonTag.dog:
            assetName = "Dog"
        case ButtonTag.cat:
            assetName = "Cat"
        case ButtonTag.rabbit:
            assetName = "Rabbit"
        case ButtonTag.hedgehog:
            assetName = "Hedgehog"
        }
        return AnimalInfo.decode(from: assetName)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let button: UIButton = sender as? UIButton else { return }
        
        guard let nextViewController: DescriptionViewController = segue.destination as? DescriptionViewController else { return }
        
        guard let tag: ButtonTag = ButtonTag(rawValue: button.tag) else {
            print("cannot convert button tag to enum")
            return
        }
        
        guard let info: AnimalInfo = self.animalInfo(for: tag) else { return }
        
        nextViewController.animalInfo = info
    }
    

}
