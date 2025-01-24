//
//  LoginVC.swift
//  MintynTask
//
//  Created by Inyene on 1/13/25.
//

import UIKit


class LoginViewController: UIViewController {
    private var isChecked = false
    private lazy var loginView = LoginView()
    private lazy var pageViewController: GridPageViewController = {
        let controller = GridPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        return controller
    }()
    
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewController()
        setupDelegates()
        setupActions()
        setupKeyboardHandling()
    }
    
    private func setupChildViewController() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: loginView.navigationBar.bottomAnchor, constant: 20),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.heightAnchor.constraint(equalToConstant: 200),
            loginView.formContainer.topAnchor.constraint(equalTo: pageViewController.view.bottomAnchor, constant: 32)
        ])
    }
    
    private func setupDelegates() {
        loginView.phoneNumberField.delegate = self
        loginView.passwordField.delegate = self
    }
    
    private func setupActions() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.passwordVisibilityButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        loginView.rememberMeCheckbox.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
    }
    
    private func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func validateFields() {
        let phoneNumber = loginView.phoneNumberField.text ?? ""
        let password = loginView.passwordField.text ?? ""
        
        if phoneNumber.count == 10 && password.count >= 8 {
            loginView.loginButton.isEnabled = true
            loginView.loginButton.backgroundColor = UIColor(red: 0.91, green: 0.69, blue: 0.24, alpha: 1.0)
        } else {
            loginView.loginButton.isEnabled = false
            loginView.loginButton.backgroundColor = UIColor.gray
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.height
        let adjustableOffset: CGFloat = keyboardHeight / 3
        
        UIView.animate(withDuration: 0.3) {
            self.view.transform = CGAffineTransform(translationX: 0, y: -adjustableOffset)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.transform = .identity
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func loginButtonTapped() {
        let phoneNumber = loginView.phoneNumberField.text ?? ""
        let password = loginView.passwordField.text ?? ""
        
        if phoneNumber.count == 10 && password.count >= 8 {
            navigateToMainTabBar()
        } else {
            showInvalidCredentialsAlert()
        }
    }
    
    private func navigateToMainTabBar() {
        let mainTabBarController = MainTabBarController()
        navigationItem.hidesBackButton = true
        navigationController?.pushViewController(mainTabBarController, animated: true)
        
    }
    
    private func showInvalidCredentialsAlert() {
        let alert = UIAlertController(
            title: "Invalid Credentials",
            message: "Please check your phone number or password",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func togglePasswordVisibility() {
        loginView.passwordField.isSecureTextEntry.toggle()
        let imageName = loginView.passwordField.isSecureTextEntry ? "eye.slash" : "eye"
        loginView.passwordVisibilityButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @objc private func checkboxTapped() {
        loginView.rememberMeCheckbox.isSelected.toggle()
        isChecked = loginView.rememberMeCheckbox.isSelected
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        validateFields()
        
        
        if textField == loginView.phoneNumberField {
            guard let currentText = textField.text else { return true }
            let newLength = currentText.count + string.count - range.length
            
            // Only allow numbers
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            let isNumber = allowedCharacters.isSuperset(of: characterSet) || string.isEmpty
            
            
            if let firstChar = string.first, newLength == 1 && firstChar == "0" {
                return false
            }
            
            return isNumber && newLength <= 10
        }
        
        return true
    }
}

#Preview {
    LoginViewController()
}





class LoginView: UIView {
    
    let navigationBar: UINavigationBar = {
        let nav = UINavigationBar()
        nav.barStyle = .black
        nav.tintColor = .white
        nav.setBackgroundImage(UIImage(), for: .default)
        nav.shadowImage = UIImage()
        nav.backgroundColor = .clear
        return nav
    }()
    
    
    let phoneNumberTitle: UILabel = createTitleLabel(text: "Phone Number")
    let passwordTitle: UILabel = createTitleLabel(text: "Password")
    
    let phoneNumberField: UITextField = {
        let field = createTextField(placeholder: " 80334455445")
        field.keyboardType = .numberPad
        
        let flagImageView = UIImageView(image: UIImage(systemName: "flag")?.withTintColor(.white, renderingMode: .alwaysOriginal))
        flagImageView.contentMode = .scaleAspectFit
        
        let leftContainer = UIView(frame: CGRect(x: 0, y: 0, width: 95, height: 56))
        flagImageView.frame = CGRect(x: 16, y: 16, width: 24, height: 24)
        
        let prefixLabel = UILabel(frame: CGRect(x: 48, y: 0, width: 50, height: 56))
        prefixLabel.text = "+234"
        prefixLabel.textColor = .white
        prefixLabel.font = .systemFont(ofSize: 17, weight: .bold)
        
        leftContainer.addSubview(flagImageView)
        leftContainer.addSubview(prefixLabel)
        
        field.leftView = leftContainer
        field.leftViewMode = .always
        return field
    }()
    
    let passwordField: UITextField = {
        let field = createTextField(placeholder: "********")
        field.isSecureTextEntry = true
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        field.leftViewMode = .always
        return field
    }()
    
    lazy var passwordVisibilityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .white
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return button
    }()
    
    let rememberMeCheckbox: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 4
        button.setImage(UIImage(systemName: "checkmark")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .selected)
        return button
    }()
    
    let rememberMeLabel: UILabel = {
        let label = UILabel()
        label.text = "Remember me"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(UIColor(red: 0.91, green: 0.69, blue: 0.24, alpha: 1.0), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 12
        button.isEnabled = false
        return button
    }()
    
    let registerDeviceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register new device", for: .normal)
        button.setTitleColor(UIColor(red: 0.91, green: 0.69, blue: 0.24, alpha: 1.0), for: .normal)
        return button
    }()
    
    let poweredByLabel: UILabel = {
        let label = UILabel()
        label.text = "Powered by FINEX MFB"
        label.textColor = .gray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "Version 1.3.94"
        label.textColor = .gray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let formContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.08, alpha: 1.0)
        view.layer.cornerRadius = 30
        return view
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        backgroundColor = .black
        setupViews()
        setupConstraints()
        setupPasswordVisibility()
    }
    
    private func setupViews() {
        [navigationBar, formContainer].forEach { addSubview($0) }
        setupFormContainer()
    }
    
    private func setupFormContainer() {
        [phoneNumberTitle, phoneNumberField,
         passwordTitle, passwordField,
         rememberMeCheckbox, rememberMeLabel,
         forgotPasswordButton, loginButton,
         registerDeviceButton, poweredByLabel,
         versionLabel].forEach { formContainer.addSubview($0) }
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        passwordVisibilityButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        containerView.addSubview(passwordVisibilityButton)
        passwordField.rightView = containerView
        passwordField.rightViewMode = .always
    }
    
    private func setupPasswordVisibility() {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        passwordVisibilityButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        containerView.addSubview(passwordVisibilityButton)
        passwordField.rightView = containerView
        passwordField.rightViewMode = .always
    }
    
    private func setupConstraints() {
        makeViewsTranslatesAutoresizingMaskIntoConstraints()
        setupFormContainerConstraints()
        setupNavigationBarConstraints()

    }
    
    private func makeViewsTranslatesAutoresizingMaskIntoConstraints() {
        [navigationBar, phoneNumberTitle, phoneNumberField,
         passwordTitle, passwordField, rememberMeCheckbox,
         rememberMeLabel, forgotPasswordButton, loginButton,
         registerDeviceButton, poweredByLabel, formContainer,
         versionLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setupFormContainerConstraints() {
        NSLayoutConstraint.activate([
            formContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            formContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            formContainer.bottomAnchor.constraint(equalTo: bottomAnchor),

            
            phoneNumberTitle.topAnchor.constraint(equalTo: formContainer.topAnchor, constant: 24),
            phoneNumberTitle.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor, constant: 16),
            
            phoneNumberField.topAnchor.constraint(equalTo: phoneNumberTitle.bottomAnchor, constant: 8),
            phoneNumberField.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor, constant: 16),
            phoneNumberField.trailingAnchor.constraint(equalTo: formContainer.trailingAnchor, constant: -16),
            phoneNumberField.heightAnchor.constraint(equalToConstant: 56),
            
            passwordTitle.topAnchor.constraint(equalTo: phoneNumberField.bottomAnchor, constant: 16),
            passwordTitle.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor, constant: 16),
            
            passwordField.topAnchor.constraint(equalTo: passwordTitle.bottomAnchor, constant: 8),
            passwordField.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor, constant: 16),
            passwordField.trailingAnchor.constraint(equalTo: formContainer.trailingAnchor, constant: -16),
            passwordField.heightAnchor.constraint(equalToConstant: 56),
            
            rememberMeCheckbox.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            rememberMeCheckbox.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor, constant: 16),
            rememberMeCheckbox.heightAnchor.constraint(equalToConstant: 24),
            rememberMeCheckbox.widthAnchor.constraint(equalToConstant: 24),
            
            rememberMeLabel.centerYAnchor.constraint(equalTo: rememberMeCheckbox.centerYAnchor),
            rememberMeLabel.leadingAnchor.constraint(equalTo: rememberMeCheckbox.trailingAnchor, constant: 8),
            
            forgotPasswordButton.centerYAnchor.constraint(equalTo: rememberMeCheckbox.centerYAnchor),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: formContainer.trailingAnchor, constant: -16),
            
            loginButton.topAnchor.constraint(equalTo: rememberMeCheckbox.bottomAnchor, constant: 54),
            loginButton.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: formContainer.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 56),
            
            registerDeviceButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 45),
            registerDeviceButton.centerXAnchor.constraint(equalTo: formContainer.centerXAnchor),
            
            poweredByLabel.topAnchor.constraint(equalTo: registerDeviceButton.bottomAnchor, constant: 10),
            poweredByLabel.centerXAnchor.constraint(equalTo: formContainer.centerXAnchor),
            
            versionLabel.topAnchor.constraint(equalTo: poweredByLabel.bottomAnchor, constant: 8),
            versionLabel.centerXAnchor.constraint(equalTo: formContainer.centerXAnchor),
            versionLabel.bottomAnchor.constraint(equalTo: formContainer.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupNavigationBarConstraints() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: - Helper Methods
    private static func createTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }
    
    private static func createTextField(placeholder: String) -> UITextField {
        let field = UITextField()
        field.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        field.textColor = .white
        field.layer.cornerRadius = 12
        field.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.6),
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)
            ]
        )
        return field
    }
}



class WelcomeTextView: UIView {
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(welcomeLabel)
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}



