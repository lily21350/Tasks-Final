//
//  ViewController.swift
//  ToDoList
//
//  Created by girlswhocode on 7/11/19.
//  Copyright © 2019 girlswhocode. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
let TableViewControllerClass = TableViewController()
let myTableViewCellClass = myTableViewCell()
    

    
    @IBAction func AddTaskButton(_ sender: Any) {
        addNewTask()
    }
    override func viewDidLoad() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        super.viewDidLoad()
        
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    @IBOutlet weak var inputStartTimeDatePicker: UIDatePicker!
    @IBOutlet weak var inputTaskTextField: UITextField!
    @IBOutlet weak var inputEndTimeDatePicker: UIDatePicker!
    
    
    func addNewTask(){
        
        if (inputTaskTextField.text != "") {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let newTask = Task(context: context)
            
            newTask.taskName =  inputTaskTextField?.text
            
            let inputStartTimeDatePickerNumber = inputStartTimeDatePicker?.date
            
            let startTimeInterval = inputStartTimeDatePickerNumber?.timeIntervalSince1970
            
            newTask.startTimeName = Double(startTimeInterval ?? -1)
            
            let inputEndTimeDatePickerNumber = inputEndTimeDatePicker?.date
            
            let endTimeInterval = inputEndTimeDatePickerNumber?.timeIntervalSince1970
            
            newTask.endTimeName = Double(endTimeInterval ?? -1)
            
            TableViewControllerClass.tasks.append(newTask)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            inputTaskTextField.text = ""
            
            inputTaskTextField.resignFirstResponder()}
        
        // if(myTableViewCellClass.endTimeLabel.isEqual("")){
        
        //    myTableViewCellClass.dashLabel.text = ""
        
        // }else{
        
        //     myTableViewCellClass.dashLabel.text = "-"
        
        
        
        
        
        //}
        
    }
    }


    
    

