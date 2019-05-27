//
//  AdImagesHeaderView.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 31.12.2017.
//  Copyright © 2017 Asil Arslan. All rights reserved.
//

import UIKit

class AdImagesHeaderView: UIView {

    @IBOutlet weak var pageControl: UIPageControl!

}

extension AdImagesHeaderView : AdImagesPageViewControllerDelegate
{
    func setupPageController(numberOfPages: Int)
    {
        pageControl.numberOfPages = numberOfPages
    }

    func turnPageController(to index: Int)
    {
        pageControl.currentPage = index
    }
}

