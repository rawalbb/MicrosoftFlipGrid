//
//  RegistrationFonts.swift
//  RawalFlipGrid
//
//  Created by Nirali Rawal on 10/22/21.
//

import UIKit

enum RegistrationFont{
    case appH1
    case appP1
    case appH2
    case appP2
    
    var font: UIFont{
        get{
            switch self{
            case .appH1:
                return .appH1
            case .appH2:
                return .appH2
            case .appP1:
                return .appP1
            case .appP2:
                return .appP2
            }
        }
    }
}

extension UIFont{
    static let appH1: UIFont = {
        let font = UIFont(name: "OpenSans-SemiBold", size: 32)!
        return UIFontMetrics.default.scaledFont(for: font)
    }()
    
    static let appH2: UIFont = {
        let font = UIFont(name: "OpenSans-SemiBold", size: 16)!
        return UIFontMetrics.default.scaledFont(for: font)
    }()
    
    static let appP1: UIFont = {
        let font = UIFont(name: "OpenSans-Light", size: 18)!
        return UIFontMetrics.default.scaledFont(for: font)
    }()
    
    static let appP2: UIFont = {
        let font = UIFont(name: "OpenSans-Light", size: 12)!
        return UIFontMetrics.default.scaledFont(for: font)
    }()
}

extension UITextField{
    var style: RegistrationFont?{
        get { return nil }
        set {
            font = newValue?.font
            adjustsFontForContentSizeCategory = true
        }
    }
}

extension TitleTextField{
    var style: RegistrationFont?{
        get { return nil }
        set {
            textField.style = newValue
            titleLabel.font = newValue?.font
        }
    }
}

extension UILabel{
    var style: RegistrationFont?{
        get { return nil }
        set{
            font = newValue?.font
            adjustsFontForContentSizeCategory = true
        }
    }
}
