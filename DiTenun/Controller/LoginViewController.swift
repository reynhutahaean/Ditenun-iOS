//
//  LoginViewController.swift
//  DiTenun
//
//  Created by Reynaldo Cristinus Hutahaean on 08/07/20.
//  Copyright © 2020 Reynaldo Cristinus Hutahaean. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var networkService = NetworkingService()
    var alertService = AlertService()
    
    var activeField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        loginBtn.layer.cornerRadius = 10
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        
        view.frame.origin.y = -100
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        
        view.frame.origin.y = 0
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text
            else {
                return
        }

        formDataRequest(email: email, password: password)

        if (emailTextField.text?.isEmpty ?? true && passwordTextField.text?.isEmpty ?? true) {
            let alert = self.alertService.empty(message: "Email atau Password tidak boleh kosong")
            self.present(alert, animated: true)
        }
//        self.performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
    func formDataRequest(email: String, password: String) {
        
        let parameters = ["username": email, "password": password]
        
        networkService.request(endpoint: "api/login", parameters: parameters) { [weak self] (result) in
            
            switch result {
                
            case.success(let user): self?.performSegue(withIdentifier: "loginSegue", sender: user)
                
            case.failure(let error):
                guard let alert = self?.alertService.alert(message: error.localizedDescription) else {
                    return }
                self?.present(alert, animated: true)
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let mainVC = segue.destination as? HomeController,
            let users = sender as? Users {
            //mainVC.use
        }
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "signUpSegue", sender: self)
    }
}
