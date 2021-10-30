//
//  EditBioView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/30.
//

import SwiftUI


struct EditBioView: View {
    
    @ObservedObject private var viewModel = SessionStore()
    @EnvironmentObject var session: SessionStore
    
    
    var body: some View {
        List{
            
            ForEach(viewModel.bios){bio in
                
                
                BioView(date: bio.date, description: bio.description)
                    .modifier(CenterModifier())
                    .swipeActions{
                        
                        Button(role: .destructive, action: {}, label: {Label("삭제",systemImage: "trash.circle.fill")})
                        
                        
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: false){
                        Button(action: {}, label: {Label("수정",systemImage: "pencil.circle.fill")})
                            .tint(.blue)
                        
                        
                    }
                
                
                
            }
            
            
        }.onAppear(){
            self.viewModel.getBios(uid: self.session.session!.uid)
        }
    }
}

struct EditBioView_Previews: PreviewProvider {
    static var previews: some View {
        EditBioView()
    }
}
struct CenterModifier: ViewModifier{
    func body(content: Content) -> some View {
        HStack{
            Spacer()
            content
            Spacer()
        }
    }
}
