//
//  MainViewController.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 20.01.2018.
//  Copyright © 2018 Asil Arslan. All rights reserved.
//

import UIKit

protocol AuthenticationDelegate {
    func cancel()
}

class MainViewController: UITabBarController, UITabBarControllerDelegate,AuthenticationDelegate {
    
    var lastSelectedIndex : Int = 0
    
    func cancel() {
        _ = self.selectedIndex = lastSelectedIndex
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    
    // UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected item")
        
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 2 || tabBarController.selectedIndex == 3 {
            if Authentication.isLogin(){
                print("true")
            }else{
                let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc : SignInViewController = mainStoryboard.instantiateViewController(withIdentifier: "vcMainLogin") as! SignInViewController
                vc.delegate = self
                self.present(vc, animated: true, completion: nil)
//
//                let vc = SignInViewController(
//                    nibName: "vcMainLogin",
//                    bundle: nil)
//                navigationController?.pushViewController(vc,
//                                                         animated: true)
                print("false")
            }
            print("Selected view controller")
        }else{
            lastSelectedIndex = tabBarController.selectedIndex
        }
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
