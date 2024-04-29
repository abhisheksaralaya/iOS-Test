//
//  DetailModel.swift
//  IOS Test Assessment
//
//  Created by Abhishek Saralaya on 30/04/24.
//

import Foundation

struct DetailData : Decodable {
    let id: Int
    let postId: Int
    let name: String?
    let email: String?
    let body: String?
}
