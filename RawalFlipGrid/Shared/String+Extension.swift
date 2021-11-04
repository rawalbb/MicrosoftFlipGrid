//
//  String+Extension.swift
//  RawalFlipGrid
//
//  Created by Bansri Rawal on 11/4/21.
//

import Foundation

extension String{
    func validateEmail() -> Bool{
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
        }
    
    
    func validatePassword() -> Bool{
        let charLengthRegex = "^.{12,}$"
        let specCharRegex = "^.*([!@#%*?&$^]).*$"
        let upperCharRegex = "^(.*[A-Z].*)$"
        let lowerCharRegex = "^(.*[a-z].*)$"
        let numRegex = "^(.*[0-9].*)$"
        
        let charValidator = NSPredicate(format: "SELF MATCHES %@", charLengthRegex).evaluate(with: self)
        let specCharValidator = NSPredicate(format: "SELF MATCHES %@", specCharRegex).evaluate(with: self)
        let upperCharValidator = NSPredicate(format: "SELF MATCHES %@", upperCharRegex).evaluate(with: self)
        let lowerCharValidator = NSPredicate(format: "SELF MATCHES %@", lowerCharRegex).evaluate(with: self)
        let numValidator = NSPredicate(format: "SELF MATCHES %@", numRegex).evaluate(with: self)
        
        return charValidator && specCharValidator
        && upperCharValidator && lowerCharValidator && numValidator
    }
}
