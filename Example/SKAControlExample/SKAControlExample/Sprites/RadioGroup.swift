//
//  RadioGroup.swift
//  SKASimpleButtonExample
//
//  Created by Marc Vandehey on 4/18/17.
//  Copyright © 2017 SpriteKit Alliance. All rights reserved.
//

import SpriteKit

/**
 Example Usage:
 
 let radioGroup = RadioGroup()
 radioGroup.addTarget(self, selector: #selector(radioGroupChanged(_:)), forControlEvents: .ValueChanged)
 addChild(radioGroup)

 .
 .
 .
 
 func radioGroupChanged(_ radioGroup: RadioGroup) {
   //Do Something here!
 
   print("value here \(radioGroup.value)")
 }

*/

class RadioGroup : SKAControlSprite {
  private var option1 = RadioButton()
  private var option2 = RadioButton()
  private var option3 = RadioButton()

  init() {
    super.init(texture: nil, color: .clear, size: CGSize.zero)

    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(texture: nil, color: .clear, size: CGSize.zero)

    setupView()
  }

  private func setupView() {
    option1.addTarget(self, selector: #selector(radioButtonSelected(_:)), forControlEvents: .TouchUpInside)
    option2.addTarget(self, selector: #selector(radioButtonSelected(_:)), forControlEvents: .TouchUpInside)
    option3.addTarget(self, selector: #selector(radioButtonSelected(_:)), forControlEvents: .TouchUpInside)

    addChild(option1)

    option2.position = CGPoint(x: 0, y: option1.size.height * -1.5)
    addChild(option2)

    option3.position = CGPoint(x: 0, y: option1.size.height * -3)
    addChild(option3)

    radioButtonSelected(option1)

    option1.value = 0
    option2.value = 1
    option3.value = 2
  }

  func radioButtonSelected(_ radioButton : RadioButton) {
    value = radioButton.value

    switch radioButton {
    case option1:
      option1.style(selected: true)
      option2.style(selected: false)
      option3.style(selected: false)

    case option2:
      option1.style(selected: false)
      option2.style(selected: true)
      option3.style(selected: false)
    default:
      option1.style(selected: false)
      option2.style(selected: false)
      option3.style(selected: true)
    }
  }

  class RadioButton : SKAControlSprite {
    private let selectedSprite = SKSpriteNode(imageNamed: "radio-on")

    init() {
      let texture = SKTexture(imageNamed: "radio-off")

      super.init(texture: texture, color: SKColor.clear, size: texture.size())

      setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)

      setup()
    }

    private func setup() {
      addChild(selectedSprite)

      selectedSprite.zPosition = 10
      selectedSprite.alpha = 0
      selectedSprite.setScale(0)
    }

    fileprivate func style(selected : Bool) {
      if selected {
        selectedSprite.run(SKAction.group([SKAction.scale(to: 1, duration: 0.25), SKAction.fadeIn(withDuration: 0.25)]))
      } else {
        selectedSprite.run(SKAction.group([SKAction.scale(to: 0, duration: 0.25), SKAction.fadeOut(withDuration: 0.25)]))
      }
    }
  }
}
