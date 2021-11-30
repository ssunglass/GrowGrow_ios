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
    @ObservedObject var networkManager = NetworkManager()
    @State private var isLoading = false
    let appleGothicMed : String = "Apple SD Gothic Neo Medium"
    
    func listen(){
        
        session.listen()
      
        
    }
    
    var body: some View {
        
        
        ZStack {
            
            if networkManager.isConnected {
                
            
                
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
                
            
                
            } else {
                
                VStack{
                    Image(systemName: "wifi.slash")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.black)
                        .frame(width: 150, height: 150)
                    
                    Text("WIFI가 연결되지 않았습니다")
                        .font(.custom(appleGothicMed, size: 20))
                        .foregroundColor(.black)
                        .padding()
                    
                }
                
                
            }
            
         
            
          
            
            
            
            
            
            
        }.onAppear(perform: {
            
            isLoading = true
            listen()
            
       
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                
            
                isLoading = false
                
               
                
            }
          
        
           
            
            
        })
    
        
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
