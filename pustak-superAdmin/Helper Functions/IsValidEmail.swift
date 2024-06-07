//
//  IsValidEmail.swift
//  pustak-superAdmin
//
//  Created by Abhay(IOS) on 02/06/24.
//

import Foundation

func isValidEmail(_ email: String) -> Bool{
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    let boolVal = emailPredicate.evaluate(with: email)
    
    return boolVal
}
