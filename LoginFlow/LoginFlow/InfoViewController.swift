//
//  InfoViewController.swift
//  LoginFlow
//
//  Created by soonhyuk on 2020/03/10.
//  Copyright © 2020 soonhyuk. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var email_view: UITextView!
    @IBOutlet weak var passwd_View: UITextView!
    var loginInfo: LoginInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("infoviewcontroller object is loaded in memory")
        
        self.navigationItem.title = "login infomation"
        
        email_view.text = loginInfo?.email
        passwd_View.text = loginInfo?.password
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("infoviewcontroller object will be presented")
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        guard let info = self.loginInfo else{return}
        
        print(info)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("infoviewcontroller object is presented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("infoviewcontroller object will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("infoviewcontroller object is disappear")
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
