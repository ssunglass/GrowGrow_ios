//
//  MainTabContainer.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/22.
//

import SwiftUI

struct MainTabContainer: View {
    
  
    
    var body: some View {
        TabView {
            
                
                HomeView()
                    .tabItem{
                        Image(systemName: "house.fill")
                        Text("NOW")
                           
                          
                    
                    }
                
       
        SearchView()
            .tabItem{
                Image(systemName: "magnifyingglass")
                    Text("SEARCH")
                    .kerning(-0.5)
                    
            }
        
            
       /* NavigationView {
            
            SearchView()
            
                .navigationTitle("검색")
                
            
            
        }.tabItem{
            Image(systemName: "magnifyingglass")
        } */
        
            
            
            
            ProfileView()
                .tabItem{
                    Image(systemName: "bolt.horizontal.fill")
                    Text("PROFILE")
                        .kerning(-0.5)
                       
                }
            
            
            
        }
        .accentColor(.black)
        .edgesIgnoringSafeArea(.top)
       
    }
}

struct MainTabContainer_Previews: PreviewProvider {
    static var previews: some View {
        MainTabContainer()
    }
}


