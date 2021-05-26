//
//  AddViewController.swift
//  memoria
//
//  Created by Randell Quitain on 26/5/21.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var bodyField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    public var completion: ((String, String, String, Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField.delegate = self
        bodyField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }
    
    @objc func didTapSave() {
        
        let uuid = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        let id = "reminder_\(uuid)"
        
        if let titleText = titleField.text, !titleText.isEmpty,
           let bodyText = bodyField.text, !bodyText.isEmpty {
            
            let targetDate = datePicker.date
            
            PostService.shared.setNewReminder(
                id: id,
                title: titleText,
                body: bodyText,
                date: targetDate.timeIntervalSince1970
            )
            
            completion?(id, titleText, bodyText, targetDate)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
