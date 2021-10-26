//
//  Modal.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/25.
//


import SwiftUI

struct CusfftomAlert: View {
    @Binding var textEntered: String
    @Binding var showingAlert: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
            VStack {
                Text("Custom Alert")
                    .font(.title)
                    .foregroundColor(.black)
                
                Divider()
                
                TextField("Enter text", text: $textEntered)
                    .textCase(.uppercase)
                    .padding(5)
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    
                    
                Divider()
                
                HStack {
                    Button("Dismiss") {
                        self.showingAlert.toggle()
                    }
                }
                .padding(30)
                .padding(.horizontal, 40)
            }
        }
        .frame(width: 300, height: 200)
    }
}
