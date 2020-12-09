//
//  ToDoDetailsViewController.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import UIKit

private let DetailsTitle = "Details"

class ToDoDetailsViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    var presenter: ToDoDetailsPresenterProtocol?
    
    var item: ToDoItemDto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        presenter?.attachView(self)
        detailTextView.layer.cornerRadius = 8.0
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
        //presenter save changes
        let updatetd = ToDoItemDto(title: titleTextField.text ?? "", details: detailTextView.text ?? "")
        presenter?.tapSaveItem(item: updatetd)
        setupViewMode()
    }
    
    @objc private func didTapCancelEdit() {
        populateInfo()
        setupViewMode()
    }
    
    //MARK: - Private
    
    private func populateInfo() {
        titleTextField.text = item?.title
        detailTextView.text = item?.details
    }
    
    private func setupNavigationBar() {
        self.title = DetailsTitle
        setupViewMode()
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
        populateInfo()
    }
}
