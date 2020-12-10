//
//  ToDoBaseEditViewController.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 10.12.2020.
//

import UIKit

class ToDoBaseEditViewController: UIViewController {
    let CornerRadius: CGFloat = 6.0
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeKeyboardNotifications()
    }
    
    override func keyboardChangedFrame(_ frame: CGRect) {
        let bottomOffset = (frame.origin.y >= view.bounds.size.height) ? 0.0 : frame.height
        scrollView.contentInset.bottom = bottomOffset
        scrollView.verticalScrollIndicatorInsets.bottom = bottomOffset
    }
     
    func setupAppearance() {
        detailTextView.layer.cornerRadius = CornerRadius
    }
}
