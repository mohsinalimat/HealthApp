import UIKit
import SCLAlertView
import FirebaseAuth

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showRegisterVC", sender: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if email?.isEmail != nil, password?.isPassword != nil {
            AuthService.shared.login(email: email!, password: password!, onComplete: {
                (message, data) in
                guard message == nil else {
                    SCLAlertView().showError("Error", subTitle: NSLocalizedString("login.alert.mailError", comment: ""))
                    return
                }
                self.performSegue(withIdentifier: "showMainPageVC", sender: nil)
            })
        } else {
            SCLAlertView().showError("Error", subTitle: NSLocalizedString("login.alert.dataError", comment: ""))
        }
    }
    
    @IBAction func forgotButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, email.isEmail {
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if error != nil {
                    SCLAlertView().showError("Error", subTitle: NSLocalizedString("login.alert.forgotPasswordError", comment: ""))
                    print("Error => \(error.debugDescription)")
                    return
                } else {
                    SCLAlertView().showSuccess(NSLocalizedString("login.alert.title.mailSent", comment: ""), subTitle: NSLocalizedString("login.alert.mailSent", comment: ""))
                }
            }
        } else {
            SCLAlertView().showError("Error", subTitle: NSLocalizedString("login.alert.mailError", comment: ""))
        }
    }
    
}
