//
//  MenuScene.swift
//  SKAControlExample
//
//  Created by Marc Vandehey on 4/20/17.
//  Copyright © 2017 SpriteKit Alliance. All rights reserved.
//

import SpriteKit

class MenuScene : SKScene {

  override func didMove(to view: SKView) {
    let controlTestButton = TwoPaneButton(size: CGSize(width: frame.size.width * 0.75, height: 50))
    controlTestButton.setup(text: "Control Test!", fontSize: 30, autoResize: false)
    controlTestButton.position = CGPoint(x: frame.midX, y: frame.midY + 75)
    controlTestButton.addTarget(self, selector: #selector(navigateToControlTest(_:)), forControlEvents: .TouchUpInside)

    addChild(controlTestButton)

    let sliderFunButton = TwoPaneButton(size: CGSize(width: frame.size.width * 0.75, height: 50))
    sliderFunButton.setup(text: "Slider Fun!", fontSize: 30, autoResize: false)
    sliderFunButton.position = CGPoint(x: frame.midX, y: frame.midY)
    sliderFunButton.addTarget(self, selector: #selector(navigateToSliderFun(_:)), forControlEvents: .TouchUpInside)

    addChild(sliderFunButton)

    let cannonTestButton = TwoPaneButton(size: CGSize(width: frame.size.width * 0.75, height: 50))
    cannonTestButton.setup(text: "SKA Test!", fontSize: 30, autoResize: false)
    cannonTestButton.position = CGPoint(x: frame.midX, y: frame.midY - 75)
    cannonTestButton.addTarget(self, selector: #selector(navigateToSKATest(_:)), forControlEvents: .TouchUpInside)

    addChild(cannonTestButton)
  }

  func navigateToSliderFun(_ button : TwoPaneButton) {
    let scene = SliderFunScene()
    scene.size = size
    let reveal = SKTransition.reveal(with: .left, duration: 1)

    view?.presentScene(scene, transition: reveal)
  }

  func navigateToControlTest(_ : TextButtonSprite) {
    let scene = ControlTestScene()
    scene.size = size
    let reveal = SKTransition.reveal(with: .left, duration: 1)

    view?.presentScene(scene, transition: reveal)
  }

  func navigateToSKATest(_ : TextButtonSprite) {
    let scene = SKATestScene()
    scene.size = size
    let reveal = SKTransition.reveal(with: .left, duration: 1)

    view?.presentScene(scene, transition: reveal)
  }

  deinit {
    print("Menu destroyed")
  }
}
