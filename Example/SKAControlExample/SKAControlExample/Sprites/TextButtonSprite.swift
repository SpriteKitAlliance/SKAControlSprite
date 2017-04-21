//
//  TextButtonSprite.swift
//  SKAControlExample
//
//  Created by Marc Vandehey on 4/20/17.
//  Copyright © 2017 SpriteKit Alliance. All rights reserved.
//

import SpriteKit

class TextButtonSprite : AlphaButton {
  private var label : SKLabelNode!

  init() {
    super.init(texture: nil, color: .clear, size: CGSize.zero)

    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(texture: nil, color: .clear, size: CGSize.zero)

    setup()
  }

  private func setup() {
    label = SKLabelNode(fontNamed: "Avenir-Black")
    addChild(label)

    label.fontColor = .white
  }

  func setup(text: String, fontSize: CGFloat, autoResize: Bool) {
    label.text = text
    label.fontSize = fontSize
    label.horizontalAlignmentMode = .center
    label.verticalAlignmentMode = .center

    if autoResize {
      size = CGSize(width: label.frame.width * 1.4, height: label.frame.height * 2)
    }
  }

  override func updateControl() {
    if controlState.contains(.Disabled) {
      run(SKAction.fadeAlpha(to: 0.3, duration: 0.15))
    } else if controlState.contains(.Highlighted) {
      run(SKAction.fadeAlpha(to: 0.4, duration: 0.15))
    } else if controlState.contains(.Normal) {
      run(SKAction.fadeAlpha(to: 1, duration: 0.15))
    }
  }
}
