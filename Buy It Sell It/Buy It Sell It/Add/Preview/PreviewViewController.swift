//
//  PreviewViewController.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 20.01.2018.
//  Copyright © 2018 Asil Arslan. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var adImagesHeaderView: AdImagesHeaderView!
    var ad : Ad!
    
    struct Storyboard {
        static let showImagesPageVC = "PreviewImagesPageViewController"
        static let adDetailCell = "AdDetailCell"
        static let productDetailCell = "AdDetailsCell"
        static let buyButtonCell = "MessageButtonCell"
        static let callButtonCell = "CallButtonCell"
        static let messageAndCallButtonCell = "MessageAndCallButtonCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Önizleme"
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.showImagesPageVC {
            if let imagesPageVC = segue.destination as? AdImagesViewController {
                                imagesPageVC.images = ad.images!
//                imagesPageVC.imageUrls = ad.imageUrls!
                imagesPageVC.pageViewControllerDelegate = adImagesHeaderView
            }
        }
    }
    
    @IBAction func btnPublishTapped(_ sender: Any) {
        // create the alert
        let alert = UIAlertController(title: "İlanı Yayınla", message: "İlan yayınlanacaktır devam etmek istiyor musunuz?", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Evet", style: UIAlertActionStyle.default, handler: { action in
            
            self.navigationController?.popToRootViewController(animated: true)
            
        }))
        alert.addAction(UIAlertAction(title: "Hayır", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 0 - shoe detail cell
        // 1 - buy button
        // 2 - shoe full details button cell
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.adDetailCell, for: indexPath) as! AdDetailTableViewCell
            cell.adNameLabel.text = ad.name
            cell.adDescriptionLabel.text = ad.adDescription
            cell.selectionStyle = .none
            
            return cell
        } else if indexPath.row == 1 {
            if ad.contactType == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.buyButtonCell, for: indexPath)
                cell.selectionStyle = .none
                return cell
            }else if ad.contactType == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.callButtonCell, for: indexPath)
                cell.selectionStyle = .none
                return cell
            }else if ad.contactType == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.messageAndCallButtonCell, for: indexPath)
                cell.selectionStyle = .none
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.buyButtonCell, for: indexPath)
                cell.selectionStyle = .none
                return cell
            }
            
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.productDetailCell, for: indexPath)
            cell.selectionStyle = .none
            return cell
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
