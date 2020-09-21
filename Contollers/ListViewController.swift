
import UIKit
import CoreData


class ListViewController: UIViewController, UITextViewDelegate {
    
    public var item: String = ""
    public var detail: String = ""
    public var beginDate: Date!
    public var beginTime: Date!
    public var endDate: Date!
    public var endTime: Date!
    public var exitingItem: NSManagedObject!
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.layer.cornerRadius = 10
        
//        detailTextView.delegate = self
        
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
        detailTextView.layer.borderWidth = 1.0
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
    
    @IBAction func tappedSaveButton(sender: AnyObject) {
        if (exitingItem != nil) {
            changeToDoContents()
            print("あら")
        } else {
            createToDoContents()
            print("でた")
        }
        self.dismiss(animated: true, completion: nil)
//        let tableViewController = self.storyboard?.instantiateViewController(withIdentifier: "table") as! TableViewController
//        self.present(tableViewController, animated: true, completion: nil)
        
//        self.navigationController?.popToRootViewController(animated: true)
    }
        
//    @IBAction func tappedCancelButton(sender: AnyObject) {
//        tapCancelButtonAlert()
//    }
    
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
        let newItem = Model(entity: en!, insertInto: context)
        newItem.item = textFieldItem.text
        newItem.detail = detailTextView.text
        newItem.beginDate = beginDatePicker.date
        newItem.beginTime = beginTimePicker.date
        newItem.endDate = endDatePicker.date
        newItem.endTime = endTimePicker.date
        try! context.save()
        print("\(newItem)")
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
    
//    private func tapCancelButtonAlert() {
//        let alertController: UIAlertController = UIAlertController(title: "", message: "ToDoの内容が保存されていません。\nホームに戻ってもよろしいですか？", preferredStyle: .alert)
//        let noAction: UIAlertAction = UIAlertAction(title: "No", style: .cancel) { action -> Void in
//            alertController.dismiss(animated: false, completion: nil)
//        }
//        let yesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
//            self.navigationController?.popToRootViewController(animated: true)
//        }
//        alertController.addAction(noAction)
//        alertController.addAction(yesAction)
//        present(alertController, animated: true, completion: nil)
//    }
    
    
    
//    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//        setupNotificationObserver()
//        return true
//    }
    
//    func setupNotificationObserver() {
//        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    @objc func showKeyboard(notification: Notification) {
////        let userInfo = notification.userInfo!
////        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
////        let myBoundSize: CGSize = UIScreen.main.bounds.size
////        let txtLimit = detailTextView.frame.origin.y + detailTextView.frame.height + 8.0
////        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.size.height
////        let distance = txtLimit - kbdLimit
////        print("テキストフィールドの下辺：(\(txtLimit))")
////        print("キーボードの上辺：(\(kbdLimit))")
////
////        let transform = CGAffineTransform(translationX: 0, y: distance)
////        if txtLimit >= kbdLimit {
////            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
////                self.view.transform = transform
////            })
////        }
//        let transform = CGAffineTransform(translationX: 0, y: 300)
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
//            self.view.transform = transform
//        })
//
//    }
//    @objc func hideKeyboard() {
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
//            self.view.transform = .identity
//        })
//    }
    
  
}
