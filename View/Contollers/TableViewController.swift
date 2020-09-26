
import UIKit
import CoreData


class TableViewController: UITableViewController, ListViewControllerDelegate {
    
    var myList: Array<AnyObject> = []
    
    func setTableView() {
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let freg = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        myList = try! context.fetch(freg)
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        editButtonItem.tintColor = UIColor.orange
        
        setTableView()
        
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        
        return false
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
        
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let sourceCellItem = myList[sourceIndexPath.row]
        myList.remove(at: sourceIndexPath.row)
        myList.insert(sourceCellItem, at: destinationIndexPath.row)
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myList.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath?) -> UITableViewCell {
        
        let CellID: NSString = "Cell"
        let Cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CellID as String)!
        if let ip = indexPath {
            let data : NSManagedObject = myList[ip.row] as! NSManagedObject
            let itemText = data.value(forKeyPath: "item") as! String
            Cell.textLabel?.text = itemText
            
        }
        
        return Cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        if editingStyle == .delete {
            
            context.delete(myList[indexPath.row] as! NSManagedObject)
            myList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            try! context.save()
            
        } else if editingStyle == .insert {

        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let lvc: ListViewController = segue.destination as! ListViewController
            if segue.identifier == "update" {
                
                let row = self.tableView?.indexPathForSelectedRow?.row ?? 0
                let selectedItem: NSManagedObject = myList[row] as! NSManagedObject
                lvc.item = selectedItem.value(forKeyPath: "item") as! String
                lvc.detail = selectedItem.value(forKey: "detail") as! String
                lvc.beginDate = selectedItem.value(forKey: "beginDate") as? Date
                lvc.beginTime = selectedItem.value(forKey: "beginTime") as? Date
                lvc.endDate = selectedItem.value(forKey: "endDate") as? Date
                lvc.endTime = selectedItem.value(forKey: "endTime") as? Date
                lvc.exitingItem = selectedItem
                lvc.delegate = self
                
            } else if segue.identifier == "add" {
                
                lvc.delegate = self
                
            }
        
        }

    func tapSaveButton(item: String, detail: String, beginDate: Date, beginTime: Date, endDate: Date, endTime: Date, exitingItem: NSManagedObject?) {
        
        print("save")
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        if (exitingItem != nil) {
            print("変更")
            exitingItem!.setValue(item, forKey: "item")
            exitingItem!.setValue(detail, forKey: "detail")
            exitingItem!.setValue(beginDate, forKey: "beginDate")
            exitingItem!.setValue(beginTime, forKey: "beginTime")
            exitingItem!.setValue(endDate, forKey: "endDate")
            exitingItem!.setValue(endTime, forKey: "endTime")
            try! context.save()
            
        } else {
            print("作成")
            let en = NSEntityDescription.entity(forEntityName: "List", in: context)
            let newItem = Model(entity: en!, insertInto: context)
            newItem.item = item
            newItem.detail = detail
            newItem.beginDate = beginDate
            newItem.beginTime = beginTime
            newItem.endDate = endDate
            newItem.endTime = endTime
            try! context.save()
            
        }
        
        setTableView()
        
    }

}

