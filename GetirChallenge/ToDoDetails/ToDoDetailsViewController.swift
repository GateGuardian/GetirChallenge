//
//  ToDoDetailsViewController.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import UIKit

private let DetailsTitle = "Details"

class ToDoDetailsViewController: ToDoBaseEditViewController {
    var presenter: ToDoDetailsPresenterProtocol?
    var item: ToDoItemDto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = DetailsTitle
        setupViewMode()
        presenter?.attachView(self)
    }
    
    //MARK: - Actions
    @objc private func didTapAdd() {
        presenter?.tapAddItem()
    }
    
    @objc private func didTapDelete() {
        presenter?.tapDeleteItem()
    }
    
    @objc private func didTapEdit() {
        setupEditMode()
    }
    
    @objc private func didTapSave() {
        guard let title = titleTextField.text, let details = detailTextView.text else { return }
        presenter?.tapSaveItem(title: title, details: details)
        setupViewMode()
    }
    
    @objc private func didTapCancelEdit() {
        populateItemInfo()
        setupViewMode()
    }
    
    //MARK: - Private
    private func populateItemInfo() {
        titleTextField.text = item?.title
        detailTextView.text = item?.details
    }
    
    private func setupViewMode() {
        titleTextField.isUserInteractionEnabled = false
        detailTextView.isUserInteractionEnabled = false
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEdit))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
        navigationItem.rightBarButtonItems = [editButton, deleteButton, addButton]
    }
    
    private func setupEditMode() {
        titleTextField.isUserInteractionEnabled = true
        titleTextField.becomeFirstResponder()
        detailTextView.isUserInteractionEnabled = true
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
        let cancelBUtton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelEdit))
        navigationItem.rightBarButtonItems = [saveButton, cancelBUtton]
    }
}

//MARK: - ToDoDetailsViewProtocol
extension ToDoDetailsViewController: ToDoDetailsViewProtocol {
    func populateWith(item: ToDoItemDto) {
        self.item = item
        populateItemInfo()
    }
}
