//
//  SettingView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/11/21.
//

import SwiftUI

struct SettingView: View {
    
   
    @EnvironmentObject var session: SessionStore
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
        VStack{
        
            
            Form {
                
                Section(content: {
                    
                    NavigationLink(destination: PersonalInfoWebView(urlToLoad: "https://minguk.notion.site/minguk/CS-Center-1fe5f43156b84d4ea14d85bb39e8b919")){
                        Text("지원페이지")
                        
                        
                    }
                    
                    
                    
                    
                }, header: {
                    
                   
                    
                })
                
                Section(content: {
                    
                    NavigationLink(destination: PersonalInfoWebView(urlToLoad: "https://minguk.notion.site/f1f6f8a1328840a189721964dfb92069")){
                        Text("개인정보처리방침")
                        
                        
                    }
                    
                    
                    
                    
                }, header: {
                    
                   
                    
                })
                
                Section{
                    
                    Button(action: {
                        
                        DispatchQueue.main.async {
                            self.presentationMode.wrappedValue.dismiss()
                            self.session.logout()
                        }
                        
                        
                    }){
                        
                        Text("로그아웃")
                            .foregroundColor(.red)
                        
                        
                        
                        
                    }
                    
                }
                
                
                
                
                
            }
         
        }
            
            
            
            .navigationTitle("설정")
            
            
            
            
          
            
            
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
