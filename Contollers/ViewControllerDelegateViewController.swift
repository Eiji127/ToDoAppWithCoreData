
import UIKit

extension TableViewController {
    func tapSaveButton() {
        print("はろ")
        let lvc = ListViewController()
        lvc.table = self
        if (lvc.exitingItem != nil) {
            lvc.changeToDoContents()
        } else {
            lvc.createToDoContents()
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension ListViewController {
    }
    @IBAction func tapSaveButton() {
        extensionVar.table?.tapButton()
    }
}
