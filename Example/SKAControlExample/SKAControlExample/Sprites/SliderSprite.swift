//
//  SliderSprite.swift
//  SKASimpleButtonExample
//
//  Created by Marc Vandehey on 4/19/17.
//  Copyright © 2017 SpriteKit Alliance. All rights reserved.
//

import SpriteKit

class SliderSprite : SKAControlSprite {
  private let thumbSprite = SKSpriteNode(imageNamed: "thumb")
  private var trackedTouch : UITouch?

  private var backgroundSprite : SKSpriteNode!
  private var foregroundSprite : SKSpriteNode!

  init() {
    super.init(texture: nil, color: .clear, size: CGSize(width: 300, height: 50))

    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(texture: nil, color: .clear, size: CGSize(width: 300, height: 50))

    setup()
  }

  override var value : CGFloat {
    set {
      var clampedValue = min(newValue, 1.0)
      clampedValue = max(clampedValue, 0.0)

      super.value = clampedValue

      thumbSprite.position.x = -size.width / 2 + (size.width * clampedValue)
      foregroundSprite.size.width = size.width * clampedValue
    }
    get {
      return super.value
    }
  }

  override var zPosition: CGFloat {
    didSet {
      backgroundSprite.zPosition = zPosition + 1
      foregroundSprite.zPosition = zPosition + 2
      thumbSprite.zPosition = zPosition + 3
    }
  }

  var foregroundColor : SKColor {
    set {
      foregroundSprite.color = newValue
    }
    get {
      return foregroundSprite.color
    }
  }

  var backgroundColor : SKColor {
    set {
      backgroundSprite.color = newValue
    }
    get {
      return backgroundSprite.color
    }
  }

  private func setup() {
    backgroundSprite = SKSpriteNode(color: .white, size: CGSize(width: size.width, height: 10))
    foregroundSprite = SKSpriteNode(color: .green, size: backgroundSprite.size)

    //Set the position and anchorPoint of the foreground sprite to align with the left of the parent
    foregroundSprite.position = CGPoint(x: -size.width / 2, y: 0)
    foregroundSprite.anchorPoint = CGPoint(x: 0, y: 0.5)

    backgroundSprite.zPosition = 0
    foregroundSprite.zPosition = 1
    thumbSprite.zPosition = 2

    addChild(backgroundSprite)
    addChild(foregroundSprite)
    addChild(thumbSprite)

    updateValue(xPosition: 0.5)
  }

  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    if trackedTouch == nil {
      trackedTouch = touch
      updateValue(xPosition: touch.location(in: self).x)

      return true
    }

    return false
  }

  override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    if touch.isEqual(trackedTouch) {
      updateValue(xPosition: touch.location(in: self).x)
      return true
    }

    return false
  }

  override func endTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    if touch.isEqual(trackedTouch) {
      trackedTouch = nil
      updateValue(xPosition: touch.location(in: self).x)

      return true
    }

    return false
  }

  override func cancelTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    if touch.isEqual(trackedTouch) {
      trackedTouch = nil
      updateValue(xPosition: touch.location(in: self).x)

      return true
    }

    return false
  }

  private func updateValue(xPosition : CGFloat) {
    value = (size.width / 2 + xPosition) / size.width
  }
}
