//
//  ContainerViewController.swift
//  squadup
//
//  Created by Kelvin Yu on 10/28/20.
//

import UIKit

class ContainerViewController: UIViewController {
    var menuController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gamesController = GamesViewController()
        gamesController.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func configureMenuController()
    {
        if menuController == nil
        {
            menuController = MenuViewController()
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            print("here")
        }
    }
}

extension ContainerViewController: GamesViewControllerDelegate
{
    func handleMenuToggle()
    {
        configureMenuController()
    }
}
