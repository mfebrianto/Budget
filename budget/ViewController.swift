//
//  ViewController.swift
//  budget
//
//  Created by michael febrianto on 18/07/2016.
//  Copyright © 2016 f2mobile. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet var categoryTableView: UITableView!
    @IBOutlet var settingsButton: UIButton!
    
    var expenseCategories = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "\"The List\""
        categoryTableView.registerClass(UITableViewCell.self,
                                forCellReuseIdentifier: "Cell")
        categoryTableView.reloadData()
        print ("reloaded")
        
        
        let ecs = ExpenseCategoryService()
        ecs.getAll()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "ExpenseCategory")
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            expenseCategories = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    

    @IBAction func clickSettingsButton(sender: UIButton) {
        self.performSegueWithIdentifier("goToSettingsPage", sender: self)
    }
    
    @IBAction func clickAddButton(sender: UIBarButtonItem) {
        
        print(">>>>clickAddButton")
        
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .Default,
                                       handler: { (action:UIAlertAction) -> Void in
                                        
                                        let textField = alert.textFields!.first
                                        self.saveName(textField!.text!)
                                        self.categoryTableView.reloadData()
        })
        

        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
                              animated: true,
                              completion: nil)
        
    }
    
    
    
    func saveName(name: String) {
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entityDescription =  NSEntityDescription.entityForName("ExpenseCategory",
                                                        inManagedObjectContext:managedContext)

        let expenseCategory = ExpenseCategory(entity: entityDescription!, insertIntoManagedObjectContext: managedContext)
        
        expenseCategory.name = name
        
        
        //4
        do {
            try managedContext.save()
            //5
            expenseCategories.append(expenseCategory)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return expenseCategories.count
    }
    
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")
        
        let category = expenseCategories[indexPath.row]
        
        print("table view reload")
        
        cell!.textLabel!.text = category.valueForKey("name") as? String
        
        return cell!
    }

}

