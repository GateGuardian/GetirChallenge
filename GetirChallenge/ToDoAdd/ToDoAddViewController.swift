//
//  ToDoAddViewController.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import UIKit

private let CornerRadius: CGFloat = 6.0

class ToDoAddViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var presenter: ToDoAddPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        presenter?.attachView(self)
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
    
    //MARK: - Actions
    @IBAction private func didTapSave() {
        //presenter save changes
        guard let title = titleTextField.text , !title.isEmpty, let details = detailTextView.text, !details.isEmpty else { return }
        let newItem = ToDoItemDto(id: UUID().uuidString, title: title, details: details)
        presenter?.tapSaveItem(item: newItem)
    }
    
    @IBAction private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Private
    private func setupAppearance() {
        saveButton.layer.cornerRadius = CornerRadius
        cancelButton.layer.cornerRadius = CornerRadius
        detailTextView.layer.cornerRadius = CornerRadius
    }
}

//MARK: - ToDoAddViewProtocol
extension ToDoAddViewController: ToDoAddViewProtocol {
    func dismiss() {
        didTapCancel()
    }
}
