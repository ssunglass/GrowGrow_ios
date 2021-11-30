//
//  MainTabContainer.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/22.
//

import SwiftUI

struct MainTabContainer: View {
    
    @State var selectedTab: Tab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
                
                HomeView()
                    .tabItem{
                        Image(systemName: "house.fill")
                        Text("NOW")
                            .tag(Tab.home)
                          
                    
                    }
                
       
        SearchView()
            .tabItem{
                Image(systemName: "magnifyingglass")
                    Text("SEARCH")
                    .kerning(-0.5)
                    .tag(Tab.search)
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
                        .tag(Tab.profile)
                }
            
            
            
        }
        .accentColor(.black)
        .edgesIgnoringSafeArea(.top)
        .onTapGesture(count: 2) {
            if self.selectedTab == . home {
                
                self.selectedTab = .search
                
            } else if self.selectedTab == .search {
                self.selectedTab = .search
            } else {
                
                self.selectedTab = .profile
            }
        }
    }
}

struct MainTabContainer_Previews: PreviewProvider {
    static var previews: some View {
        MainTabContainer()
    }
}

extension MainTabContainer {
    enum Tab: Hashable {
        case home
        case search
        case profile
    }
}
