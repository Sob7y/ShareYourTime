//
//  HomeViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit
import Parchment

class HomeViewController: PagingViewController<HomeItem> {

//    var controllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func loadView() {
      view = HomePageView(
        options: options,
        collectionView: collectionView,
        pageView: pageViewController.view
      )
    }
    
    func setupView() -> [UIViewController] {
        var controllers: [UIViewController] = []
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let whoIsOutView = storyboard.instantiateViewController(withIdentifier: "WhoIsOutViewController") as! WhoIsOutViewController
        let myPlanView = storyboard.instantiateViewController(withIdentifier: "MyPlanViewController") as! MyPlanViewController
        let exploreView = storyboard.instantiateViewController(withIdentifier: "ExploreViewController") as! ExploreViewController
        
        controllers.append(whoIsOutView)
        controllers.append(myPlanView)
        controllers.append(exploreView)
        
        return controllers
    }

}

extension HomeViewController: PagingViewControllerDataSource {
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        switch index {
        case 0:
            let whoIsOutView = storyboard.instantiateViewController(withIdentifier: "WhoIsOutViewController") as! WhoIsOutViewController
            return whoIsOutView
        case 1:
            let myPlanView = storyboard.instantiateViewController(withIdentifier: "MyPlanViewController") as! MyPlanViewController
            return myPlanView
        case 2:
            let exploreView = storyboard.instantiateViewController(withIdentifier: "ExploreViewController") as! ExploreViewController
            return exploreView
        default:
            return UIViewController()
        }
        //    let viewController = ImagesViewController(
        //      images: items[index].images,
        //      options: pagingViewController.options
        //    )
        
        // Set the `ImagesViewControllerDelegate` that allows us to get
        // notified when the images view controller scrolls.
        //    viewController.delegate = self
        
        //    // Inset the collection view with the height of the menu.
        //    let insets = UIEdgeInsets(top: menuHeight, left: 0, bottom: 0, right: 0)
        //    viewController.collectionView.contentInset = insets
        //    viewController.collectionView.scrollIndicatorInsets = insets
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
        return setupView()[index] as! T
    }
    
    func numberOfViewControllers<T>(in: PagingViewController<T>) -> Int{
        return 3
    }
    
}
