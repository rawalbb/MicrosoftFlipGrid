//
//  TitleTextField.swift
//  RawalFlipGrid
//
//  Created by Nirali Rawal on 10/22/21.
//

import UIKit

protocol TitleTextFieldDelegate: class {
    func textFieldDidBeginEditing(_ titleTextField: TitleTextField)
    func textFieldDidEndEditing(_ titleTextField: TitleTextField)

    func textFieldShouldReturn(_ titleTextField: TitleTextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    
    func textField(_ titleTextField: TitleTextField, shouldChangeCharactersIn
                    range: NSRange, replacementString string: String) -> Bool

    func textFieldShouldClear(_ titleTextField: TitleTextField) -> Bool
}

extension TitleTextFieldDelegate {
    func textFieldDidBeginEditing(_ titleTextField: TitleTextField) {}
    func textFieldDidEndEditing(_ titleTextField: TitleTextField) {}
    func textFieldShouldReturn(_ titleTextField: TitleTextField) -> Bool {
        return true
    }

    func textField(_ titleTextField: TitleTextField, shouldChangeCharactersIn
                    range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    func textFieldShouldClear(_ titleTextField: TitleTextField) -> Bool {
        return true
    }

}

@IBDesignable
class TitleTextField: UIView {
    
    weak var delegate: TitleTextFieldDelegate?
    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var titleLabelBottomConstraint: NSLayoutConstraint!
    
    @IBInspectable open var text: String? {
        get { return textField.text }
        set { textField.text = newValue
            if (newValue != nil) {
                self.titleLabelBottomConstraint.constant = 0
            } else {
                self.titleLabelBottomConstraint.constant = self.textField.bounds.size.height / 2 + self.titleLabel.bounds.height / 2
            }
            titleLabel.textColor = (newValue != nil) ? UIColor.blue : UIColor.gray
            titleLabel.font = (newValue != nil) ? titleFont : textField.font
        }
    }
    
    @IBInspectable open var placeholder: String = "" {
        didSet {
            titleLabel.text = placeholder
            titleLabelBottomConstraint.constant = self.textField.bounds.size.height / 2 + self.titleLabel.bounds.height / 2
            textField.accessibilityLabel = placeholder
        }
    }
    
    @IBInspectable open var titleFont: UIFont = .systemFont(ofSize: 12)

    
    open var keyboardType: UIKeyboardType {
        get { return textField.keyboardType }
        set { textField.keyboardType = newValue }
    }
    open var autocorrectionType: UITextAutocorrectionType {
        get { return textField.autocorrectionType }
        set { textField.autocorrectionType = newValue }
    }
    open var autocapitalizationType: UITextAutocapitalizationType {
        get { return textField.autocapitalizationType }
        set { textField.autocapitalizationType = newValue }
    }
    open var textContentType: UITextContentType {
        get { return textField.textContentType }
        set { textField.textContentType = newValue }
    }

    open var returnKeyType: UIReturnKeyType {
        get { return textField.returnKeyType }
        set { textField.returnKeyType = newValue }
    }
      
    var isEnabled: Bool {
        get {return textField.isEnabled }
        set { return textField.isEnabled = newValue }
    }

    
    private var isEditing: Bool {
        get {
            textField.isEditing
        }
        set {
          
            guard let textStr = textField.text, textStr.isEmpty else { return }
            
            titleLabel.textColor = newValue ? UIColor.blue : UIColor.gray
            titleLabel.font = newValue ? titleFont : textField.font
            
            UIView.animate(withDuration:0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                if newValue {
                    self.titleLabelBottomConstraint.constant = 0
                } else {
                    self.titleLabelBottomConstraint.constant = self.textField.bounds.size.height / 2 + self.titleLabel.bounds.height / 2
                }
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewfromNib()
    }
    
    // called when creating via storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewfromNib()
        setupView()
    }

    func loadViewfromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        self.view = view
        
        isAccessibilityElement = false
        accessibilityElements = [textField as Any]
    }

    func setupView() {
        textField.delegate = self
        
        titleLabel.text = placeholder
        textField.placeholder = ""

        
        titleLabel.textColor = UIColor.gray
        self.titleLabelBottomConstraint.constant = self.textField.bounds.size.height / 2 + self.titleLabel.bounds.height / 2
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        let height = titleFont.lineHeight + textField.bounds.height
        return CGSize(width: self.bounds.width, height: height)
    }
    
    @discardableResult override func becomeFirstResponder() -> Bool {
        textField.becomeFirstResponder()
    }
    
    override var accessibilityIdentifier: String? {
        get {
            return textField.accessibilityIdentifier
        }
        set {
            textField.accessibilityIdentifier = newValue
        }
    }
    
    override var accessibilityLabel: String? {
        get {
            return textField.accessibilityLabel
        }
        set {
            textField.accessibilityLabel = newValue
        }
    }
}


extension TitleTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isEditing = true
        delegate?.textFieldDidBeginEditing(self)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        isEditing = false
        delegate?.textFieldDidEndEditing(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldReturn(self) ?? true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn
                    range: NSRange, replacementString string: String) -> Bool {
        return delegate?.textField(self, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldClear(self) ?? true
    }
}
