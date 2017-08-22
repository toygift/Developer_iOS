//
//  BookMarkList.swift
//  RecipeStepController
//
//  Created by jaeseong on 2017. 8. 23..
//  Copyright © 2017년 sevenTeam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toaster

class BookMarkList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var data: JSON = JSON.init(rawValue: [])!
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchBookMakrData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
//        tableView.reloadData()
    }
    
    
}
extension BookMarkList {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarklist") as? BookMarkListCell
        
        let recipeTitle = self.data[indexPath.row]["recipe"].intValue
        let recipeMemo = self.data[indexPath.row]["memo"].stringValue
        print(recipeMemo)
        //print(recipeTitle)
        cell?.recipeTitle.text = "\(recipeTitle)"
        cell?.recipeMemo.text = recipeMemo
        
        return cell!
    }
    
}

extension BookMarkList {
    func fetchBookMakrData() {
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let url = "http://pickycookbook.co.kr/api/recipe/bookmark/"
        let headers: HTTPHeaders = ["Authorization":"token \(token)"]
        
        let call = Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
        call.responseJSON { (response) in
            switch response.result {
            case .success(let value):
                self.data = JSON(value)
                self.tableView.reloadData()
                print(self.data)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
