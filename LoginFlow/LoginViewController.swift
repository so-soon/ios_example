//
//  LoginViewController.swift
//  LoginFlow
//
//  Created by soonhyuk on 2020/03/10.
//  Copyright © 2020 soonhyuk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController ,UITextFieldDelegate{

    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func touchUpLoginButton(_ sender: UIButton){
        
        guard let email: String = self.emailField.text, email.isEmpty == false else{
            self.showAlert(message: "plz input email", control: self.emailField)
            return
        }
        
        guard let password: String = self.passwordField.text, password.isEmpty == false, password.count >= 4 else{
            self.showAlert(message: "plz input passwd", control: self.passwordField)
            return
        }
        
        self.performSegue(withIdentifier: "ShowInfo", sender: sender)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        passwordField.delegate = self
        loginButton.isEnabled = false
        self.navigationItem.title = "Login"
        print("loginviewcontroller object is loaded in memory")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        print("loginviewcontroller object will be presented")
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        print(textFieldText.count)
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        if count >= 4 {
            loginButton.isEnabled = true
        }
        else{loginButton.isEnabled = false}
        return true
    }
    

    private func showAlert(message: String, control toBeFirstResponder: UIControl?)
    {
        let alert: UIAlertController = UIAlertController(title: "alert", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: "input", style: UIAlertAction.Style.default) {[weak toBeFirstResponder] (action: UIAlertAction) in toBeFirstResponder?.becomeFirstResponder()
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true){
            print("alert is presented")
        }
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("loginviewcontroller object is presented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("loginviewcontroller object will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("loginviewcontroller object is disappear")
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let email: String = self.emailField.text, let password: String = self.passwordField.text else {
            return
        }
        
        guard let id: String = segue.identifier else {
            return
        }
        
        guard id == "ShowInfo" else {
            return
        }
        
        guard let infoViewController = segue.destination as? InfoViewController else {
            return
        }
        
        infoViewController.loginInfo = LoginInfo(email: email, password: password)
    }
    

}
