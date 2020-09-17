//
//  ListViewController.swift
//  ToDoAppWithCoreData
//
//  Created by 白数叡司 on 2020/09/12.
//  Copyright © 2020 AEG. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController {
    
    var item: String = ""
    var exitingItem: NSManagedObject!
    
    @IBOutlet var textFieldItem: UITextField!
    @IBOutlet var textFieldQuantity: UITextField!
    @IBOutlet var textFieldInfo: UITextField!
    
    let setDate = Date()
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()

    @IBOutlet var beginDatePicker: UIDatePicker!
    @IBOutlet var beginTimePicker: UIDatePicker!
    @IBOutlet var beginDateButton: UIButton!
    @IBOutlet var beginTimeButton: UIButton!
    @IBOutlet var endDatePicker: UIDatePicker!
    @IBOutlet var endTimePicker: UIDatePicker!
    @IBOutlet var endDateButton: UIButton!
    @IBOutlet var endTimeButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if(exitingItem != nil){
            textFieldItem.text = item
        }
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("yMMdE")
        timeFormatter.setLocalizedDateFormatFromTemplate("jm")
        beginDateButton.setTitle("\(dateFormatter.string(from: beginDatePicker.date))", for: UIControl.State.normal)
        beginTimeButton.setTitle("\(timeFormatter.string(from: beginTimePicker.date))", for: UIControl.State.normal)
        endDateButton.setTitle("\(dateFormatter.string(from: endDatePicker.date))", for: UIControl.State.normal)
        endTimeButton.setTitle("\(timeFormatter.string(from: endTimePicker.date))", for: UIControl.State.normal)
    }
    
    @IBAction func tappedSaveButton(sender: AnyObject) {
        if (exitingItem != nil) {
            changeToDoContents()
        } else {
            createToDoContents()
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func tappedCancelButton(sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func changeToDoContents() {
        exitingItem.setValue(textFieldItem.text, forKey: "item")
        exitingItem.setValue(textFieldQuantity.text, forKey: "quantity")
        exitingItem.setValue(textFieldInfo.text, forKey: "info")
    }
    
    private func createToDoContents() {
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let en = NSEntityDescription.entity(forEntityName: "List", in: context)
        var newItem = Model(entity: en!, insertInto: context)
        newItem.item = textFieldItem.text
    }
    
    @IBAction func tapBeginDateButton(_ sender: UIButton) {
           if !self.beginTimePicker.isHidden {
               tapBeginTimeButton(beginTimeButton)
           } else if !self.endDatePicker.isHidden {
               tapEndDateButton(endDateButton)
           } else if !self.endTimePicker.isHidden {
               tapEndTimeButton(endTimeButton)
           }
           UIView.animate(withDuration: 0.1, animations: {
               self.beginDatePicker.isHidden = !self.beginDatePicker.isHidden
           })
           dateFormatter.setLocalizedDateFormatFromTemplate("yMMdE")
           beginDateButton.setTitle("\(dateFormatter.string(from: beginDatePicker.date))", for: UIControl.State.normal)
       }
       
       @IBAction func tapBeginTimeButton(_ sender: UIButton) {
           if !self.beginDatePicker.isHidden {
               tapBeginDateButton(beginDateButton)
           } else if !self.endDatePicker.isHidden {
               tapEndDateButton(endDateButton)
           } else if !self.endTimePicker.isHidden {
               tapEndTimeButton(endTimeButton)
           }
           UIView.animate(withDuration: 0.1, animations: {
                      self.beginTimePicker.isHidden = !self.beginTimePicker.isHidden
           })
           timeFormatter.setLocalizedDateFormatFromTemplate("jm")
           beginTimeButton.setTitle("\(timeFormatter.string(from: beginTimePicker.date))", for: UIControl.State.normal)
       }
       
       @IBAction func tapEndDateButton(_ sender: UIButton) {
           if !self.beginDatePicker.isHidden {
               tapBeginDateButton(beginDateButton)
           } else if !self.beginTimePicker.isHidden{
               tapBeginTimeButton(beginTimeButton)
           } else if !self.endTimePicker.isHidden {
               tapEndTimeButton(endTimeButton)
           }
           UIView.animate(withDuration: 0.1, animations: {
               self.endDatePicker.isHidden = !self.endDatePicker.isHidden
           })
           dateFormatter.setLocalizedDateFormatFromTemplate("yMMdE")
           endDateButton.setTitle("\(dateFormatter.string(from: endDatePicker.date))", for: UIControl.State.normal)
       }
       
       @IBAction func tapEndTimeButton(_ sender: UIButton) {
           if !self.beginDatePicker.isHidden {
               tapBeginDateButton(beginDateButton)
           } else if !self.beginTimePicker.isHidden{
               tapBeginTimeButton(beginTimeButton)
           } else if !self.endDatePicker.isHidden {
               tapEndDateButton(endDateButton)
           }
           UIView.animate(withDuration: 0.1, animations: {
               self.endTimePicker.isHidden = !self.endTimePicker.isHidden
           })
           dateFormatter.setLocalizedDateFormatFromTemplate("yMMdE")
           endTimeButton.setTitle("\(timeFormatter.string(from: endTimePicker.date))", for: UIControl.State.normal)
       }

}
