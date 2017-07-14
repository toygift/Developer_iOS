//
//  DetailTableViewController.swift
//  NagMaker
//
//  Created by HyunJomi on 2017. 7. 6..
//  Copyright © 2017년 HyunJung. All rights reserved.
//

import UIKit

class DetailTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var locationIndex: Int! // collectoin view 아이템 정보
    
    var selectedItem: NagData?
    //var selectedlocation:String! // 선택한 로케이션 정보
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        titleLabel.text = selectedItem?.location
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectedItem?.nagList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableviewCell", for: indexPath)
        
        cell.textLabel?.text = selectedItem?.nagList[indexPath.row].nagTitle
        cell.textLabel?.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        return cell
    }
    
    // 2017.07.11 코드 추가 (정교윤)
    // 테이블 뷰 화면에서 오른손 엄지손가락으로 왼쪽으로 스와이프했을 때 delete 버튼이 나타나고 이를 클릭시 삭제하는 부분
    // NSInternalInconsistencyException 발생
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // collection view에서 선택한 indexPath.item과 table view에서 선택한 indexPath.row를 통해 실제 배열의 데이터를 삭제 후
            // 테이블 뷰에서도 지운다.
            let removeNagID = selectedItem?.nagList[indexPath.row].nagID
            
            // 실제 데이터 삭제
            DataCenter.standard.removeNag(selectedLocation: self.locationIndex, removeNagID: removeNagID!)
            
            // 현재 들고 있는 데이터에도 반영을 해준다.
            selectedItem?.nagList.remove(at: indexPath.row)
            
            // 테이블뷰에서도 삭제하여 리로드함
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "timerSegue"{
            
            let vc = segue.destination as! TimerViewController
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            let selectedNagItem = selectedItem?.nagList[indexPath.row]
            
            // 2017.07.11 업데이트 (정교윤)
            // collection view에서 클릭한 location의 index를 TimerViewController로 넘긴다.
            vc.locationIndex = self.locationIndex
            
            vc.nagData = selectedNagItem

            vc.duration = selectedNagItem?.duration
            vc.nagID = selectedNagItem?.nagID
            
        }
        else if segue.identifier == "addSegue"{
         
            let addVC = segue.destination as! AddAndEditViewController
            
            // 2017.07.11 업데이트 (정교윤)
            // 새로운 인덱스를 추출한 뒤 UserDefaults 에 "NewItemIndex"란 key로 저장함
            UserDefaults.standard.set(DataCenter.standard.getTotalCountOfExistingNagItems(), forKey: "NewItemIndex")
            
            addVC.locationIndex = self.locationIndex
            addVC.isEditMode = false
        
        }
    }
    
    
    
}

