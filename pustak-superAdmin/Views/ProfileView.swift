//
//  ProfileView.swift
//  pustak-superAdmin
//
//  Created by Abhay(IOS) on 02/06/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var sessionManager: SessionManager
    var body: some View {
        Button(action: {
            sessionManager.token = ""
            sessionManager.isAuthenticated = false
        }, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        })
    }
}

#Preview {
    ProfileView()
}
