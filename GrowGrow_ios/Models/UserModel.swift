//
//  UserModel.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/21.
//

import Foundation
import FirebaseFirestore

struct User: Encodable, Decodable{

    var fullname:String
    var username:String
    var uid:String
    var summary:String
    var depart:String
    var major:String
    var region:String
    var departIcon: String
    var isVerified: Bool
}

struct AllUsers: Identifiable{
    var id: String = UUID().uuidString

    var fullname:String
    var username:String
    var uid:String
    var summary:String
    var depart:String
    var major:String
    var region:String
    var departIcon: String
}

struct Bio: Codable {
    var date : String
    var description: String
    
    
    
}

struct AllBios: Identifiable {
    var id: String = UUID().uuidString
    
    var date: String
    var description: String
    
}

/*struct Keyword: Identifiable {
    var id = UUID().uuidString
    var keywordText : String
    var isExceeded = false
} */

