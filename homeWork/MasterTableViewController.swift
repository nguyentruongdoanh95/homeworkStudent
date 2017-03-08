//
//  MasterTableViewController.swift
//  homeWork
//
//  Created by Godfather on 3/8/17.
//  Copyright © 2017 Godfather. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {
    
    var arrStudent: [Student] = [Student]()
    
    var filePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return url!.appendingPathComponent("Data").path
    }
    
    @IBOutlet weak var displayView: UIView!
    @IBOutlet weak var message: UILabel!
    var isEmpty:Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributeText = NSMutableAttributedString(attributedString: NSAttributedString(string: "📃 Data is empty.\n", attributes: [NSForegroundColorAttributeName: UIColor.red]))
        attributeText.append(NSAttributedString(string: "Please press the '+' button to add data."))
        message.attributedText = attributeText
        addBarButtonItem()
        message.isHidden = true
        displayView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height))
        checkDataIsEmpty()
        
    }
    
    func addBarButtonItem() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MasterTableViewController.addData(sender:)))
        navigationItem.rightBarButtonItem = add
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    // MARK: Data and NSCoding
    func addData(sender: Any) {
        let arletVC = UIAlertController(title: "", message: "Nhập thông tin học sinh", preferredStyle: UIAlertControllerStyle.alert)
        arletVC.addTextField { (textField) in
            textField.placeholder = "Tên học sinh"
        }
        arletVC.addTextField { (textField) in
            textField.placeholder = "Tuổi học sinh"
        }
        arletVC.addTextField { (textField) in
            textField.placeholder = "Số điện thoại"
        }
        let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
            let nameInput = arletVC.textFields![0].text!
            let ageInput = arletVC.textFields![1].text!
            let phoneNumberInput = arletVC.textFields![2].text!
            self.arrStudent.append(Student(name: nameInput, age: ageInput, phoneNumber: phoneNumberInput))
            self.saveData()
            self.tableView.reloadData()
        }
        arletVC.addAction(okButton)
        present(arletVC, animated: true, completion: nil)
        
    }
    // Kiểm tra lần đầu khi chạy
    func checkDataIsEmpty() {
        if arrStudent.count > 0 {
            isEmpty = false
            showMessageIfDataIsEmpty()
        } else {
            isEmpty = true
            showMessageIfDataIsEmpty()
        }
    }
    // Show message
    func showMessageIfDataIsEmpty() {
      
        if isEmpty == true {
            message.isHidden = false
        } else {
            message.isHidden = true
        }
    }
    fileprivate func saveData() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(arrStudent, toFile: filePath)
        if isSuccessfulSave {
            if arrStudent.count == 0 {
                isEmpty = true
                showMessageIfDataIsEmpty()
            } else {
                isEmpty = false
                showMessageIfDataIsEmpty()
            }
        } else {
            print("Save thất bại")
        }
    }
    
    func loadData() -> [Student]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Student]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStudent.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StudentTableViewCell
        cell.lblName.text = "Tên: \(arrStudent[indexPath.row].name!)"
        cell.lblAge.text = "Tuổi: \(arrStudent[indexPath.row].age!) "
        cell.lblPhoneNumber.text = "Số điện thoại: \(arrStudent[indexPath.row].phoneNumber!)"
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrStudent.remove(at: indexPath.row)
            self.saveData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
}
