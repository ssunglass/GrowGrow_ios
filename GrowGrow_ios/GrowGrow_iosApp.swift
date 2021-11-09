//
//  GrowGrow_iosApp.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/21.
//

import SwiftUI
import Firebase

@main
struct GrowGrow_iosApp: App {
    
    
    @UIApplicationDelegateAdaptor(Appdelegate.self) var appDelegate
    
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(SessionStore())
            
          
            
        }
    }
}

class Appdelegate: NSObject, UIApplicationDelegate {
    
     var dynamicLink: DynamicLink?
    
    
   
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
    [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options:
                     [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if DynamicLinks.dynamicLinks().shouldHandleDynamicLink(fromCustomSchemeURL: url) {
            
            let isDynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url)
            
            dynamicLink = isDynamicLink
        
        }
        
      
      
     
      return false
    }
    
    
    
    
    
}
