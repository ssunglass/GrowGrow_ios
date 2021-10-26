//
//  CardView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/22.
//

import SwiftUI

struct HomeCardView: View {
        var fullname: String
        var username: String
        var body: some View{
           
            VStack(alignment: .leading){
                HStack{
                    VStack(alignment: .leading){
                        Text(fullname)
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text(username)
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        
                        Text("내 커리어 바로가기")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        }
                    .layoutPriority(100)
                    Spacer()
                                  
                    }
            .padding()
              
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB,red: 150/255, green: 150/255, blue: 150/255, opacity: 0.5), lineWidth: 1)
            )
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.pink))
            .padding([.top, .horizontal])
            
        }
    
}

struct UserCardView: View {
        var fullname: String
        var username: String
        var depart: String
        var major: String
        var summary: String
        var body: some View{
           
            VStack(alignment: .leading){
                HStack{
                    VStack(alignment: .leading){
                        Text(fullname)
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text(username)
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        
                        Text(depart)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(major)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(summary)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        }
                    .layoutPriority(100)
                    Spacer()
                                  
                    }
            .padding()
              
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB,red: 150/255, green: 150/255, blue: 150/255, opacity: 0.5), lineWidth: 1)
                    
                    
            )
           
            .padding([.top, .horizontal])
           
            
        }
    
}


