//
//  TableViewController.swift
//  ToDoList
//
//  Created by girlswhocode on 7/11/19.
//  Copyright © 2019 girlswhocode. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
     

    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var tasks: [Task] = []
    //var times: [Task] = []
    
    @IBAction func deleteRows(_ sender: Any) {
        for object in tasks {
            self.context.delete(object)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        tasks.removeAll(keepingCapacity: false)
    
    self.myTableView.reloadData()
        
    }
    
    @IBAction func EditButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Adjust your schedule", message: "Choose how many minutes you would like to add or subtract", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title:"Add 15 Minutes",style: UIAlertAction.Style.default, handler: { action in
            
            self.add15Minutes()
            
            self.getData()
            
        }))
        
        alertController.addAction(UIAlertAction(title:"Add 30 Minutes",style: UIAlertAction.Style.default, handler: { action in
            
            self.add30Minutes()
            
            self.getData()
            
        }))
        
        alertController.addAction(UIAlertAction(title:"Add 1 Hour",style: UIAlertAction.Style.default, handler: { action in
            
            self.add60Minutes()
            
            self.getData()
            
        }))
        
        alertController.addAction(UIAlertAction(title:"Subtract 15 Minutes",style: UIAlertAction.Style.default, handler: { action in
            
            self.subtract15Minutes()
            
            self.getData()
            
        }))
        
        alertController.addAction(UIAlertAction(title:"Subtract 30 Minutes",style: UIAlertAction.Style.default, handler: { action in
            
            self.subtract30Minutes()
            
            self.getData()
            
        }))
        
        alertController.addAction(UIAlertAction(title:"Subtract 1 Hour",style: UIAlertAction.Style.default, handler: { action in
            
            self.subtract60Minutes()
            
            self.getData()
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alertController, animated: true)
    }
    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var EditButton: UIButton!
    
    func add15Minutes(){
        
        for object in tasks{
            
            object.endTimeName += 900
            
            object.startTimeName += 900
            
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    func add60Minutes(){
        
        for object in tasks{
            
            object.endTimeName += 3600
            
            object.startTimeName += 3600
            
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    func subtract15Minutes(){
        
        for object in tasks{
            
            object.endTimeName -= 900
            
            object.startTimeName -= 900
            
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    func subtract30Minutes(){
        
        for object in tasks{
            
            object.endTimeName -= 1800
            
            object.startTimeName -= 1800
            
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    func subtract60Minutes(){
        
        for object in tasks{
            
            object.endTimeName -= 3600
            
            object.startTimeName -= 3600
            
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    func getData(){
        //print("I'm getting the data")
        do {
            tasks = try context.fetch(Task.fetchRequest())
            print(tasks)
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        } catch {
            print("Couldn't fetch Data")
        }
    }
    func add30Minutes(){
        for object in tasks{
            object.endTimeName += 1800
            object.startTimeName += 1800
        }
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
        
    override func viewDidLoad() {
       super.viewDidLoad()
        self.tableView.isEditing = true
        getData()
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.leftBarButtonItem = self.editButtonItem
    

    // MARK: - Table view data source
    }
   
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! myTableViewCell
        
        
        
        cell.taskLabel?.text = tasks.reversed()[indexPath.row].taskName
        
        let mystartNSDate = Date(timeIntervalSince1970: tasks.reversed()[indexPath.row].startTimeName)
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "hh:mm a"
        
        let startString = formatter.string(from: mystartNSDate)
        
        cell.timeLabel?.text = "\(startString)"
        
        let myendNSDate = Date(timeIntervalSince1970: tasks.reversed()[indexPath.row].endTimeName)
        
        let endString = formatter.string(from: myendNSDate)
        
        cell.endTimeLabel?.text = "\(endString)"
        
        
        
        return cell
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = self.tasks[indexPath.row]
            self.context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            self.tasks.remove(at: indexPath.row)
            myTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    lazy var datePickerstart: UIDatePicker = {
        
        
        
        let picker = UIDatePicker()
        
        
        
        picker.datePickerMode = .time
        
        
        
        picker.addTarget(self, action: #selector(datePickerChangedend(_:)), for: .valueChanged)
        
        
        
        return picker
        
    }()
    
    lazy var dateFormatter: DateFormatter = {
        
        
        
        let formatter = DateFormatter()
        
        
        
        formatter.dateStyle = .none
        
        
        
        formatter.timeStyle = .short
        
        
        
        return formatter
        
    }()
    
    @objc func datePickerChangedend(_ sender: UIDatePicker) {
        
        
        
        startTimeText!.text = dateFormatter.string(from: sender.date)
        
    }
    
    
    
    
    
    lazy var datePickerend: UIDatePicker = {
        
        
        
        let picker = UIDatePicker()
        
        
        
        picker.datePickerMode = .time
        
        
        
        picker.addTarget(self, action: #selector(datePickerChangedstart(_:)), for: .valueChanged)
        
        
        
        return picker
        
    }()
    
    lazy var dateFormatterstart: DateFormatter = {
        
        
        
        let formatter = DateFormatter()
        
        
        
        formatter.dateStyle = .none
        
        
        
        formatter.timeStyle = .short
        
        
        
        return formatter
        
    }()
    
    @objc func datePickerChangedstart(_ sender: UIDatePicker) {
        
        
        
        endTimeText!.text = dateFormatter.string(from: sender.date)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
        
    }
    
    var editTask : UITextField?
    
    var startTimeText: UITextField?
    
    var endTimeText: UITextField?
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit"){
            
            (action,indexPath) in
            
            
            
            let alert = UIAlertController(title: "Make Changes", message: "Enter text", preferredStyle: .alert)
            
            
            
            
            
            
            
            alert.addTextField { (textField) in
                
                self.editTask = textField
                
                self.editTask!.placeholder = "New Task"
                
            }
            
            alert.addTextField { (textTime) in
                
                self.startTimeText = textTime
                
                self.startTimeText!.placeholder = "New Start Time"
                
                self.startTimeText?.inputView = self.datePickerstart
                
            }
            
            alert.addTextField { (textField) in
                
                self.endTimeText = textField
                
                self.endTimeText!.placeholder = "New End Time"
                
                self.endTimeText?.inputView = self.datePickerend
                
            }
            
            let editActionTextField = UIAlertAction(
                
            title: "Edit", style: .default) {
                
                (action) -> Void in
                
                if let newText = self.editTask?.text{
                    
                    if newText != ""{
                        
                        self.tasks.reversed()[indexPath.row].taskName = newText
                        
                        (UIApplication.shared.delegate as! AppDelegate).saveContext()
                        
                        self.getData()
                        
                    }
                    
                }
                
                
                
                var message = ["Don't Stop Until You're Proud", "Keep Calm and Carry On", "Stop Overthinking and Just Do", "Celebrate Every Tiny Victory"]
                
                let randomNumber = Int.random(in: 0..<4)
                
                let alert = UIAlertController(title: "Reminder", message: "\(message[randomNumber])", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: { action in
                    
                    switch action.style{
                        
                    case .default:
                        
                        print("default")
                        
                        
                        
                    case .cancel:
                        
                        print("cancel")
                        
                        
                        
                    case .destructive:
                        
                        print("destructive")
                        
                    }}))
                
                self.present(alert, animated: true, completion: nil)
                
                
                
                
                
                if let newText = self.startTimeText?.text{
                    
                    if newText != ""{
                        
                        let myDateFormatter = DateFormatter()
                        
                        myDateFormatter.dateFormat = "HH:mm a"
                        
                        myDateFormatter.locale = Locale(identifier: "en_US_POSIX")
                        
                        let date = self.dateFormatter.date(from:newText)!
                        
                        let myTimeInterval = date.timeIntervalSince1970
                        
                        self.tasks.reversed()[indexPath.row].startTimeName = Double(myTimeInterval)
                        
                        (UIApplication.shared.delegate as! AppDelegate).saveContext()
                        
                        self.getData()
                        
                    }
                    
                }
                
                if let newText = self.endTimeText?.text{
                    
                    if newText != ""{
                        
                        let myDateFormatter = DateFormatter()
                        
                        myDateFormatter.dateFormat = "HH:mm a"
                        
                        myDateFormatter.locale = Locale(identifier: "en_US_POSIX")
                        
                        let date = self.dateFormatter.date(from:newText)!
                        
                        let myTimeInterval = date.timeIntervalSince1970
                        
                        self.tasks.reversed()[indexPath.row].endTimeName = Double(myTimeInterval)
                        
                        (UIApplication.shared.delegate as! AppDelegate).saveContext()
                        
                        self.getData()
                        
                    }
                    
                }
                
            }
            
            alert.addAction(editActionTextField)
            self.present(alert, animated: true, completion: nil)
        }
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete")
        { (action, indexPath) in
            let task = self.tasks.reversed()[indexPath.row]
            self.context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            self.tasks.remove(at: indexPath.row)
            self.myTableView.deleteRows(at: [indexPath], with: .fade)

        }
        
        //            self.tasks[indexPath.row].endTimeName =
        
        //            self.tasks[indexPath.row].startTimeName = "Hello"
        
        //            self.tasks[indexPath.row].taskName = "Hello"
        
        //            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //            self.getData()
        
        return[deleteAction,editAction]
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }


    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    


}

