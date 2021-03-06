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
    
    let appleGothicSemiBold: String = "Apple SD Gothic Neo SemiBold"
    

    
    var body: some View {
        List{
            ForEach(viewModel.searchedUsers){ user in
                
                
                NavigationLink(destination: UserDetailView(uid: user.uid)){
                    
                
                    HStack{
                        
                        Image(systemName: user.departIcon)
                      
                
                       
                
                Text(user.fullname)
                            .font(.custom(appleGothicSemiBold, size: 18))
                            .foregroundColor(Color.black)
                        
                        Text("\(user.depart), \(user.major)")
                            .font(.custom(appleGothicSemiBold, size: 16))
                            .foregroundColor(Color(hex: "#A7A7A7"))
                        
                      /*  Text(user.major)
                            .font(.custom(appleGothicSemiBold, size: 15))
                            .foregroundColor(Color(hex: "#A7A7A7")) */
                        
                    }
                  
                    
                    
                }
                
                
                
                
            }
            
            
            
        }
        .listStyle(PlainListStyle())
        .onAppear(){
            self.viewModel.getSearchedUserAdvanced(keyword: inputKeyword, depart: inputDeparts, region: inputRegions ?? "")
            
         
            
        }
            .navigationTitle("검색된 유저")
    }
}


