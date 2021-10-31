//
//  HomeView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject private var viewModel = SessionStore()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        NavigationView{
      
        
    VStack(alignment:.leading){
                
        HomeCardView(fullname: viewModel.fullname,
                     username: "@\(viewModel.username)")
            
        
        Divider()
                
                Spacer()
        
        ScrollView {
            VStack {
                Group{
                    Divider().frame(width: 100)
                        .background(Color.red)
                    Text("다른 사람들은 지금을 어떻게 보내고 있을까?")
                    
                }
            }
            
            
          
               
                
            
            
            LazyVGrid(columns: columns) {
                ForEach(viewModel.users.shuffled()){ user in
                    
                    NavigationLink(destination: UserDetailView(uid: user.uid)){
                        
                    VStack(alignment:.leading){
                        
                        

                        
                        UserCardView(fullname: user.fullname, username: user.username, depart: user.depart, major: user.major, summary: user.summary)
                        }
                       /* Text(user.fullname)
                        Text(user.username)
                        Text(user.depart)
                        Text(user.major)
                        Text(user.summary)
                        */
                        
                        
                    }
                    
                    
                }
                }.onAppear(){
                    self.viewModel.getUsers()
                   
                
                }
                
            
            
            
        }
        
       /* ScrollView() {
                    VStack {
                       Group{
                            
                            Divider()
                            Text("Test")
                            
                            
                       }
                        
                        List(viewModel.users) {user in
                            VStack(alignment: .leading) {
                                Text(user.fullname)
                                Text(user.username)
                                Text(user.depart)
                                Text(user.major)
                                Text(user.summary)
                                
                            }
                        }
                        .onAppear(){
                            self.viewModel.getUsers()
                   }
                    } //VStack
                    
                    //중앙에서만 탭(스크롤)이 가능했던것을 프레임으로 전체로 늘려줌
                    .frame(maxWidth: .infinity)
            
        } */
    }.onAppear(){
        self.viewModel.getCurrentUser()
        
        
    }
    .navigationBarHidden(true)
            
            
            
        }
        
            
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
