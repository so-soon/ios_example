//
//  TodoViewController.swift
//  Todos
//
//  Created by soonhyuk on 2020/04/07.
//  Copyright © 2020 soonhyuk. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController{
    private enum Mode {
        case edit, view
    }
    
    static let storyboardID: String = "TodoViewController"
    
    var todo: Todo?
    

    
    private func initializeViews(){
        
        if let todo: Todo = self.todo {
            self.navigationItem.title = todo.title
            self.titleField.text = todo.title
            self.memoTextView.text = todo.memo
            self.dueDatePicker.date = todo.due
            self.mode = Mode.view
        }
    }
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var shouldNotifySwitch: UISwitch!
    
    
    private var mode: Mode = Mode.edit {
        didSet{
            self.titleField.isUserInteractionEnabled = (mode == .edit)
            self.memoTextView.isEditable = (mode == .edit)
            self.dueDatePicker.isUserInteractionEnabled = (mode == .edit)
            self.shouldNotifySwitch.isEnabled = (mode == .edit)
            
            if mode == Mode.edit {
                if todo == nil {
                    self.navigationItem.leftBarButtonItems = [self.cancelButton]
                } else {
                    self.navigationItem.rightBarButtonItems = [self.doneButton, self.cancelButton]
                }
            } else {
                self.navigationItem.rightBarButtonItems = [self.editButton]
            }
        }
    }
    
    private var editButton: UIBarButtonItem {
        let button: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(touchUpEditButton(_:)))
        
        return button
    }
    
    private var cancelButton: UIBarButtonItem {
        let button: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(touchUpCancelButton(_:)))
        
        return button
    }
    private var doneButton: UIBarButtonItem {
        let button: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(touchUpDoneButton(_:)))
        
        return button
    }
    
    private func showSimpleAlert(message: String, cancelTitle: String = "confirm", cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert: UIAlertController = UIAlertController(title: "alert", message: message, preferredStyle: UIAlertController.Style.alert)
        let action: UIAlertAction = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel, handler: cancelHandler)
        
        alert.addAction(action)
        self.present(alert,animated: true,completion: nil)
        
        }
    
    
    
    @objc private func touchUpEditButton(_ sender: UIBarButtonItem){
        self.mode = Mode.edit
    }
    
    @objc private func touchUpCancelButton(_ sender: UIBarButtonItem){
        
        if self.todo == nil{
            self.navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func touchUpDoneButton(_ sender: UIBarButtonItem) {
        
        guard let title: String = self.titleField.text, title.isEmpty == false else {
            self.showSimpleAlert(message: "title is necessary",cancelHandler: { (action: UIAlertAction) in self.titleField.becomeFirstResponder() })
            return
        }
        
        let todo: Todo
        todo = Todo(title: title, due: self.dueDatePicker.date, memo: self.memoTextView.text, shouldNotify: self.shouldNotifySwitch.isOn, id: self.todo?.id ?? String(Date().timeIntervalSince1970))
        
        let isSucess: Bool
        
        if self.todo == nil{
            
            isSucess = todo.save{
                self.navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        } else {
            isSucess = todo.save(completion: {
                self.todo = todo
                self.mode = Mode.view
            })
        }
        
        if isSucess == false {
            self.showSimpleAlert(message: "save failed")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.titleField.delegate = self
        
        if self.todo == nil{
            self.navigationItem.leftBarButtonItem = self.cancelButton
            self.navigationItem.rightBarButtonItem = self.doneButton
        } else {
            self.navigationItem.rightBarButtonItem = self.editButton
        }
        
        self.initializeViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.mode == Mode.edit{
            self.titleField.becomeFirstResponder()
        }
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

extension TodoViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.navigationItem.title = textField.text
    }
}
