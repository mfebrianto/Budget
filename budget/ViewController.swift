//
//  ViewController.swift
//  budget
//
//  Created by michael febrianto on 18/07/2016.
//  Copyright © 2016 f2mobile. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet weak var categoryTableView: UITableView!
    
    var names = [String]()
    
    override func viewDidLoad() {
        names.append("lalala")
        names.append("testtest")
        names.append("rrrrrr")
        
        print (">>>>view did load>>>>%d", names.count)
                
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "\"The List\""
        categoryTableView.registerClass(UITableViewCell.self,
                                forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func clickAddButton(sender: UIBarButtonItem) {
        
        print(">>>>clickAddButton")
        
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .Default,
                                       handler: { (action:UIAlertAction) -> Void in
                                        
                                        print(">>>>count>>>%d",self.names.count)
                                        let textField = alert.textFields!.first
                                        print(">>>>save click>>>%s",textField!.text!)
                                        self.names.append(textField!.text!)
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
    
    
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")
        
        print("table view reload")
        
        cell!.textLabel!.text = names[indexPath.row]
        
        return cell!
    }


}

