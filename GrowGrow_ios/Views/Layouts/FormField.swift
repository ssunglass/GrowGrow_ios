//
//  FormField.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/21.
//

import SwiftUI



struct FormField: View {
    @Binding var value : String
   // var icon : String
    var placeholder: String
    var isSecure = false
    
    let appleGothicSemiBold: String = "Apple SD Gothic Neo SemiBold"
    
    var body: some View {
        Group{
            HStack{
               // Image(systemName: icon).padding()
                Group{
                    if isSecure {
                        SecureField(placeholder, text: $value)
                            .textContentType(.oneTimeCode)
                    } else {
                        TextField(placeholder, text: $value)
                            .textContentType(.oneTimeCode)
                    }
                }
                .frame(maxHeight: 40, alignment: .center)
                .font(.custom(appleGothicSemiBold, size: 20))
                .foregroundColor(Color.black)
                .cornerRadius(15)
                    .multilineTextAlignment(.leading)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(.horizontal)
            }.overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 1)
                )
                .padding(.top, 10)
                .padding(.bottom, 10)
        }
    }
}

struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    let appleGothicSemiBold: String = "Apple SD Gothic Neo SemiBold"
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                        .textContentType(.oneTimeCode)
                } else {
                    TextField(title, text: $text)
                        .textContentType(.oneTimeCode)
                }
                
                
            } .frame(maxHeight: 40, alignment: .center)
                .font(.custom(appleGothicSemiBold, size: 20))
                .foregroundColor(Color.black)
                .cornerRadius(15)
                    .multilineTextAlignment(.leading)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(.horizontal)
            
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
            .padding(.trailing, 10)
        }.overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 1)
            )
            .padding(.top, 10)
            .padding(.bottom, 10)
    }
}


