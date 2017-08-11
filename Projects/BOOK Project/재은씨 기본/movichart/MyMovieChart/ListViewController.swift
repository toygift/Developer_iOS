//
//  ListViewController.swift
//  MyMovieChart
//
//  Created by 이재성 on 2017. 6. 14..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ListViewController : UITableViewController {
    
    var dataset = [
                    ("다크나이트", "영웅물에 철학에 음악이 더해짐", "2008-09-24", 9.95,"darknight.jpg"),
                    ("호우시절", "때를 알고 내리는 비", "2008-09-14", 7.31,"rain.jpg"),
                    ("말할 수 없는 비밀", "여기서 너까지 다섯걸음", "2006-03-11", 4.75,"secret.jpg")
    ]
    
    lazy var list : [MovieVO] = {
        
        var datalist = [MovieVO]()
        
        for (title, desc, opendate, rating, thumnail) in self.dataset {
            let mvo = MovieVO()
            
            mvo.title = title
            mvo.description = desc
            mvo.opendate = opendate
            mvo.rating = rating
            mvo.thumnail = thumnail
            
            datalist.append(mvo)
        }
        return datalist
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        
        
//        let title = cell.viewWithTag(101) as? UILabel
//        
//        let desc = cell.viewWithTag(102) as? UILabel
//        
//        let opendate = cell.viewWithTag(103) as? UILabel
//        
//        let rating = cell.viewWithTag(104) as? UILabel
        
        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
        cell.thumbnail.image = UIImage(named: row.thumnail!)
        
        
        
        
        
        
//        cell.textLabel?.text = row.title
//        
//        cell.detailTextLabel?.text = row.description
//        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row)번째 행입니다")
    }
}
