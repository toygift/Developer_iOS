//
//  RecipeSearch.swift
//  RecipeStepController
//
//  Created by js on 2017. 8. 22..
//  Copyright © 2017년 sevenTeam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toaster


class RecipeSearch: UIViewController {

    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var tagSearchTextField: UITextField!
    
    @IBAction func searchPlease(_ sender: UIButton) {
        
        alamofireSearch()
    }
    
    func alamofireSearch(){
        
        guard let search = self.searchTextField.text else { return }
            
        let param = "http://pickycookbook.co.kr/api/recipe/search/?search=\(search)"
        
        let encodedParam = param.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = URL(string: encodedParam!)
        
        Alamofire.request(url!, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(let value):
               let result = JSON(value)
               print(result)
               
            case .failure(let error):
                print(error)
               
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
