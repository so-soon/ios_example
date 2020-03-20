//
//  CustomView.swift
//  LoginFlow
//
//  Created by soonhyuk on 2020/03/10.
//  Copyright © 2020 soonhyuk. All rights reserved.
//

import UIKit

class CustomView: UIView {

    
    private func printLocation(of touch: UITouch, prefix: String = "")
    {
        let location: CGPoint = touch.location(in: self)
        print("\(prefix)\(location)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch: UITouch = touches.first else {return}
        self.printLocation(of: firstTouch, prefix: "touchesBegan")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch: UITouch = touches.first else {
            return
        }
        self.printLocation(of: firstTouch, prefix: "touchesMoved")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch: UITouch = touches.first else {
            return
        }
        self.printLocation(of: firstTouch, prefix: "touchesEnded")
    
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
