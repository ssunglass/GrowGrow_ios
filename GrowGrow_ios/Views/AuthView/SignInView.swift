//
//  SignInView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/21.
//

import SwiftUI
import FirebaseAuth
import FirebaseDynamicLinks
import FirebaseFirestore


enum SignInField{
    case field1
    case field2
   
    
}

struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showRegisteration = false
    
    @State private var showingAlert = false
    @State private var error:String = ""
    @State private var showingRegister = false
    
    @State var field1 = ""
    @State var field2 = ""
    
    
    @FocusState var activeState : SignInField?
   
    
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
        
        AuthService.signIn(email: email.trimmingCharacters(in: .whitespacesAndNewlines), password: password.trimmingCharacters(in: .whitespacesAndNewlines), onSuccess: {
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
        VStack(alignment: .center, spacing: 5){
            FormField(value: $email, placeholder: "이메일")
                .focused($activeState, equals: .field1)
                .submitLabel(.continue)
                .onSubmit {
                    activeState = .field2
                }
            FormField(value: $password, placeholder: "비밀번호", isSecure: true)
                .focused($activeState, equals: .field2)
              
           
            ButtonView(title: "로그인",
                       background: Color(hex: "#646464"),
                       foreground: .white,
                       border: Color(hex: "#646464")){
                
                signIn()
                
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text("커커"), message: Text(error), dismissButton: .default(Text("OK")))
            }
            
            
        
            
            ButtonView(title:"회원가입",
                       background: .black,
                       foreground: .white,
                       border: .black){
             
                    
                    
                    showRegisteration.toggle()
                    
                
              
            }.fullScreenCover(isPresented: $showRegisteration, content: {SignUpView()} )
            
            
            
            
            
            
            
        }.padding()
            .padding(.bottom, 50)
    }
}

 struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
