//
//  loginView.swift
//  pustak-superAdmin
//
//  Created by Abhay(IOS) on 01/06/24.
//

import SwiftUI

struct loginView: View {
    @EnvironmentObject var networkManage: AuthenticationNetwork
    @EnvironmentObject var sessionManager: SessionManager
    @State private var showingLogoutAlert = false
    @State private var navigateToInitialView: Bool? = false
    @State private var key:String = ""
    @State private var isPresented: Bool = false
    @State private var isWrong:Bool = false
    
   
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack{
                    ZStack{
                        Circle()
                            .fill(.customToggleText)
                            .frame(width: 150, height: 150)
                        
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)
                    }
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("Welcome Super Admin")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding()
                    
                    VStack(alignment:.leading){
                        SecureField("Key", text: $key)
                            .padding(12)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(.separator), lineWidth: 1)
                            )
                    }
                    .padding(.horizontal,12)
                    
                    VStack
                    {
                        Button(action: {
                            networkManage.isLoading = true
                            
                            Task{
                                do{
                                    try await networkManage.validateSuperAdmin(with: key)
                                    DispatchQueue.main.async{
                                        if(networkManage.isError == true)
                                        {
                                            isPresented = true
                                            key = ""
//                                            isWrong = true
                                        }
                                        else{
                                            guard let token = UserDefaults.standard.object(forKey: "token") as? String else {return}
                                                                                   
                                            sessionManager.token = token
                                            
//                                            isWrong = false  
                                            sessionManager.isAuthenticated = true
                                            
                                        }
                                    }
                                }
                                catch{}
                            }
                        }, label: {
                            if(networkManage.isLoading == true)
                            {
                                ProgressView()
                            }
                            else
                            {
                                
                                Text("Proceed")
                                    .frame(maxWidth: .infinity)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background((isBtnDisabled() || networkManage.isLoading) ? Color.gray : Color.customToggleText)
                                    .cornerRadius(20)
                            }
                        })
                        .padding(.horizontal,12)
                        .disabled(isBtnDisabled() || networkManage.isLoading)
                    }
                    .padding(.top,20)
                    
//                    Text("Wrong Key")
//                        .foregroundStyle(Color.red)
//                        .opacity(isWrong ? 1 : 0)
                }
                .padding(.top,12)
            }
            .scrollIndicators(.hidden)
        }
    }
    func isBtnDisabled() -> Bool{
        return key.isEmpty || key.count < 4
    }

}

//
//#Preview {
//    loginView()
//}
