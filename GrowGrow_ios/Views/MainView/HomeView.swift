//
//  HomeView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/22.
//

import SwiftUI
import WaterfallGrid
import FirebaseAuth

struct HomeView: View {
    @EnvironmentObject var session: SessionStore
   // @ObservedObject private var viewModel = SessionStore()
    @StateObject private var viewModel = SessionStore()
    @State private var isDetailViewActive = false
    @State private var tapUserUid: String = ""
    
    let columns = [
        GridItem(.flexible(),spacing: 10, alignment: .center),
        GridItem(.flexible(), spacing: 10, alignment: .center)
    ]
    
    
    

    
    var body: some View {
        
        NavigationView{
      
        
    VStack(alignment:.leading){
                
        HomeCardView(fullname: viewModel.fullname,
                     username: "@\(viewModel.username)")
            .padding(.bottom)
           
           
            
            
        
        Divider()
            //.padding([.leading,.trailing,.bottom])
            .background(Color(hex: "#CBCBCB"))
            
        
        ScrollView {
            VStack(alignment: .center, spacing: 25) {
                Group{
                    Divider()
                        .frame(width: 35,height: 6)
                        .background(Color.black)
                    Text("다른 사람들은 지금을 \n어떻게 보내고 있을까?")
                        .foregroundColor(Color.black)
                        .font(.custom("Apple SD Gothic Neo Bold", size: 18))
                        .tracking(-0.5)
                    
                }
            }
            .padding(.bottom,15)
            .padding(.top,15)
           
            
        /*    HStack(spacing: 10){
                LazyVStack{
                    
                    ForEach(firstArrays){ user in
                        
                        NavigationLink(destination: UserDetailView(uid: user.uid)){
                            
                     
                            
                            

                            
                            UserCardView(fullname: user.fullname, username: user.username, depart: user.depart, major: user.major, summary: user.summary)
                                
                                
                           
                       
                            
                            
                        }
                        
                        
                    }
                    
                    
                }
                LazyVStack{
                    ForEach(viewModel.users.shuffled()){ user in
                        
                        NavigationLink(destination: UserDetailView(uid: user.uid)){
                            
                     
                            
                            

                            
                            UserCardView(fullname: user.fullname, username: user.username, depart: user.depart, major: user.major, summary: user.summary)
                                
                                
                           
                       
                            
                            
                        }
                        
                        
                    }
                }
                
            }.onAppear(){
                self.viewModel.getUsers()
             
               
            
            } */
          
               
                
            
            
    /*  LazyVGrid(columns: columns, alignment: .leading,spacing: 10) {
            ForEach(viewModel.users.shuffled()){ user in
                
                NavigationLink(destination: UserDetailView(uid: user.uid)){
                    
                
                    
                    

                    
                    UserCardView(fullname: user.fullname, username: user.username, depart: user.depart, major: user.major, summary: user.summary)
                        
                        
                    
                
                    
                    
                }
                
                
            }
            
            }
                 .onAppear(){
                    self.viewModel.getUsers()
                   
                
                }  */
            
            WaterfallGrid(viewModel.users.shuffled()) {user in
                
               


                    
                    UserCardView(fullname: user.fullname, username: user.username, depart: user.depart, major: user.major, summary: user.summary)
                        .onTapGesture {
                            isDetailViewActive.toggle()
                            
                            tapUserUid = user.uid
                                
                            
                        }
                       
                        
                        
                    
                
                    
                    
                
                
            }
            .gridStyle(columns: 2)
            .onAppear(){
                self.viewModel.getUsers()
               
            
            }
            
            NavigationLink(destination: UserDetailView(uid: tapUserUid), isActive: $isDetailViewActive){
                
            }.hidden()
              
            
            
            
        }
        //.padding([.leading,.trailing])
        
        
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
        self.viewModel.getUserDoc(uid: Auth.auth().currentUser?.uid ?? "uid")
        
      
        
        
    }
    .padding()
    .navigationBarHidden(true)
            
            
            
        }
        
            
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
