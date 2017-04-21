//
//  ManyControlsScene.swift
//  SKAControlExample
//
//  Created by Marc Vandehey on 4/20/17.
//  Copyright © 2017 SpriteKit Alliance. All rights reserved.
//

import SpriteKit

class ControlTestScene : SKScene {
  let label = SKLabelNode(fontNamed: "TrebuchetMS")

  override func didMove(to view: SKView) {
    let backButton = TextButtonSprite()

    backButton.setup(text: "BACK", fontSize: 15, autoResize: false)
    backButton.size = CGSize(width: 70, height: 44)
    backButton.color = .black
    backButton.position = CGPoint(x: backButton.size.width / 2 + 10, y: size.height - backButton.size.height / 2 - 10)

    backButton.addTarget(self, selector: #selector(backButtonPressed(_:)), forControlEvents: .TouchUpInside)
    addChild(backButton)

    label.fontSize = 20
    label.horizontalAlignmentMode = .center
    label.verticalAlignmentMode = .center

    label.position = CGPoint(x: frame.midX, y: size.height - backButton.size.height - 50)
    label.text = "Do Something"
    addChild(label)

    let alphaButton = AlphaButton(imageNamed: "simpleButton")
    alphaButton.position = label.position
    alphaButton.position.y -= 50
    alphaButton.addTarget(self, selector: #selector(alphaButtonPressed(_:)), forControlEvents: .TouchUpInside)
    addChild(alphaButton)

    let checkboxButton = CheckBoxSprite()
    checkboxButton.position = alphaButton.position
    checkboxButton.position.y -= 50
    checkboxButton.addTarget(self, selector: #selector(checkBoxChanged(_:)), forControlEvents: .ValueChanged)
    addChild(checkboxButton)

    let radioGroup = RadioGroup()
    radioGroup.position = checkboxButton.position
    radioGroup.position.y -= 50
    radioGroup.addTarget(self, selector: #selector(radioGroupChanged(_:)), forControlEvents: .ValueChanged)
    addChild(radioGroup)

    let switchSprite = SwitchSprite()
    switchSprite.position = CGPoint(x: frame.midX, y: radioGroup.position.y - switchSprite.size.height * 3 - 50)
    switchSprite.addTarget(self, selector: #selector(switchChanged(_:)), forControlEvents: .ValueChanged)
    addChild(switchSprite)

    let sliderSprite = SliderSprite()
    sliderSprite.position = switchSprite.position
    sliderSprite.position.y -= 50
    sliderSprite.addTarget(self, selector: #selector(sliderChanged(_:)), forControlEvents: .ValueChanged)
    addChild(sliderSprite)
  }
 
  func backButtonPressed(_ : TextButtonSprite) {
    label.text = "Back button pressed"

    let scene = MenuScene()
    scene.size = size
    let reveal = SKTransition.reveal(with: .right, duration: 1)

    view?.presentScene(scene, transition: reveal)
  }

  func alphaButtonPressed(_ : AlphaButton) {
    label.text = "Alpha button pressed"
  }

  func checkBoxChanged(_ checkbox : CheckBoxSprite) {
    label.text = "Checkbox updated value to \(checkbox.selected)"
  }

  func radioGroupChanged(_ radioGroup: RadioGroup) {
    label.text = "Radio Group updated value to \(radioGroup.value)"
  }

  func switchChanged(_ switchSprite : SwitchSprite) {
    label.text = "SwitchSprite updated value to \(switchSprite.selected)"
  }

  func sliderChanged(_ sliderSprite : SliderSprite) {
    let stringValue = String(format: "%.3f", Double(sliderSprite.value))
    label.text = "SliderSprite updated value to \(stringValue)"
  }

  deinit {
    print("ControlTestScene destroyed")
  }
}
