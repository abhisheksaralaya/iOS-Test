//
//  ListViewModel.swift
//  IOS Test Assessment
//
//  Created by Abhishek Saralaya on 29/04/24.
//

import Foundation
import UIKit

class ListViewModel {
    static private var _listDatas = [ListData]()
    static var listDatas: [ListData] {
        get {
            return _listDatas
        }
    }
    static func callAPI(onSuccess: @escaping(_ listDatas : [ListData])->Void, onError: @escaping(_ error : Error?)->Void){
        Network.callAPI(routes: .posts, parameter: "", onSuccess: {success in
            if let data = success.0 {
                do {
                    self._listDatas = try JSONDecoder().decode([ListData].self, from: data)
                    onSuccess(listDatas)
                } catch let error {
                    onError(error)
                    print(error)
                }
            } else if let error = success.1 {
                onError(error)
            } else {
                onError(nil)
            }
        })
    }
}
