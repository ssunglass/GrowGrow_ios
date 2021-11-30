//
//  SignUpView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/21.
//

import SwiftUI

enum SignUpField{
    case field1
    case field2
    case field3
    case field4
    
}

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
    
    @State var field1 = ""
    @State var field2 = ""
    @State var field3 = ""
    @State var field4 = ""
    
    @FocusState var activeState : SignUpField?
    
    func signUp(){
        if let error = errorCheck(){
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthService.signUp(fullname: fullname.trimmingCharacters(in: .whitespacesAndNewlines), username: username.trimmingCharacters(in: .whitespacesAndNewlines), email: email.trimmingCharacters(in: .whitespacesAndNewlines), password: password, onSuccess: {
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
                .focused($activeState, equals: .field1)
                .submitLabel(.continue)
                .onSubmit {
                    activeState = .field2
                }
            FormField(value: $username,  placeholder: "username")
                .focused($activeState, equals: .field2)
                .submitLabel(.continue)
                .onSubmit {
                    activeState = .field3
                }
            FormField(value: $email, placeholder: "이메일")
                .focused($activeState, equals: .field3)
                .submitLabel(.continue)
                .onSubmit {
                    activeState = .field4
                }
            FormField(value: $password,  placeholder: "비밀번호를 6자 이상 입력해주세요", isSecure: true)
                .focused($activeState, equals: .field4)
               
               
            SecureInputView("비밀번호 재확인", text: $confirmpassword)
            ButtonView(title:"회원가입",background: Color.black, foreground: .white, border: .black){
                
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
