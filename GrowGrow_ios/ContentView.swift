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
    
    func listen(){
        session.listen()
    }
    
    var body: some View {
        
        Group{
            
            if(session.session != nil) {
                
                if Auth.auth().currentUser!.isEmailVerified {
                    
                    MainTabContainer()
                    
                    
                    
                }
                
                
            } else {
                
                SignInView()
            }
            
        }.onAppear(perform: { DispatchQueue.main.async {
            listen()
        }})
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
