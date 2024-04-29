//
//  DetailViewModel.swift
//  IOS Test Assessment
//
//  Created by Abhishek Saralaya on 30/04/24.
//

import Foundation

class DetailViewModel {
    static private var _detailDatas = [DetailData]()
    static var detailDatas: [DetailData] {
        get {
            return _detailDatas
        }
    }
    static func callAPI(postId: Int,onSuccess: @escaping(_ detailData : [DetailData])->Void, onError: @escaping(_ error : Error?)->Void){
        Network.callAPI(routes: .comments, parameter: "\(postId)", onSuccess: {success in
            if let data = success.0 {
                do {
                    self._detailDatas = try JSONDecoder().decode([DetailData].self, from: data)
                    onSuccess(detailDatas)
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
