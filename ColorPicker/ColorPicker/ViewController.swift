//
//  ViewController.swift
//  ColorPicker
//
//  Created by soonhyuk on 2020/02/26.
//  Copyright © 2020 soonhyuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    private struct ColorComponent{
        typealias SliderTag = Int
        typealias Component = Int
        
        static let count: Int = 4
        
        static let red: Int = 0
        static let green: Int = 1
        static let blue: Int = 2
        static let alpha: Int = 3
        
        static func tag(`for`: Component) -> Int {
            return `for` + 100
        }
        
        static func component(from: SliderTag) -> Component {
            return from - 100
        }
    }
    
    private struct ViewTag{
        static let silderRed: Int = 100
        static let silderGreen: Int = 101
        static let silderBlue: Int = 102
        static let silderAlpha: Int = 103
        static let colorView: Int = 200
        static let pickerView: Int = 201
        
    }
    //@IBOutlet weak var colorView: UIView! // tag 200
    //@IBOutlet weak var pickerView: UIPickerView! // tag 201
    
    private let rgbStep: Float = 255.0
    private let numberOfRGBStep: Int = 52
    private let numberOfAlphaStep: Int = 11
    
    private var pickerView: UIPickerView!
    private var colorView: UIView!
    
    
    @IBAction func silderValueChanged(_ sender: UISlider) {
        guard (ViewTag.silderRed...ViewTag.silderAlpha).contains(sender.tag) else{
            print("wrong silder tag")
            return
        }
        let component: Int = ColorComponent.component(from: sender.tag)
        let row: Int
        
        if component == ColorComponent.alpha{
            row = Int(sender.value * 10)
        } else{
            row = Int(sender.value/5)
        }
        
        
        
        
        
        pickerView.selectRow(row, inComponent: component, animated: false)
        //self.pickerView.selectRow(row, inComponent: component, animated: false)
        
        self.matchViewColorWithCurrentValue()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.pickerView = self.view.viewWithTag(ViewTag.pickerView) as! UIPickerView
        self.colorView = self.view.viewWithTag(ViewTag.colorView)!
        
        for i in 0..<self.pickerView.numberOfComponents {
            let numberOfRows: Int = self.pickerView.numberOfRows(inComponent: i)
            self.pickerView.selectRow(numberOfRows - 1, inComponent: i, animated: false)
            
        }
    }


    private func matchViewColorWithCurrentValue(){
        
        guard let redSilder: UISlider = self.view.viewWithTag(ViewTag.silderRed) as? UISlider,
        let greenSilder: UISlider = self.view.viewWithTag(ViewTag.silderGreen) as? UISlider,
        let blueSilder: UISlider = self.view.viewWithTag(ViewTag.silderBlue) as? UISlider,
        let alphaSilder: UISlider = self.view.viewWithTag(ViewTag.silderAlpha) as? UISlider
            else {return}
        
        let red: CGFloat = CGFloat(redSilder.value / self.rgbStep)
        let green: CGFloat = CGFloat(greenSilder.value / self.rgbStep)
        let blue: CGFloat = CGFloat(blueSilder.value / self.rgbStep)
        let alpha: CGFloat = CGFloat(alphaSilder.value)
        
        let color: UIColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
        self.colorView.backgroundColor = color
    }
}



extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return ColorComponent.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == ColorComponent.alpha{
            return self.numberOfAlphaStep
        }else {
            return self.numberOfRGBStep
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == ColorComponent.alpha{
            return String(format: "%1.11f", Double(row) * 0.1)
        } else{
            return "\(row*5)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let sliderTag: Int = ColorComponent.tag(for: component)
        
        guard let slider: UISlider = self.view.viewWithTag(sliderTag) as? UISlider else{ return }
    
        if component == ColorComponent.alpha{
            slider.setValue(Float(row) / 10.0 , animated: false)
        } else {
            slider.setValue(Float(row) * 5.0, animated: false)
        }
        
        self.matchViewColorWithCurrentValue()
    }
    
}
