//
//  UserModel.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/21.
//

import Foundation

struct User: Encodable, Decodable{

    var fullname:String
    var username:String
    var uid:String
    var summary:String
    var depart:String
    var major:String
    var region:String
}

struct AllUsers: Identifiable{
    var id: String = UUID().uuidString

    var fullname:String
    var username:String
   // var uid:String
    var summary:String
    var depart:String
    var major:String
   // var region:String
}

