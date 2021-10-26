//
//  SignInView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/21.
//

import SwiftUI
import FirebaseAuth



struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showRegisteration = false
    
    @State private var showingAlert = false
    @State private var error:String = ""
    
    func errorCheck() -> String? {
        
        if  email.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty {
            return "빈칸을 모두 채워주세요"
        }
        return nil
        
    }
    
    func signIn(){
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthService.signIn(email: email, password: password, onSuccess: {
            (user) in
            
            if Auth.auth().currentUser!.isEmailVerified {
                
                
            } else {
                
                self.error = "이메일 인증을 확인해주세요!"
                self.showingAlert = true
                
                
            }
            
            
            
            
        }) {
            (errorMessage) in
            print("Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
            
        }
        
    }
    
    
    var body: some View {
        VStack{
            FormField(value: $email, icon: "envelope.fill", placeholder: "이메일")
            FormField(value: $password, icon: "lock.fill", placeholder: "비밀번호", isSecure: true)
           
            ButtonView(title: "로그인"){
                
                signIn()
                
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text("커커"), message: Text(error), dismissButton: .default(Text("OK")))
            }
            
            ButtonView(title:"회원가입",
                       background: .clear,
                       foreground: .blue,
                       border: .blue){
                showRegisteration.toggle()
            }.fullScreenCover(isPresented: $showRegisteration, content: {SignUpView()} )
            
            
          
            
            
            
            
        }.padding()
    }
}

 struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}