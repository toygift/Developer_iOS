//
//  MainViewController.swift
//  MemoAlone_custom
//
//  Created by jaeseong Lee on 2017. 7. 11..
//  Copyright © 2017년 jaeseong Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var receiveContact: [[String:String]] = []
    
    //array로 가져 왔음
    //array 로 불러올시 왜 subscript member..오류나지
    //[Any]? 타입인데..
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataCentre.shared.dataArray.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reuse") as! DetailTableViewCell

        let data = DataCentre.shared.dataArray
        cell.nameInput?.text = data[indexPath.row]["name"]
        cell.phoneInput?.text = data[indexPath.row]["phone"]
        cell.whereInput?.text = data[indexPath.row]["live"]
        
        
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
