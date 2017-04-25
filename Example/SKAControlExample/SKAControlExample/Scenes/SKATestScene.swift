//
//  SKATestScene.swift
//  SKAControlExample
//
//  Created by Marc Vandehey on 4/24/17.
//  Copyright © 2017 SpriteKit Alliance. All rights reserved.
//

import SpriteKit

class SKATestScene : SKScene {

  var leftCannon = [SKASprite]()
  var rightCannon = [SKASprite]()

  override func didMove(to view: SKView) {
    let backButton = TextButtonSprite()

    backButton.setup(text: "BACK", fontSize: 15, autoResize: false)
    backButton.size = CGSize(width: 70, height: 44)
    backButton.color = .black
    backButton.position = CGPoint(x: backButton.size.width / 2 + 10, y: size.height - backButton.size.height / 2 - 10)

    backButton.addTarget(self, selector: #selector(backButtonPressed(_:)), forControlEvents: .TouchUpInside)
    backButton.zPosition = 1000
    addChild(backButton)

    let button = TwoPaneButton(size: CGSize(width: size.width * 0.85, height: 75))
    button.setup(text: "Press Me!", fontSize: 35, autoResize: false)
    button.addTarget(self, selector: #selector(fireCannons(_:)), forControlEvents: .TouchUpInside)
    button.position = view.center

    addChild(button)

    setupSKACannon()
  }

  private func setupSKACannon() {
    for i in 0...30 {
      let spriteLeft = SKASprite()
      let spriteRight = SKASprite()

      spriteLeft.zPosition = 100
      spriteRight.zPosition = 100

      spriteLeft.setScale(0.25)
      spriteRight.setScale(0.25)

      spriteLeft.physicsBody = SKPhysicsBody(circleOfRadius: spriteLeft.size.width / 2)
      spriteRight.physicsBody = SKPhysicsBody(circleOfRadius: spriteRight.size.width / 2)

      spriteLeft.physicsBody?.mass = CGFloat(i) * 2
      spriteLeft.physicsBody?.density = 1

      spriteRight.physicsBody?.mass = CGFloat(i) * 2
      spriteRight.physicsBody?.density = 1

      spriteLeft.playActionForState(state: .Dance)
      spriteRight.playActionForState(state: .Dance)

      leftCannon.append(spriteLeft)
      rightCannon.append(spriteRight)

      addChild(spriteLeft)
      addChild(spriteRight)
    }
  }

  func fireCannons(_ button : AlphaButton) {
    for leftSprite in leftCannon {
      leftSprite.position = CGPoint(x: -leftSprite.size.width, y: 0)

      leftSprite.color = SKColor(red: randomNumber(), green: randomNumber(), blue: randomNumber(), alpha: 1)

      leftSprite.physicsBody?.angularVelocity = 0
      leftSprite.physicsBody?.velocity = CGVector()
      leftSprite.zRotation = 0

      leftSprite.physicsBody?.applyForce(CGVector(dx: 5000, dy: 7000))
      leftSprite.physicsBody?.applyAngularImpulse(0.1)
    }

    for rightSprite in rightCannon {
      rightSprite.position = CGPoint(x: size.width  + rightSprite.size.width, y: 0)

      rightSprite.color = SKColor(red: randomNumber(), green: randomNumber(), blue: randomNumber(), alpha: 1)

      rightSprite.physicsBody?.angularVelocity = 0
      rightSprite.physicsBody?.velocity = CGVector()
      rightSprite.zRotation = 0

      rightSprite.physicsBody?.applyForce(CGVector(dx: -5000, dy: 7000))
      rightSprite.physicsBody?.applyAngularImpulse(0.1)
    }
  }

  func backButtonPressed(_ : TextButtonSprite) {
    let scene = MenuScene()
    scene.size = size
    let reveal = SKTransition.reveal(with: .right, duration: 1)

    view?.presentScene(scene, transition: reveal)
  }

  private func randomNumber() -> CGFloat {
    return CGFloat(arc4random() % 255) / 255.0
  }

  deinit {
    print("SKATest Scene destroyed")
  }
}
