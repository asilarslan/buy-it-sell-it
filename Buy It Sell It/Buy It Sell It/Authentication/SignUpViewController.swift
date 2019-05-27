//
//  SignUpViewController.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 16.09.2018.
//  Copyright © 2018 Asil Arslan. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var buttonSignUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSignUp.layer.masksToBounds = true
        buttonSignUp.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 5)

    }
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func signInTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
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
