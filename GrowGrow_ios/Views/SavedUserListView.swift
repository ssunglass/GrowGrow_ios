//
//  SavedUserListView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/11/05.
//

import SwiftUI

struct SavedUserListView: View {
    
    @StateObject private var viewModel = SessionStore()
    
    
    var body: some View {
        List{
            
            ForEach(viewModel.savedUsers){savedUser in
                
                Text(savedUser.fullname)
                
            }
            
            
            
        }.onAppear(){
            
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
