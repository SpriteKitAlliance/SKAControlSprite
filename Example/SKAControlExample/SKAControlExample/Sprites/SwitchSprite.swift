//
//  Switch.swift
//  SKASimpleButtonExample
//
//  Created by Marc Vandehey on 4/18/17.
//  Copyright © 2017 SpriteKit Alliance. All rights reserved.
//

import SpriteKit

class SwitchSprite: SKAControlSprite {
  private let swipeThreshold : CGFloat = 50
  private var startTouchPosition : CGPoint?

  private let foregroundSprite = SKSpriteNode(imageNamed: "thumb")
  private var trackedTouch : UITouch?

  init() {
    let texture = SKTexture(imageNamed: "switch-background")
    super.init(texture: texture, color: .green, size: texture.size())

    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    let texture = SKTexture(imageNamed: "switch-background")
    super.init(texture: texture, color: .green, size: texture.size())

    setup()
  }

  private func setup() {
    colorBlendFactor = 0

    addChild(foregroundSprite)

    foregroundSprite.position = getOffPosition()
    foregroundSprite.zPosition = 10
  }

  private let SWITCH_ON_ACTION = "switch-on-action"
  private let SWITCH_OFF_ACTION = "switch-off-action"

  override func updateControl() {
    if selected, action(forKey: SWITCH_ON_ACTION) == nil {
      removeAction(forKey: SWITCH_OFF_ACTION)
      foregroundSprite.removeAction(forKey: SWITCH_OFF_ACTION)

      run(SKAction.colorize(withColorBlendFactor: 1, duration: 0.25), withKey: SWITCH_ON_ACTION)
      foregroundSprite.run(SKAction.moveTo(x: getOnPosition().x, duration: 0.25), withKey: SWITCH_ON_ACTION)
    } else if !selected, action(forKey: SWITCH_OFF_ACTION) == nil {
      removeAction(forKey: SWITCH_ON_ACTION)
      foregroundSprite.removeAction(forKey: SWITCH_ON_ACTION)

      run(SKAction.colorize(withColorBlendFactor: 0, duration: 0.25), withKey: SWITCH_OFF_ACTION)
      foregroundSprite.run(SKAction.moveTo(x: getOffPosition().x, duration: 0.25), withKey: SWITCH_OFF_ACTION)
    }
  }

  private func getOffPosition() -> CGPoint {
    return CGPoint(x: -size.width / 2 + foregroundSprite.size.width / 2, y: 0)
  }

  private func getOnPosition() -> CGPoint {
    return CGPoint(x: size.width / 2 - foregroundSprite.size.width / 2, y: 0)
  }

  private func shouldToggleWithSwipe(currentPosition : CGPoint, startPosition : CGPoint) -> Bool {
    return abs(startPosition.x - position.x) > swipeThreshold
  }

  //Override tracking for custom gestures

  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    if trackedTouch == nil {
      trackedTouch = touch
      startTouchPosition = touch.location(in: self)

      return true
    }

    return false
  }

  override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    if touch.isEqual(trackedTouch), let startPosition = startTouchPosition {

      //Check if we moved to a position
      let position = touch.location(in: self)
      let triggerThreshold = shouldToggleWithSwipe(currentPosition: position, startPosition: startPosition)

      if triggerThreshold, selected, position.x < startPosition.x {
        selected = false

        startTouchPosition = position
      } else if triggerThreshold, !selected, position.x > startPosition.x {
        selected = true

        startTouchPosition = position
      }

      return true
    }

    return false
  }

  override func endTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    if touch.isEqual(trackedTouch) {
      trackedTouch = nil
      startTouchPosition = nil


      if let parent = parent, contains(touch.location(in: parent)) {
        //Touched up inside, lets trigger the action!
        selected = !selected
      }

      return true
    }

    return false
  }

  override func cancelTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    if touch.isEqual(trackedTouch) {
      trackedTouch = nil
      startTouchPosition = nil

      return true
    }

    return false
  }
}
