//
//  ViewController.swift
//  Matviychuks' Project
//
//  Created by Andrey Matviychuk on 09.05.2021.
//

import UIKit

class CreateNewFilmController: UIViewController {
    var movie:Movie?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = label.font.withSize(20)
        return label
    }()
    
    private let nameField:UITextField = {
        let field = UITextField()
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 10
        field.layer.borderColor = UIColor.gray.cgColor
        
        return field
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "Type"
        label.font = label.font.withSize(20)
        return label
    }()
    
    
    private let genreField: UITextField = {
        let field = UITextField()
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 10
        field.layer.borderColor = UIColor.gray.cgColor
        return field
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "Year"
        label.font = label.font.withSize(20)
        return label
    }()
    
    private let yearField: UITextField = {
        let field = UITextField()
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 10
        field.layer.borderColor = UIColor.gray.cgColor
        field.keyboardType = .numberPad
        field.tag = 1
        return field
    }()
    
    private let button:UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        
        return button
    
    }()
    
    @objc func didTapAddButton() {
        nameField.resignFirstResponder()
        yearField.resignFirstResponder()
        genreField.resignFirstResponder()
        
        let title = nameField.text ?? ""
        let year = yearField.text ?? ""
        let type = genreField.text ?? ""
        
        movie = Movie(title: title, year: year, type: type)
       
        performSegue(withIdentifier: "unwindToList", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameField.delegate = self
        yearField.delegate = self
        genreField.delegate = self
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(nameField)
        scrollView.addSubview(genreLabel)
        scrollView.addSubview(genreField)
        scrollView.addSubview(yearLabel)
        scrollView.addSubview(yearField)
        scrollView.addSubview(button)
        registerNotifications()
        hideKeyboard()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        nameLabel.frame = CGRect(x: 40, y: 20, width: view.bounds.width - 80, height: 40)
        nameField.frame = CGRect(x: 40, y: nameLabel.frame.origin.y + nameLabel.frame.height + 5, width: scrollView.bounds.width - 80, height: 40)
        genreLabel.frame = CGRect(x: 40, y: nameField.frame.origin.y + nameField.frame.height + 10, width: scrollView.bounds.width - 80, height: 40)
        genreField.frame = CGRect(x: 40, y: genreLabel.frame.origin.y + genreLabel.frame.height + 5, width: scrollView.bounds.width - 80, height: 40)
        yearLabel.frame = CGRect(x: 40, y: genreField.frame.origin.y + genreField.frame.height + 10, width: scrollView.bounds.width - 80, height: 40)
        yearField.frame = CGRect(x: 40, y: yearLabel.frame.origin.y + yearLabel.frame.height + 5, width: scrollView.bounds.width - 80, height: 40)
        button.frame = CGRect(x: scrollView.bounds.width/2 - 20, y: yearField.frame.origin.y + yearField.frame.height + 10, width: 40, height: 30)
    }
    
}

extension CreateNewFilmController:UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !textField.text!.isEmpty {
            if(textField.tag == 1) {
                if(textField.text?.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil) {
                    textField.text = ""
                }
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CreateNewFilmController {
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + button.frame.maxY - self.tabBarController!.tabBar.frame.size.height, right: 0)
            scrollView.scrollIndicatorInsets = scrollView.contentInset
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
