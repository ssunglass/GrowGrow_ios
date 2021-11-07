//
//  SearchedView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/11/02.
//

import SwiftUI

struct SearchedView: View {
    
    @StateObject private var viewModel = SessionStore()
    
    var inputKeyword: String
    var inputDeparts: [String]
    var inputRegions: String?
    
    
    

    
    var body: some View {
        List{
            ForEach(viewModel.searchedUsers){ user in
                
                Text(user.fullname)
                
                
                
                
            }
            
            
            
        }.onAppear(){
            self.viewModel.getSearchedUser(keyword: inputKeyword, depart: inputDeparts, region: inputRegions ?? "")
            
         
            
        }
            .navigationTitle("검색된 유저")
    }
}


