//
//  TwoPaneButton.swift
//  SKASimpleButtonExample
//
//  Created by Marc Vandehey on 4/18/17.
//  Copyright © 2017 SpriteKit Alliance. All rights reserved.
//

import SpriteKit

class TwoPaneButton : SKAControlSprite {
  private var foregroundPane : SKSpriteNode!
  private var backgroundPane : SKSpriteNode!
  private var label : SKLabelNode!
  private var zeroPosition = CGPoint.zero

  var fontName = "Avenir-Black"

  init(size : CGSize) {
    super.init(texture: nil, color: .clear, size: size)

    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    setup()
  }

  override var zPosition: CGFloat {
    didSet {
        foregroundPane.zPosition = zPosition + 1
        label.zPosition = zPosition + 2
    }
  }

  override var size: CGSize {
    didSet {
      updateLayout()
    }
  }

  var elevation : CGFloat = 10 {
    didSet {
      updateLayout()
    }
  }

  var foregroundColor : SKColor {
    get {
      return foregroundPane.color
    }

    set {
      foregroundPane.color = newValue
    }
  }

  var fontColor : SKColor {
    get {
      return label.fontColor!
    }

    set {
      label.fontColor = newValue
    }
  }

  var backgroundColor : SKColor {
    get {
      return backgroundPane.color
    }

    set {
      backgroundPane.color = newValue
    }
  }

  func setup() {
    self.color = .clear

    backgroundPane = SKSpriteNode(color: SKColor(red:0.79, green:0.76, blue:0.37, alpha:1.0), size: size)
    backgroundPane.position = zeroPosition

    foregroundPane = SKSpriteNode(color: SKColor(red:0.99, green:0.92, blue:0.55, alpha:1.0), size: size)
    foregroundPane.anchorPoint = anchorPoint
    backgroundPane.anchorPoint = anchorPoint

    label = SKLabelNode(fontNamed: fontName)

    label.fontColor = SKColor(red:0.29, green:0.29, blue:0.29, alpha:1.0)
    label.horizontalAlignmentMode = .center
    label.verticalAlignmentMode = .center

    addChild(backgroundPane)
    addChild(foregroundPane)
    foregroundPane.addChild(label)

    zPosition = 0
  }

  func setup(text: String, fontSize: CGFloat, autoResize: Bool) {
    label.text = text
    label.fontSize = fontSize

    if autoResize {
      let newSize = CGSize(width: label.frame.width + label.frame.width * 0.4, height: label.frame.height * 2)

      size.width = max(size.width, newSize.width)
      size.height = max(size.height, newSize.width)
    }

    updateLayout()
  }

  private func updateLayout() {
    if backgroundPane == nil { return }

    zeroPosition = CGPoint(x: -elevation, y: -elevation)
    backgroundPane.position = zeroPosition

    var buttonSize = size
    buttonSize.height -= elevation
    buttonSize.width -= elevation

    backgroundPane.size = buttonSize
    foregroundPane.size = buttonSize

    if anchorPoint == CGPoint(x: 0, y: 1) {
      label.position = CGPoint(x: buttonSize.width / 2, y: -buttonSize.height / 2)
    }
  }

  override func updateControl() {
    if controlState.contains(.Highlighted) {
      foregroundPane.run(SKAction.move(to: zeroPosition, duration: 0.05))
    } else if controlState.contains(.Normal) {
      foregroundPane.run(SKAction.move(to: CGPoint.zero, duration: 0.05))
    }
  }
}
