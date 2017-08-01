//
//  DetailViewController.swift
//  MVC
//
//  Created by jaeseong on 2017. 7. 31..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    //***************************************************************
    // Outlet 변수
    //***************************************************************
    
    @IBOutlet private weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.reloadData()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //***************************************************************
    // Tableview cell
    //***************************************************************
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return Data.shared.personArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reuse") as! DetailTableViewCell
        
        cell.name.text = Data.shared.personArray[indexPath.row].name
        cell.age.text = Data.shared.personArray[indexPath.row].age
        
        return cell
    }

}
