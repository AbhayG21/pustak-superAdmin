//
//  DataModel.swift
//  pustak-superAdmin
//
//  Created by Abhay(IOS) on 02/06/24.
//

import Foundation

enum Role: String,Codable,CaseIterable
{
    case libraryAdmin = "Library Admin"
}

struct LibraryAdmin: Codable, Identifiable, Comparable{
    let id: UUID
    let name: String
    let email: String
    let personalEmail: String
    let phone: String
    let role: Role
    let libraries: [UUID]
    let librarians: [UUID]
    let timeStamp: Date
    
    static func < (lhs: LibraryAdmin, rhs: LibraryAdmin) -> Bool{
        return lhs.timeStamp <= rhs.timeStamp
    }
}
