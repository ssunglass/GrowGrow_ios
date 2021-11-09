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



struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showRegisteration = false
    
    @State private var showingAlert = false
    @State private var error:String = ""
    @State private var showingRegister = false
    
    @UIApplicationDelegateAdaptor(Appdelegate.self) var appDelegate
    
    
    
    func handleDynamicLink(_ dynamicLink: DynamicLink?) -> Bool {
      guard let dynamicLink = dynamicLink else { return false }
      guard let deepLink = dynamicLink.url else { return false }
      let queryItems = URLComponents(url: deepLink, resolvingAgainstBaseURL: true)?.queryItems
      let invitedBy = queryItems?.filter({(item) in item.name == "invitedby"}).first?.value
      let user = Auth.auth().currentUser
      // If the user isn't signed in and the app was opened via an invitation
      // link, sign in the user anonymously and record the referrer UID in the
      // user's RTDB record.
      if user == nil && invitedBy != nil {
        Auth.auth().signInAnonymously() { (user, error) in
          if let user = user {
              let userRecord = Firestore.firestore().collection("Users")
                  .document(user.user.uid)
              userRecord.setData([
              
                "referredBy" : invitedBy!
                
              ])
          
          }
            
            
            
            
            
            
        }
      }
      return true
    }
    
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
        VStack(alignment: .center, spacing: 5){
            FormField(value: $email, placeholder: "이메일")
            FormField(value: $password, placeholder: "비밀번호", isSecure: true)
           
            ButtonView(title: "로그인",
                       background: Color(hex: "#646464"),
                       foreground: .white,
                       border: Color(hex: "#646464")){
                
                signIn()
                
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text("커커"), message: Text(error), dismissButton: .default(Text("OK")))
            }
            
            if showingRegister {
                
                
                
            
            
            ButtonView(title:"회원가입",
                       background: .black,
                       foreground: .white,
                       border: .black){
                if handleDynamicLink(appDelegate.dynamicLink) {
                    
                    showingRegister.toggle()
                    showRegisteration.toggle()
                    
                }
              
            }.fullScreenCover(isPresented: $showRegisteration, content: {SignUpView()} )
            
            
            }
            
            
            
            
        }.padding()
    }
}

 struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
