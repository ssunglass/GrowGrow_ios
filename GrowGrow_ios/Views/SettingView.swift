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
                    
                    NavigationLink(destination: PersonalInfoWebView(urlToLoad: "https://locally.co.kr")){
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
