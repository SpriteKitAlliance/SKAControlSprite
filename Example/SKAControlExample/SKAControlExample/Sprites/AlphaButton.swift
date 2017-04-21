//
//  AlphaButton.swift
//  SKASimpleButtonExample
//
//  Created by Marc Vandehey on 4/18/17.
//  Copyright © 2017 SpriteKit Alliance. All rights reserved.
//

import SpriteKit

class AlphaButton : SKAControlSprite {
  override func updateControl() {
    if controlState.contains(.Disabled) {
      run(SKAction.fadeAlpha(to: 0.4, duration: 0.25))
    } else if controlState.contains(.Highlighted) {
      run(SKAction.fadeAlpha(to: 0.6, duration: 0.25))
    } else if controlState.contains(.Normal) {
      run(SKAction.fadeAlpha(to: 1, duration: 0.25))
    }
  }
}
