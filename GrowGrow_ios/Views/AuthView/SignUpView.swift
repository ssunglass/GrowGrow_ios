//
//  SignUpView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/21.
//

import SwiftUI

struct SignUpView: View {
    @State private var fullname: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmpassword: String = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State private var error:String = ""
    @State private var sendEmail = false
    
    
    func signUp(){
        if let error = errorCheck(){
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthService.signUp(fullname: fullname, username: username, email: email, password: password, onSuccess: {
            (user) in
            
           
            //presentationMode.wrappedValue.dismiss()
            
            
            
        }) {
            (errorMessage) in
            print("Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
            
            
        }
    }
    
    
    
    func errorCheck() -> String? {
        
        if fullname.trimmingCharacters(in: .whitespaces).isEmpty ||
            username.trimmingCharacters(in: .whitespaces).isEmpty ||
            email.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty ||
            confirmpassword.trimmingCharacters(in: .whitespaces).isEmpty {
            return "빈칸을 모두 채워주세요"
        } else if
            password != confirmpassword {
            return "비밀번호가 일치하지 않습니다"
        }
        return nil
        
    }
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            ZStack(alignment: .topLeading){
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding()
                }
                
            }
            
           // Spacer()
            
            FormField(value: $fullname, placeholder: "fullname")
            FormField(value: $username,  placeholder: "username")
            FormField(value: $email, placeholder: "이메일")
            FormField(value: $password,  placeholder: "비밀번호", isSecure: true)
            SecureInputView("비밀번호 재확인", text: $confirmpassword)
            ButtonView(title:"이메일 인증",background: Color.black, foreground: .white, border: .black){
                
                signUp()
                
                
            }.alert(isPresented: $showingAlert){
                Alert(title: Text("커커"),
                      message: Text(error),
                      dismissButton: .default(Text("확인"),
                                      action: {
                    
                  /* if sendEmail {
                        
                        presentationMode.wrappedValue.dismiss()
                        
                    }
                    */
                    
                })
                
                  
                    
                )
            }
            
            Spacer()
            
            
           
            
            
            
            
        }
        .padding()
            
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
