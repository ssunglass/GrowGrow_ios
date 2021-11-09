//
//  SavedUserListView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/11/05.
//

import SwiftUI

struct SavedUserListView: View {
    
    @StateObject private var viewModel = SessionStore()
    
    let appleGothicSemiBold: String = "Apple SD Gothic Neo SemiBold"

    
    
    
  
    
    
    var body: some View {
        
       
        List{
           
            ForEach(viewModel.savedUsers){savedUser in
                
                NavigationLink(destination: UserDetailView(uid: savedUser.uid)){
                    
                
                    HStack{
                        
                        Image(systemName: savedUser.departIcon)
                      
                
                       
                
                Text(savedUser.fullname)
                            .font(.custom(appleGothicSemiBold, size: 18))
                            .foregroundColor(Color.black)
                        
                    }
                  
                    
                    
                }
               
            }
            
            
            
        }
        .listStyle(PlainListStyle())
        .onAppear(){
            
            self.viewModel.getSavedUsers()
            
            
            
        }
        
        .navigationTitle("저장된 유저")
        
       
            
        
    }
}

struct SavedUserListView_Previews: PreviewProvider {
    static var previews: some View {
        SavedUserListView()
    }
}
