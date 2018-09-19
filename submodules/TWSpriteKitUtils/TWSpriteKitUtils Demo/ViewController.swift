//
//  ViewController.swift
//  TWSpriteKitUtils Demo
//
//  Created by Txai Wieser on 9/17/15.
//  Copyright © 2015 Txai Wieser. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true

        if (view as? SKView)?.scene != nil {
            view.subviews.first?.removeFromSuperview()
        }
    }
}
