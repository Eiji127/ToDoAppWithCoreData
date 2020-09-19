
import UIKit
import CoreData


class ListViewController: UIViewController {
    
    public var item: String = ""
    public var detail: String = ""
    public var beginDate: Date!
    public var beginTime: Date!
    public var endDate: Date!
    public var endTime: Date!
    public var exitingItem: NSManagedObject!
    
    @IBOutlet var textFieldItem: UITextField!
    @IBOutlet var detailTextView: UITextView!
    
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
            detailTextView.text = detail
            beginDatePicker.date = beginDate!
            beginTimePicker.date = beginTime!
            endDatePicker.date = endDate!
            endTimePicker.date = endTime!
        }
        
        dateFormatter.setLocalizedDateFormatFromTemplate("yMMdE")
        timeFormatter.setLocalizedDateFormatFromTemplate("jm")
        beginDateButton.setTitle("\(dateFormatter.string(from: beginDatePicker.date))", for: UIControl.State.normal)
        beginTimeButton.setTitle("\(timeFormatter.string(from: beginTimePicker.date))", for: UIControl.State.normal)
        endDateButton.setTitle("\(dateFormatter.string(from: endDatePicker.date))", for: UIControl.State.normal)
        endTimeButton.setTitle("\(timeFormatter.string(from: endTimePicker.date))", for: UIControl.State.normal)
        
        detailTextView.layer.borderColor = UIColor.black.cgColor
        detailTextView.layer.borderWidth = 1.0
        detailTextView.layer.cornerRadius = 10
        detailTextView.layer.masksToBounds = true
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
        exitingItem.setValue(detailTextView.text, forKey: "detail")
        exitingItem.setValue(beginDatePicker.date, forKey: "beginDate")
        exitingItem.setValue(beginTimePicker.date, forKey: "beginTime")
        exitingItem.setValue(endDatePicker.date, forKey: "endDate")
        exitingItem.setValue(endTimePicker.date, forKey: "endTime")
    }
    
    private func createToDoContents() {
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let en = NSEntityDescription.entity(forEntityName: "List", in: context)
        var newItem = Model(entity: en!, insertInto: context)
        newItem.item = textFieldItem.text
        newItem.detail = detailTextView.text
        newItem.beginDate = beginDatePicker.date
        newItem.beginTime = beginTimePicker.date
        newItem.endDate = endDatePicker.date
        newItem.endTime = endTimePicker.date
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
    
    //キーボード表示
    private func setupNotificationObserver() {
           NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
       }
    
    @objc func showKeyboard(notification: Notification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.view.transform = .identity
        })

    }

    @objc func hideKeyboard() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.view.transform = .identity
        })
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

