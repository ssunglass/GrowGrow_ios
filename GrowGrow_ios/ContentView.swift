//
//  ContentView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/21.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @EnvironmentObject var session: SessionStore
    @State private var isLoading = false
    
    
    func listen(){
        session.listen()
    }
    
    var body: some View {
        
        
        ZStack {
            
            Group{
                
                if isLoading {
                    
                    
                    LoadingView()
                    
                    
                    
                }
                    
             if(session.session != nil) {
                    
                            
                           MainTabContainer()
                            
                      
                        
                        
                    } else {
                        
                        SignInView()
                    }
                    
                    
                    
                    
                    
                
                
                
                
                
                
            }
            
          
            
            
            
            
            
            
        }.onAppear(perform: {
            isLoading = true
            
            DispatchQueue.main.async {
            listen()
               // isLoading = false
                
            }
           
            
            
        })
       /* Group{
            
            if(session.session != nil) {
            
                    
                   MainTabContainer()
                    
              
                
                
            } else {
                
                SignInView()
            }
            
         
            
        
            
        }.onAppear(perform: {
            
        
            DispatchQueue.main.async {
            listen()
               
        }}) */
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct LoadingView: View {
    
    var body: some View {
        
        ZStack{
            
            Color.gray
                .ignoresSafeArea()
                .opacity(1)
            
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .black))
            .scaleEffect(3)
        
        }
        
        
        
        
    }
    
}
