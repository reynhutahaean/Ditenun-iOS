//
//  RegisterViewController.swift
//  DiTenun
//
//  Created by Reynaldo Cristinus Hutahaean on 11/07/20.
//  Copyright © 2020 Reynaldo Cristinus Hutahaean. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var deksripsiLabel: UILabel!
    
    @IBOutlet weak var namaTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var noHpTextField: UITextField!
    @IBOutlet weak var alamatTextField: UITextField!
    @IBOutlet weak var jenisTextField: UITextField!
    
    @IBOutlet weak var signUp: UIButton!
    var jenisTenun = ["Ragihotang", "Suri-Suri"]
    var pickerView = UIPickerView()
    
    var networkingService = NetworkingService()
    var alertService = AlertService()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImage.image = #imageLiteral(resourceName: "DITENUN")
        deksripsiLabel.text = "Daftar sekarang untuk dapat melihat motif nusantara, membuat motif dan kristik"
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        jenisTextField.inputView = pickerView
        signUp.layer.cornerRadius = 10
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return jenisTenun.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return jenisTenun[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        jenisTextField.text = jenisTenun[row]
        jenisTextField.resignFirstResponder()
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        guard
            let name = namaTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let no_hp = noHpTextField.text,
            let alamat = alamatTextField.text,
            let jenis_tenun = jenisTextField.text
            
            else {
                return
        }
        
        formDataRequest(name: name, email: email, password: password, no_hp: no_hp, alamat: alamat, jenis_tenun: jenis_tenun)
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        
        self.performSegue(withIdentifier: "cancelSegue", sender: self)
        
    }
    
    func formDataRequest(name: String, email: String, password: String, no_hp: String, alamat: String, jenis_tenun: String) {
        
        let parameters = ["name": name, "email": email, "password": password, "no_hp": no_hp, "alamat": alamat, "jenis_tenun": jenis_tenun]
        
        networkingService.requestRegister(endpoint: "api/register", parameters: parameters) { [weak self] (result) in
            
            switch result {
                
            case.success(let user): self?.performSegue(withIdentifier: "signUpSuccessSegue", sender: user)
                
            case.failure(let error):
                guard let alert = self?.alertService.alertRegister(message: error.localizedDescription) else {
                    return }
                self?.present(alert, animated: true)
            }
            
        }
    }
}
