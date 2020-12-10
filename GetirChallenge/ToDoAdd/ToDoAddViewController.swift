//
//  ToDoAddViewController.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import UIKit

private let CornerRadius: CGFloat = 6.0

class ToDoAddViewController: ToDoBaseEditViewController {
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var presenter: ToDoAddPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.attachView(self)
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        saveButton.layer.cornerRadius = CornerRadius
        cancelButton.layer.cornerRadius = CornerRadius
    }
    
    //MARK: - Actions
    @IBAction private func didTapSave() {
        //presenter save changes
        guard let title = titleTextField.text , !title.isEmpty, let details = detailTextView.text, !details.isEmpty else { return }
        let newItem = ToDoItemDto(id: UUID().uuidString, title: title, details: details, createdAt: Date().timeIntervalSince1970)
        presenter?.tapSaveItem(item: newItem)
    }
    
    @IBAction private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - ToDoAddViewProtocol
extension ToDoAddViewController: ToDoAddViewProtocol {
    func dismiss() {
        didTapCancel()
    }
}
