//
//  AddViewController.swift
//  memoria
//
//  Created by Randell Quitain on 26/5/21.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var descField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    public var completion: ((String, String, Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    @IBAction func didTapSave() {
        
        if let titleText = titleField.text, !titleText.isEmpty,
           let descText = descField.text, !descText.isEmpty {
            
            let targetDate = datePicker.date
        }
    }
}
