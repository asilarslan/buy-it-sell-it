//
//  AdImagesViewController.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 31.12.2017.
//  Copyright © 2017 Asil Arslan. All rights reserved.
//

import UIKit

import SDWebImage

protocol AdImagesPageViewControllerDelegate: class
{
    func setupPageController(numberOfPages: Int)
    func turnPageController(to index: Int)
}

class AdImagesViewController: UIPageViewController {

    var images = [UIImage]()
    var imageUrls = [String]()
    
    weak var pageViewControllerDelegate: AdImagesPageViewControllerDelegate?
    
    struct Storyboard {
        static let shoeImageViewController = "AdImageViewController"
    }
    
    lazy var controllers: [UIViewController] = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var controllers = [UIViewController]()
        
        
        for image in images {
            
            let adImageVC = storyboard.instantiateViewController(withIdentifier: Storyboard.shoeImageViewController) as! AdImageViewController
            adImageVC.image = image
            controllers.append(adImageVC)
            
        }
        
        for image in imageUrls {
            
            let adImageVC = storyboard.instantiateViewController(withIdentifier: Storyboard.shoeImageViewController) as! AdImageViewController
            adImageVC.imageUrl = image
            //            adImageVC.imageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "placeholder.png"))
            controllers.append(adImageVC)
            
        }
        
        self.pageViewControllerDelegate?.setupPageController(numberOfPages: controllers.count)
        
        return controllers
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        
        if images.count > 1 || imageUrls.count > 1{
                        dataSource = self
                        delegate = self
        }
        
        self.turnToPage(index: 0)
    }
    
    func turnToPage(index: Int)
    {
        let controller = controllers[index]
        var direction = UIPageViewControllerNavigationDirection.forward
        
        if let currentVC = viewControllers?.first {
            let currentIndex = controllers.index(of: currentVC)!
            if currentIndex > index {
                direction = .reverse
            }
        }
        
        self.configureDisplaying(viewController: controller)
        
        setViewControllers([controller], direction: direction, animated: true, completion: nil)
    }
    
    func configureDisplaying(viewController: UIViewController)
    {
        for (index, vc) in controllers.enumerated() {
            if viewController === vc {
                if let adImageVC = viewController as? AdImageViewController {
//                    if self.images.count > 0 {
//                        adImageVC.image = self.images[index]
//                    }
//                    if self.imageUrls.count > 0 {
//                        adImageVC.imageUrl = self.imageUrls[index]
//                    }
                    self.pageViewControllerDelegate?.turnPageController(to: index)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension AdImagesViewController : UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        if let index = controllers.index(of: viewController) {
            if index > 0 {
                return controllers[index-1]
            }
        }
        
        return controllers.last
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        if let index = controllers.index(of: viewController) {
            if index < controllers.count - 1 {
                return controllers[index + 1]
            }
        }
        
        return controllers.first
    }
}

extension AdImagesViewController : UIPageViewControllerDelegate
{
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController])
    {
        self.configureDisplaying(viewController: pendingViewControllers.first as! AdImageViewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
    {
        if !completed {
            self.configureDisplaying(viewController: previousViewControllers.first as! AdImageViewController)
        }
    }
}



