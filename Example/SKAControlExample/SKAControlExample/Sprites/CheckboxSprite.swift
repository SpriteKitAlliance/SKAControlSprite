//
//  CheckBox.swift
//  SKASimpleButtonExample
//
//  Created by Marc Vandehey on 4/18/17.
//  Copyright © 2017 SpriteKit Alliance. All rights reserved.
//

import SpriteKit

/**
 Example Usage:
 
 let checkboxButton = CheckBoxSprite()
 checkboxButton.addTarget(self, selector: #selector(checkBoxChanged(_:)), forControlEvents: .ValueChanged)
 addChild(checkboxButton)
 
 .
 .
 .

 func checkBoxChanged(_ checkbox : CheckBoxSprite) {
   //Do something here!
 }

 */

class CheckBoxSprite : SKAControlSprite {
  private let checkSprite = SKSpriteNode(imageNamed: "checkbox-checked")

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    setupCheckBox()
  }

  init() {
    let texture = SKTexture(imageNamed: "checkbox-background")
    super.init(texture: texture, color: SKColor.clear, size: texture.size())

    setupCheckBox()
  }

  func setupCheckBox() {
    addChild(checkSprite)

    checkSprite.zPosition = 10
    checkSprite.alpha = 0

    addTarget(self, selector: #selector(checkboxClicked(_:)), forControlEvents: .TouchUpInside)
  }

  private let CHECKBOX_ANIMATION_KEY = "checkbox-animation-key"

  override func updateControl() {
    if controlState.contains(.Disabled) {
      run(SKAction.fadeAlpha(to: 0.5, duration: 0.25))
    } else if controlState.contains(.Selected) {
      checkSprite.removeAction(forKey: CHECKBOX_ANIMATION_KEY)
      //Show selected state
      
      let rotateAnimation = SKAction.rotate(toAngle: CGFloat.pi * 2.0, duration: 0.25)
      checkSprite.run(SKAction.group([rotateAnimation, SKAction.fadeIn(withDuration: 0.25)]), withKey: CHECKBOX_ANIMATION_KEY)
    } else if controlState.contains(.Normal) {
      //Show unselected state

      let rotateAnimation = SKAction.rotate(toAngle: -CGFloat.pi * 2.0, duration: 0.25)
      checkSprite.removeAction(forKey: CHECKBOX_ANIMATION_KEY)
      checkSprite.run(SKAction.group([rotateAnimation, SKAction.fadeOut(withDuration: 0.25)]), withKey: CHECKBOX_ANIMATION_KEY)
    }
  }

  func checkboxClicked(_ checkbox: AnyObject) {
    selected = !selected
  }
}
