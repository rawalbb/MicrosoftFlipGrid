//
//  UIViewController+Extension.swift
//  RawalFlipGrid
//
//  Created by Bansri Rawal on 11/4/21.
//

import Foundation
import UIKit

extension UIViewController{
    func hideKeyboardWhenTappedAround(tapGestureDelegate delegate: UIGestureRecognizerDelegate? = nil){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        tap.delegate = delegate
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    static func instantiateViewController(storyBoard: String, withIdentifier identifier: String) -> UIViewController{
        let storyboard = UIStoryboard(name: storyBoard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    func createAndShowAlert(title: String, message: String, actionTitle: String, handler: ((UIAlertAction) -> Void)? = nil){
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: handler))
        
        self.present(alert, animated: true, completion: nil)
    }
}
