//
//  pustak_superAdminApp.swift
//  pustak-superAdmin
//
//  Created by Abhay(IOS) on 01/06/24.
//

import SwiftUI

@main
struct pustak_superAdminApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var sessionManager = SessionManager()
    var body: some Scene {
        WindowGroup {
            ContentView().onChange(of: scenePhase){
                switch scenePhase{
                case .background:
                    UserDefaults.standard.set("",forKey: "token")
                    sessionManager.isAuthenticated = false
                    sessionManager.token = ""
                    break;
                default:
                    break;
                }
            }
                .environmentObject(sessionManager)
        }
    }
}
