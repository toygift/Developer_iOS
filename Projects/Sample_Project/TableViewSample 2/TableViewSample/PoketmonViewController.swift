//
//  PoketmonViewController.swift
//  TableViewSample
//
//  Created by youngmin joo on 2017. 6. 2..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit

class PoketmonViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return PoketMonData.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = PoketMonData.names[indexPath.row]
        cell.imageView?.image = UIImage(named: "\(indexPath.row+1)")
        cell.selectionStyle = .blue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let nextVC:DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        nextVC.imgName = "\(indexPath.row + 1)"
        nextVC.titleName = PoketMonData.names[indexPath.row]
//        nextVC.img.image = UIImage(named: "\(indexPath.row+1)")
//        nextVC.titleLb.text = PoketMonData.names[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
}
