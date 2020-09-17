
import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var myList: Array<AnyObject> = []
    
    override func viewDidAppear(_ animated: Bool) {
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let freg = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        myList = try! context.fetch(freg)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
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
        var Cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CellID as! String) as! UITableViewCell
        if let ip = indexPath {
        var data : NSManagedObject = myList[ip.row] as! NSManagedObject
            var itemText = data.value(forKeyPath: "item") as! String
            var qnt = data.value(forKeyPath: "quantity") as! String
            var info = data.value(forKeyPath: "info") as! String
            Cell.textLabel?.text = itemText
            Cell.detailTextLabel?.text = "\(qnt) , \(info)"
            
        }
        return Cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "update" {
            let row = self.tableView?.indexPathForSelectedRow?.row ?? 0
            var selectedItem: NSManagedObject = myList[row] as! NSManagedObject
            let IVC: ListViewController = segue.destination as! ListViewController
            IVC.item = selectedItem.value(forKeyPath: "item") as! String
            IVC.exitingItem = selectedItem
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        if editingStyle == .delete {
            context.delete(myList[indexPath.row] as! NSManagedObject)
            myList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        } else if editingStyle == .insert {

        }
    }
   
}
