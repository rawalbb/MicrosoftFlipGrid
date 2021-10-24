//
//  ViewController.swift
//  RawalFlipGrid
//
//  Created by Nirali Rawal on 10/22/21.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var headerSubLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var firstNameField: TitleTextField!

    
    @IBOutlet weak var emailField: TitleTextField!
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var passwordField: TitleTextField!
    
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    
    @IBOutlet weak var websiteField: TitleTextField!
    
    
    @IBOutlet weak var registerButton: UIButton!
    
    var activeField: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView(){
        
        
        headerLabel.style = .appH1
        headerSubLabel.style = .appP1
        
        registerforKeyboardNotification()
        hideKeyboardWhenTappedAround(tapGestureDelegate: self)
        
        firstNameField.style = .appH2
        emailField.style = .appH2
        passwordField.style = .appH2
        websiteField.style = .appH2
        
        firstNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        websiteField.delegate = self
        
        
        
        
        emailErrorLabel.style = .appP2
        passwordErrorLabel.style = .appP2
        emailErrorLabel.textColor = UIColor.red
        passwordErrorLabel.textColor = UIColor.red
        
        emailErrorLabel.text = ""
        passwordErrorLabel.text = ""
        
        firstNameField.textContentType = .name
        firstNameField.keyboardType = .asciiCapable
        firstNameField.autocapitalizationType = .words
        firstNameField.autocorrectionType = .no
        firstNameField.returnKeyType = .next
        
        emailField.textContentType = .emailAddress
        emailField.keyboardType = .emailAddress
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.returnKeyType = .next
        
        passwordField.textContentType = .name
        //passwordField.textField.passwordRules = UITextInputPasswordRules(descriptor: "required: upper; required: lower; required: digit; required: special; minlength: 12")
        passwordField.autocapitalizationType = .none
        passwordField.returnKeyType = .next
        //passwordField.textField.isSecureTextEntry = true
        
        websiteField.textContentType = .name
        websiteField.keyboardType = .asciiCapable
        websiteField.autocapitalizationType = .none
        websiteField.autocorrectionType = .no
        websiteField.returnKeyType = .done
        
        firstNameField.layer.borderColor = UIColor.gray.cgColor
        emailField.layer.borderColor = UIColor.gray.cgColor
        passwordField.layer.borderColor = UIColor.gray.cgColor
        websiteField.layer.borderColor = UIColor.gray.cgColor
        
        firstNameField.layer.borderWidth = 1.0
        emailField.layer.borderWidth = 1.0
        passwordField.layer.borderWidth = 1.0
        websiteField.layer.borderWidth = 1.0
        
        firstNameField.layer.cornerRadius = 12.0
        emailField.layer.cornerRadius = 12.0
        passwordField.layer.cornerRadius = 12.0
        websiteField.layer.cornerRadius = 12.0
        
        registerButton.layer.cornerRadius = 12
    }
    
    @IBAction func requestAccountClick(_ sender: Any){
        _ = validate(inputField: emailField, textStr: emailField.text ?? "")
        _ = validate(inputField: passwordField, textStr: passwordField.text ?? "")
        
        guard let email = emailField.text, !email.isEmpty else  {
            createAndShowAlert(title: "Invalid Email", message: "Please enter email address", actionTitle: "OK") { _ in
                self.emailField.becomeFirstResponder()
            }
            return
        }
        
        guard email.validateEmail() else {
            createAndShowAlert(title: "Invalid Email", message: "The email you entered is not valid. Please enter a valid email address and try again.", actionTitle: "OK") { _ in
                self.emailField.becomeFirstResponder()
            }
            return
        }
        
        guard let password = passwordField.text, !password.isEmpty else  {
            createAndShowAlert(title: "Invalid Password", message: "Please enter password", actionTitle: "OK") { _ in
                self.emailField.becomeFirstResponder()
            }
            return
        }
        
        guard email.validatePassword() else {
            createAndShowAlert(title: "Invalid Password", message: "The password you entered is not valid. Please enter a valid password and try again.", actionTitle: "OK") { _ in
                self.emailField.becomeFirstResponder()
            }
            return
        }
    }
    
    func createAndShowAlert(title: String, message: String, actionTitle: String, handler: ((UIAlertAction) -> Void)? = nil){
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: handler))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func validate(inputField: UIView, textStr: String) -> Bool{
        var errorStr: String? = nil
        switch inputField{
        case emailField:
            if textStr.isEmpty{
                errorStr = "Email is required"
            }
            else if !textStr.validateEmail(){
                errorStr = "Invalid Email"
            }
            else{
                errorStr = nil
            }
        case passwordField:
            if textStr.isEmpty{
                errorStr = "Password is required"
            }
            else if !textStr.validatePassword(){
                errorStr = "Invalid Password"
            }
            else{
                errorStr = nil
            }
        default:
            errorStr = nil
        }
        
        displayFieldError(inputField: inputField, errorStr: errorStr)
        return true
    }
    
    func displayFieldError(inputField: UIView, errorStr: String?){
        let errorLabel: UILabel?
        
        switch inputField{
        case emailField:
            errorLabel = emailErrorLabel
        case passwordField:
            errorLabel = passwordErrorLabel
        default:
            errorLabel = nil
        }
        
        guard let fieldErrorLabel = errorLabel else { return }
        if let errorStr = errorStr, !errorStr.isEmpty{
            fieldErrorLabel.text = errorStr
        }
        else{
            fieldErrorLabel.text = ""
        }
    }


    func sendRegistrationRequest(name: String?, email: String, password: String, website: String?){
        
        let request = RegistrationRequest(firstName: name, emailAddress: email, password: password, website: website)
        
    }
    
}
extension RegistrationViewController {
    private func registerforKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let adjustmentHeight = show ? (keyboardFrame.cgRectValue.height + 20) : 0
        scrollView.contentInset.bottom = adjustmentHeight
        scrollView.verticalScrollIndicatorInsets.bottom = adjustmentHeight
        
        if show, let activeField = activeField, let parentView = activeField.superview {
            let activeRect = parentView.convert(parentView.bounds, to: scrollView)
            scrollView.scrollRectToVisible(activeRect, animated: false)
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustInsetForKeyboardShow(true, notification: notification)
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustInsetForKeyboardShow(false, notification: notification)
    }
}

extension RegistrationViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !(touch.view is UIButton)
    }
}

extension RegistrationViewController: TitleTextFieldDelegate {
    func textFieldDidBeginEditing(_ titleTextField: TitleTextField) {
        activeField = titleTextField
    }
    
    func textFieldDidEndEditing(_ titleTextField: TitleTextField) {
        activeField = nil
        _ = validate(inputField: titleTextField, textStr: titleTextField.text ?? "")
    }

    func textFieldShouldReturn(_ titleTextField: TitleTextField) -> Bool {
        switch titleTextField {
        case firstNameField:
            emailField.becomeFirstResponder()
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            websiteField.becomeFirstResponder()
        case websiteField:
            websiteField.textField.resignFirstResponder()
            //self.requestAccountButtonTapped(titleTextField)
        default:
            print("Default")
//            textField.resignFirstResponder()
        }
        
        return false
    }
    
    func textField(_ titleTextField: TitleTextField, shouldChangeCharactersIn
                    range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = titleTextField.textField.text, let textRange = Range(range, in: currentText) else {
            return true
        }
        
        let updatedText = currentText.replacingCharacters(in: textRange, with: string)
        
        switch titleTextField{
        case emailField:
            return validate(inputField: titleTextField, textStr: updatedText)
        case passwordField:
            return validate(inputField: titleTextField, textStr: updatedText)
        default:
            return true
        }
        
        
    }
    
    func textFieldShouldClear(_ titleTextField: TitleTextField) -> Bool {
        _ = validate(inputField: titleTextField, textStr: "")
        return true
    }

}


extension String{
    func validateEmail() -> Bool{
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
        }
    
    
    func validatePassword() -> Bool{
        let charLengthRegex = "^.{12,}$"
        let specCharRegex = "^.*([!@#%*?&$^]).*$"
        let upperCharRegex = "^(.*[A-Z].*)$"
        
//        let lowerCharRegex = "^(.*[a-z].*)$"
//        let numRegex = "^(.*[0-9].*)$"
        let charValidator = NSPredicate(format: "SELF MATCHES %@", charLengthRegex).evaluate(with: self)
        let specCharValidator = NSPredicate(format: "SELF MATCHES %@", specCharRegex).evaluate(with: self)
//        let upperCharValidator = NSPredicate(format: "SELF MATCHES %@", upperCharRegex).evaluate(with: self)
//        let lowerCharValidator = NSPredicate(format: "SELF MATCHES %@", lowerCharRegex).evaluate(with: self)
//        let numValidator = NSPredicate(format: "SELF MATCHES %@", numRegex).evaluate(with: self)
        
        return charValidator && specCharValidator
        //&& upperCharValidator && lowerCharValidator && numValidator
    }
}


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
}
