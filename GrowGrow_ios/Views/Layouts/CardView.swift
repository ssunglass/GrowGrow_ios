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
       
    let appleGothicBold: String = "Apple SD Gothic Neo Bold"
    let appleGothicLight: String = "Apple SD Gothic Neo Light"
    let appleGothicSemiBold: String = "Apple SD Gothic Neo SemiBold"
    let appleGothicMed : String = "Apple SD Gothic Neo Medium"
    
        var body: some View{
           
            VStack(alignment: .leading){
                HStack{
                    VStack(alignment: .leading){
                        Text(fullname)
                            .font(.custom(appleGothicBold, size: 36))
                            .foregroundColor(Color.black)
                        
                        Text(username)
                            .font(.custom(appleGothicLight, size: 14))
                            .foregroundColor(Color.black)
                            
                        Spacer()
                        
                       
                            
                            
                        }
                    .layoutPriority(100)
                    Spacer()
                    VStack{
                        Spacer()
                        
                        
                    /*Text("내 커리어 바로가기")
                        .font(.custom(appleGothicSemiBold, size: 18))
                        .foregroundColor(Color(hex: "#818181"))
                        //.padding(.top,10)
                       */
                      
                    }
                    
                                  
                    }
            .padding()

              
            }
            .frame(height:125)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(hex: "#F3F3F3"), lineWidth: 1)
            )
            .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "#F3F3F3"))
                            .shadow(color: Color(red:0, green: 0, blue: 0, opacity: 0.05), radius: 1, x: 0, y: 4))
            //.padding([.top, .horizontal])
            
        }
    
}

struct UserCardView: View {
        var fullname: String
        var username: String
        var depart: String
        var major: String
        var summary: String
    
    let appleGothicBold: String = "Apple SD Gothic Neo Bold"
    let appleGothicLight: String = "Apple SD Gothic Neo Light"
    let appleGothicSemiBold: String = "Apple SD Gothic Neo SemiBold"
    let appleGothicMed : String = "Apple SD Gothic Neo Medium"
    
    let colors = [Color(hex: "#f8f9fa"),
                  Color(hex: "#f1f3f5"),
                  Color(hex: "#e9ecef"),
                  Color(hex: "#dee2e6"),
                  Color(hex: "#212529"),]
    
    
   @State var random: Color = Color(hex: "#f8f9fa")
    @State var randomTextBase: Color = Color.black
    @State var randomTextSub: Color = Color.black
    
    
    
        var body: some View{
           
            VStack(alignment: .leading){
                HStack{
                    VStack(alignment: .leading){
                        Text(fullname)
                            .font(.custom(appleGothicBold, size: 21))
                            .foregroundColor(randomTextBase)
                            .kerning(-0.5)
                            
                        
                        Text("@\(username)")
                            .font(.custom(appleGothicLight, size: 10))
                            .foregroundColor(randomTextBase)
                            .kerning(-0.5)
                        
                        Divider()
                            .padding(.trailing,20)
                            
                        HStack(spacing: 3){
                            
                        
                        Text(depart)
                            .font(.custom(appleGothicBold, size: 13))
                            .foregroundColor(randomTextSub)
                            .kerning(-0.5)
                        Text(major)
                            .font(.custom(appleGothicBold, size: 13))
                            .foregroundColor(randomTextSub)
                            .kerning(-0.5)
                            
                        }
                        
                        Divider()
                            .padding(.trailing,20)
                        
                        Text(summary)
                            .font(.custom(appleGothicMed, size: 13))
                            .foregroundColor(randomTextBase)
                            .kerning(-0.5)
                            .multilineTextAlignment(.leading)
                        
                        }
                    .layoutPriority(100)
                
                                  
                    }
            .padding()
              
            }
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB,red: 150/255, green: 150/255, blue: 150/255, opacity: 0.5), lineWidth: 1)
                    
                    
            )
            .background(RoundedRectangle(cornerRadius: 10)
                            .fill(random)
                            .shadow(color: Color(red:0, green: 0, blue: 0, opacity: 0.05), radius: 1, x: 0, y: 4))
            .onAppear(){
                
                random = colors.randomElement()!
                
                
                if random == Color(hex: "#212529") {
                    
                    randomTextBase = Color.white
                    randomTextSub = Color.white
                    
                }
                
                
            }
          
            
           
            
            
           
            
        }
    
}


