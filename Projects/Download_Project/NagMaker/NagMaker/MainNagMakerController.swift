//
//  ViewController.swift
//  NagMaker
//
//  Created by HyunJomi on 2017. 7. 6..
//  Copyright © 2017년 HyunJung. All rights reserved.
//

import UIKit

class MainNagMakerController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    //MARK:- collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return DataCenter.standard.nagArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CustomCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MycollectionCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.set(title: DataCenter.standard.nagArray[indexPath.item].location, imageUrl: DataCenter.standard.nagArray[indexPath.item].location_url)
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        let vc = segue.destination as! DetailTableViewController
        
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        
        let selectedNagItem = DataCenter.standard.nagArray[indexPath.item]
        
        vc.selectedItem = selectedNagItem  // Collection View에서 선택한 로케이션 관련 인덱스를 기준으로 테이블 뷰에 보여줄 아이템 리스트를 넘긴다.
        vc.locationIndex = indexPath.item  // Collection View에서 선택한 로케이션 관련 인덱스를 넘긴다.
   }
    
}

