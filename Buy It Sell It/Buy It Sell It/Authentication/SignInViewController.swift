//
//  SignInViewController.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 2.01.2018.
//  Copyright © 2018 Asil Arslan. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    var delegate : AuthenticationDelegate!
    
    @IBOutlet var buttonSignIn: UIButton!
    
    @IBOutlet var textFieldEmail: UITextField!
    @IBOutlet var textFieldPassword: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        
//        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
//        
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
        
        
        buttonSignIn.layer.masksToBounds = true
        buttonSignIn.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 5)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate.cancel()
    }
    
    @IBAction func btnSignInTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        // Hide the navigation bar for current view controller
//        self.navigationController?.isNavigationBarHidden = true;
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        // Show the navigation bar on other view controllers
//        self.navigationController?.isNavigationBarHidden = false;
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
