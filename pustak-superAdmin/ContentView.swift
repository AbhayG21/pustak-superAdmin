//
//  ContentView.swift
//  pustak-superAdmin
//
//  Created by Abhay(IOS) on 01/06/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var networkManager = AuthenticationNetwork()
    @StateObject var createAdmin = LibraryAdminManager()
    @EnvironmentObject var sessionManager: SessionManager
    var body: some View {
        if(!sessionManager.isAuthenticated && sessionManager.token.isEmpty){
                    loginView()
                        .environmentObject(networkManager)
                }else{
                    SuperAdminMainView()
                        .environmentObject(createAdmin)
                }
    }
}

//#Preview {
//    ContentView()
//}
