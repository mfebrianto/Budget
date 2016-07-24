//
// Created by michael febrianto on 24/07/2016.
// Copyright (c) 2016 f2mobile. All rights reserved.
//

import Foundation
import Alamofire

class ExpenseCategoryService {


    func getAll() {
        Alamofire.request(.GET, "http://192.168.1.113:8080/expense_categories")
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
    }
    

}