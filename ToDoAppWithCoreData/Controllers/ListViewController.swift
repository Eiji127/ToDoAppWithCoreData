
import UIKit
import CoreData

protocol ListViewControllerDelegate {
    func tapSaveButton(item: String, detail: String, beginDate: Date, beginTime: Date, endDate: Date, endTime: Date, exitingItem: NSManagedObject?)
}


class ListViewController: UIViewController, UITextViewDelegate {
    
    public var item: String = ""
    public var detail: String = ""
    public var beginDate: Date!
    public var beginTime: Date!
    public var endDate: Date!
    public var endTime: Date!
    public var exitingItem: NSManagedObject?
    
    @IBOutlet var textFieldItem: UITextField!
    @IBOutlet var detailTextView: UITextView!
    @IBOutlet var saveButton: UIButton!
    
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
    
    var delegate: ListViewControllerDelegate?
    
    
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
        setDateAndTime()
        setDetailTextView()
    }
    
    
    private func setDetailTextView() {
        
        detailTextView.layer.borderColor = UIColor.black.cgColor
        detailTextView.layer.borderWidth = 1
        detailTextView.layer.cornerRadius = 10
        detailTextView.layer.masksToBounds = true
        
    }
    
    private func setDateAndTime() {
        
        dateFormatter.setLocalizedDateFormatFromTemplate("yMMdE")
        timeFormatter.setLocalizedDateFormatFromTemplate("jm")
        beginDateButton.setTitle("\(dateFormatter.string(from: beginDatePicker.date))", for: UIControl.State.normal)
        beginTimeButton.setTitle("\(timeFormatter.string(from: beginTimePicker.date))", for: UIControl.State.normal)
        endDateButton.setTitle("\(dateFormatter.string(from: endDatePicker.date))", for: UIControl.State.normal)
        endTimeButton.setTitle("\(timeFormatter.string(from: endTimePicker.date))", for: UIControl.State.normal)
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        if !self.beginDatePicker.isHidden {
            tapBeginDateButton(beginDateButton)
        } else if !self.beginTimePicker.isHidden{
            tapBeginTimeButton(beginTimeButton)
        } else if !self.endDatePicker.isHidden {
            tapEndDateButton(endDateButton)
        } else if !self.endTimePicker.isHidden {
            tapEndTimeButton(endTimeButton)
        }
        
    }
    
    @IBAction func tapSaveButton() {
        
        delegate?.tapSaveButton(item: textFieldItem.text!, detail: detailTextView.text!, beginDate: beginDatePicker.date, beginTime: beginTimePicker.date, endDate: endDatePicker.date, endTime: endTimePicker.date, exitingItem: exitingItem)
        dismiss(animated: true, completion: nil)
        
    }
    
}


