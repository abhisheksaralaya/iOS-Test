//
//  Network.swift
//  IOS Test Assessment
//
//  Created by Abhishek Saralaya on 30/04/24.
//

import Foundation

class Network {
    
    static let baseURL = "https://jsonplaceholder.typicode.com/"
    public enum Routes {
        case posts
        case comments
        
        fileprivate var value:String {
            
            switch self {
            case .posts:
                return baseURL + "posts"
            case .comments:
                return baseURL + "posts/%@/comments"
            }
        }
        
    }

    static func callAPI(routes: Routes, parameter: String, onSuccess: @escaping(_ success : (Data?,Error?))->Void){
        if let url = URL(string: String(format: routes.value, parameter)) {
            
            let task = URLSession.shared.dataTask(with: url){ data, response, error in
                if let error = error { onSuccess((nil,error)); return }
                onSuccess((data,nil))
            }
            task.resume()
        } else {
            onSuccess((nil,nil))
        }
    }
}
