//
//  GameViewController.swift
//  SKAControlExample
//
//  Created by Marc Vandehey on 4/20/17.
//  Copyright © 2017 SpriteKit Alliance. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    if let view = self.view as! SKView? {
      let scene = MenuScene()
      scene.size = view.bounds.size
      scene.scaleMode = .aspectFill

      // Present the scene
      view.presentScene(scene)

      view.ignoresSiblingOrder = true
      view.showsFPS = true
      view.showsNodeCount = true
    }
  }

  override var shouldAutorotate: Bool {
    return true
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }

  override var prefersStatusBarHidden: Bool {
    return true
    }
}
