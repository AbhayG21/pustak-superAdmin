//
//  AddAdminView.swift
//  pustak-superAdmin
//
//  Created by Abhay(IOS) on 02/06/24.
//

import SwiftUI

struct AddAdminView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name:String  = ""
    @State private var personalEmail:String  = ""
    @State private var phone:String  = ""
    @State private var loginEmail:String  = ""
    @EnvironmentObject var adminNetwork: LibraryAdminManager
    private func isAddDisabled()->Bool{
        return name.isEmpty || personalEmail.isEmpty || phone.isEmpty || loginEmail.isEmpty
    }
    var body: some View {
        NavigationStack{
            Form{
                Section("Admin")
                {
                    TextField("Full Name",text:$name)
                    TextField("Personal Email",text:$personalEmail)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    TextField("Phone number",text:$phone)
                        .keyboardType(.numberPad)
                }
                Section("Credentials")
                {
                    TextField("Email",text:$loginEmail)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading)
                {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
                ToolbarItem(placement: .topBarTrailing)
                {
                    Button(action:{
                        let lAdm = LibraryAdmin(id: UUID(), name: name, email: loginEmail, personalEmail: personalEmail, phone: phone, role: .libraryAdmin, libraries: [], librarians: [], timeStamp: Date())
                        Task{
                            do{
                                try await adminNetwork.createAdmin(with: lAdm)
                                DispatchQueue.main.async{
                                    name = ""
                                    personalEmail = ""
                                    loginEmail = ""
                                    phone = ""
                                }
                            }
                            catch{}
                        }
                        dismiss()
                    },label: {
                        Text("Add")
                    })
                    .disabled(isAddDisabled())
                }
            }
        }
        
    }
}

#Preview {
    AddAdminView()
}
