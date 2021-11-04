//
//  ModelHelpers.swift
//  RawalFlipGrid
//
//  Created by Bansri Rawal on 10/23/21.
//

import Foundation

struct RegistrationRequest: Codable{
    var firstName: String?
    var emailAddress: String
    var password: String
    var website: String?
}

struct ConfirmationData{
    
    let email: String
    let name: String?
    let website: String?
}
