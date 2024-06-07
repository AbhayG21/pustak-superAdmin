//
//  SuperAdminMainView.swift
//  pustak-superAdmin
//
//  Created by Abhay(IOS) on 02/06/24.
//

import SwiftUI

struct SuperAdminMainView: View {
    @EnvironmentObject var admins: LibraryAdminManager
    var body: some View {
        TabView
        {
            AdminView().tabItem {
                Label(
                    title: { Text("Admins") },
                    icon: { Image(systemName: "person.3.fill") }
                )
            }
            ProfileView().tabItem { Label(
                title: { Text("Profile") },
                icon: { Image(systemName: "person.crop.circle") }
            ) }
        }
        .onAppear(perform: {
            admins.isLoading = true
        })
    }
}

//#Preview {
//    SuperAdminMainView()
//}
