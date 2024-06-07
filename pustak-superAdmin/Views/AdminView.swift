//
//  AdminView.swift
//  pustak-superAdmin
//
//  Created by Abhay(IOS) on 02/06/24.
//

import SwiftUI

struct ListItem: Identifiable {
    var id = UUID()
    var title: String
}
//struct AdminView: View {
////    @EnvironmentObject var admins = AdminManagers()
//    @State private var isShowingAddItemView = false
//    @State private var items: [ListItem] = [
//            ListItem(title: "Item 1"),
//            ListItem(title: "Item 2"),
//            ListItem(title: "Item 3")
//        ]
//    var body: some View {
//        NavigationStack{
//            List{
//                ForEach(items){item in
//                    Text(item.title)
//                }
//            }
//            .toolbar{
//                Button(action: {
//                    isShowingAddItemView = true
//                }){
//                    Image(systemName: "plus")
//                }
//            }
//        }
//        .sheet(isPresented: $isShowingAddItemView, content: {
//            AddAdminView()
//        })
//    }
//}

struct AdminView:View{
    @EnvironmentObject var admins: LibraryAdminManager
    @State private var isShowingAddItemView = false
    var body: some View {
        NavigationStack{
        if(admins.isLoading){
            ProgressView()
                .onAppear(perform: {
                    Task{
                        do{
                            try await admins.fetchUsers()
                        }
                        catch{}
                    }
                })
                .navigationTitle("Home")
                .toolbar{
                    Button(action: {
                        isShowingAddItemView = true
                    }){
                        Image(systemName: "plus")
                    }
                }
        }else{
                if(admins.admins.count == 0){
                    VStack (spacing: 12){
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .opacity(0.25)
                        Text("No data to display")
                            .fontDesign(.rounded)
                            .fontWeight(.medium)
                            .font(.title3)
                            .opacity(0.5)
                    }
                    .navigationTitle("Home")
                    .toolbar{
                        Button(action: {
                            isShowingAddItemView = true
                        }){
                            Image(systemName: "plus")
                        }
                    }
                }else{
                    List(admins.admins){admin in
                        HStack{
                            VStack(alignment: .leading, spacing: -4){
                                Text(admin.name)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .font(.title2)
                                Text(admin.email)
                                    .fontWeight(.regular)
                                    .fontDesign(.rounded)
                            }
                            Spacer()
                        }
                    }
                    .navigationTitle("Home")
                    .toolbar{
                        Button(action: {
                            isShowingAddItemView = true
                        }){
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingAddItemView, content: {
            AddAdminView()
        })

    }
}
#Preview {
    AdminView()
        .environmentObject(LibraryAdminManager())
}
