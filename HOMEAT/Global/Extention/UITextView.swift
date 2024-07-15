//
//  UITextView.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/16/24.
//

import UIKit

extension UITextView {

    private struct AssociatedKeys {
        static var placeholderLabel = "placeholderLabel"
    }
    
    private var placeholderLabel: UILabel? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.placeholderLabel) as? UILabel
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.placeholderLabel, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func setPlaceholder(_ placeholder: String, color: UIColor = .lightGray) {
        if placeholderLabel == nil {
            let label = UILabel()
            label.textColor = color
            label.numberOfLines = 0
            label.font = self.font
            self.addSubview(label)
            self.sendSubviewToBack(label)
            placeholderLabel = label
            
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(8)-[label]-(8)-|", options: [], metrics: nil, views: ["label": label]))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(8)-[label]", options: [], metrics: nil, views: ["label": label]))
            label.translatesAutoresizingMaskIntoConstraints = false
        }
        
        placeholderLabel?.text = placeholder
        placeholderLabel?.isHidden = !self.text.isEmpty
    }

    @objc func textViewDidChange(_ textView: UITextView) {
        placeholderLabel?.isHidden = !textView.text.isEmpty
    }
    
    @objc func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel?.isHidden = true
    }
    
    @objc func textViewDidEndEditing(_ textView: UITextView) {
        placeholderLabel?.isHidden = !textView.text.isEmpty
    }
    
    func setupPlaceholder() {
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidChange), name: UITextView.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidBeginEditing), name: UITextView.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidEndEditing), name: UITextView.textDidEndEditingNotification, object: nil)
    }
}

