//
//  ViewController.swift
//  KeyboardSample
//
//  Created by Вячеслав on 14.12.2022.
//

import UIKit

class ViewController: UIViewController {

    private let imageWidth = 100.0
    private let imageHeight = 100.0
    private let imageTopMargin = 120.0
    private let imageBottomMargin = 120.0
    private let loginPasswordStackHeight = 100.0
    private let buttonHeight = 50.0
    private let defaultSideMargin = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(vkLogo)
        contentView.addSubview(inputFieldStackView)
        contentView.addSubview(logInButton)
        contentView.addSubview(signUpButton)
        inputFieldStackView.addArrangedSubview(loginInputTextField)
        inputFieldStackView.addArrangedSubview(passwordInputTextField)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            vkLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: imageTopMargin),
            vkLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vkLogo.widthAnchor.constraint(equalToConstant: imageWidth),
            vkLogo.heightAnchor.constraint(equalToConstant: imageHeight),
            
            inputFieldStackView.topAnchor.constraint(equalTo: vkLogo.bottomAnchor, constant: imageBottomMargin),
            inputFieldStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultSideMargin),
            inputFieldStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultSideMargin),
            inputFieldStackView.heightAnchor.constraint(equalToConstant: loginPasswordStackHeight),
            
            logInButton.topAnchor.constraint(equalTo: inputFieldStackView.bottomAnchor, constant: defaultSideMargin),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultSideMargin),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultSideMargin),
            logInButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            signUpButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -defaultSideMargin),
            signUpButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultSideMargin),
            signUpButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultSideMargin),
            signUpButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.willShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.willHideKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    
    @objc fileprivate func willShowKeyboard(_ notification: NSNotification) {
        //loginView.handleShowKeyboard(notification)
    }
    
    @objc fileprivate func willHideKeyboard(_ notification: NSNotification) {
        
    }
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private var vkLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vk_logo")!
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var loginInputTextField: UITextField = {
        let loginTextFileld = UITextField()
        loginTextFileld.backgroundColor = .systemGray6.withAlphaComponent(0.1)
        loginTextFileld.textColor = .black
        loginTextFileld.attributedPlaceholder = NSAttributedString(string: "Email or phone", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        loginTextFileld.font = .systemFont(ofSize: 16.0)
        loginTextFileld.tintColor = UIColor(named: "vkColor")
        loginTextFileld.autocapitalizationType = .none
        loginTextFileld.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        loginTextFileld.leftViewMode = .always
        loginTextFileld.layer.borderWidth = 0.5
        loginTextFileld.layer.borderColor = UIColor.lightGray.cgColor
        loginTextFileld.translatesAutoresizingMaskIntoConstraints = false
        //loginTextFileld.addTarget(self, action: #selector(loginOrPasswordTextChanged), for: .editingChanged)
        return loginTextFileld
    }()
    
    private var passwordInputTextField: UITextField = {
        let passwordTextFileld = UITextField()
        passwordTextFileld.backgroundColor = .systemGray6.withAlphaComponent(0.1)
        passwordTextFileld.textColor = .black
        passwordTextFileld.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        passwordTextFileld.font = .systemFont(ofSize: 16.0)
        passwordTextFileld.tintColor = UIColor(named: "vkColor")
        passwordTextFileld.autocapitalizationType = .none
        passwordTextFileld.isSecureTextEntry = true
        passwordTextFileld.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        passwordTextFileld.leftViewMode = .always
        passwordTextFileld.translatesAutoresizingMaskIntoConstraints = false
        //passwordTextFileld.addTarget(self, action: #selector(loginOrPasswordTextChanged), for: .editingChanged)
        return passwordTextFileld
    }()
    
    private var inputFieldStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.layer.cornerRadius = 10
        stack.layer.borderWidth = 0.5
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.spacing = 0.5
        stack.clipsToBounds = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.backgroundColor = UIColor.init(named: "vkColor")
        button.layer.cornerRadius = 10
//        button.addTarget(nil, action: #selector(buttonLogInAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Want join us? Sign up!", for: .normal)
        
        button.setTitleColor(UIColor.init(named: "vkColor"), for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.layer.cornerRadius = 10
//        button.addTarget(nil, action: #selector(buttonSignUpAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


}

