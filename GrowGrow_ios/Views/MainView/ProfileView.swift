//
//  ProfileView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/22.
//

import SwiftUI


struct ProfileView: View {
    
    @EnvironmentObject var session: SessionStore
    @State private var showEditView = false
    
    
    var body: some View {
        
        VStack {
            
            Group {
                
                HStack{
                    
                    VStack{
                        
                        Text(self.session.session!.fullname)
                        Text(self.session.session!.username)
                    }
                    
                    Button(action: {showEditView.toggle()}){
                        Image(systemName: "house")
                        
                    }.sheet(isPresented: $showEditView, content: {EditProfileView(initfullname: self.session.session!.fullname, initusername: self.session.session!.username, initsummary: self.session.session!.summary)})
                    
                    
                }
                
                
                
            }
            Divider()

            HStack{
                
            
                
                Text(self.session.session!.depart)
                Text(self.session.session!.major)
                
                
            }
            Divider()
                
                Text(self.session.session!.summary)
                
                
            
            
            
        }
        
    
       
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
