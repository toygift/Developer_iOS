//
//  ViewController.swift
//  asdf
//
//  Created by jaeseong on 2017. 8. 5..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit


var items = ["책구매","철수만남","영희만남"]
var itemsImageFile = ["cart.png","clock.png","pencil.png"]

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

 
    @IBOutlet var tvListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tvListView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = items[(indexPath as NSIndexPath).row]
        cell.imageView?.image = UIImage(named: itemsImageFile[(indexPath as NSIndexPath).row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: (indexPath as NSIndexPath).row)
            itemsImageFile.remove(at: (indexPath as NSIndexPath).row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }else if editingStyle == .insert {
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
        
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let itemToMove = items[(sourceIndexPath as NSIndexPath).row]
        let itemImageToMove = itemsImageFile[(sourceIndexPath as NSIndexPath).row]
        items.remove(at: (sourceIndexPath as NSIndexPath).row)
        itemsImageFile.remove(at: (sourceIndexPath as NSIndexPath).row)
        items.insert(itemToMove, at: (destinationIndexPath as NSIndexPath).row)
        itemsImageFile.insert(itemImageToMove, at: (destinationIndexPath as NSIndexPath).row)
        
        
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: editing)
        tvListView.setEditing(editing, animated: editing)
    }
    
}

