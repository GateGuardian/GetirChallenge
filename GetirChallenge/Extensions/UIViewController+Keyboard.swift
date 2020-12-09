//
//  UIViewController+Keyboard.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import UIKit

private enum KeyboardAction: Int {
    case willShow = 1
    case frameChange = 2
    case willHide = 3
}

extension UIViewController {
    
    //MARK: Public
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func addKeyBoardDissmissRecognizer(toView: UIView? = nil) {
        let tapper = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard(_:)))
        if let view = toView {
            view.addGestureRecognizer(tapper)
        } else {
            view.addGestureRecognizer(tapper)
        }
    }
    
    //Overrides
    
    @objc func keyboardWillAppearWithFrame(_ frame: CGRect) {
        
    }
    
    @objc func keyboardChangedFrame(_ frame: CGRect) {
        
    }
    
    @objc func keyboardWillHideWithFrame(_ frame: CGRect) {
        
    }
    
    //MARK: Private
    
    @objc private func hideKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        animateWithFromParams(notification.userInfo as! [String : AnyObject], keyboardAction: .willShow)
    }
    
    @objc private func keyboardWillChangeFrame(notification: Notification) {
        animateWithFromParams(notification.userInfo as! [String : AnyObject], keyboardAction: .frameChange)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        animateWithFromParams(notification.userInfo as! [String : AnyObject], keyboardAction: .willHide)
    }
    
    private func animateWithFromParams(_ params: [String: AnyObject], keyboardAction: KeyboardAction) {
        let keyboardRect: CGRect = (params[UIResponder.keyboardFrameEndUserInfoKey]?.cgRectValue)!
        let duration = params[UIResponder.keyboardAnimationDurationUserInfoKey]?.doubleValue ?? 0.0
        let rawCurve: Int = (params[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber).intValue
        UIView.animate(withDuration: duration, delay: 0.0, options: [UIView.AnimationOptions(rawValue: UInt(rawCurve))], animations: {
            switch keyboardAction {
            case .willShow:
                self.keyboardWillAppearWithFrame(keyboardRect)
            case .willHide:
                self.keyboardWillHideWithFrame(keyboardRect)
            case .frameChange:
                self.keyboardChangedFrame(keyboardRect)
            }
        }, completion: nil)
    }
}

