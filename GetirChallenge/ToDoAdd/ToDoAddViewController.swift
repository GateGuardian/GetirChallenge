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
        guard let title = titleTextField.text, let details = detailTextView.text else { return }
        presenter?.tapSaveItem(title: title, details: details)
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
    
    func showAlert(for error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
