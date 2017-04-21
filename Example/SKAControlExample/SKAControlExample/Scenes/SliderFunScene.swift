//
//  GameScene.swift
//  SKAControlExample
//
//  Created by Marc Vandehey on 4/20/17.
//  Copyright © 2017 SpriteKit Alliance. All rights reserved.
//

import SpriteKit
import GameplayKit

class SliderFunScene: SKScene {
  private let ska = SKASprite()
  private let redSlider = SliderSprite()
  private let greenSlider = SliderSprite()
  private let blueSlider = SliderSprite()
  private let alphaSlider = SliderSprite()

  override func didMove(to view: SKView) {
    let backButton = TextButtonSprite()

    backButton.setup(text: "BACK", fontSize: 15, autoResize: false)
    backButton.size = CGSize(width: 70, height: 44)
    backButton.color = .black
    backButton.position = CGPoint(x: backButton.size.width / 2 + 10, y: size.height - backButton.size.height / 2 - 10)

    backButton.addTarget(self, selector: #selector(backButtonPressed(_:)), forControlEvents: .TouchUpInside)
    backButton.zPosition = 1000
    addChild(backButton)

    ska.position = CGPoint(x: frame.midX, y: backButton.position.y - ska.size.height / 2)
    addChild(ska)

    let standButton = TextButtonSprite()
    standButton.setup(text: "Stand", fontSize: 15, autoResize: true)
    standButton.color = .black
    standButton.position = CGPoint(x: size.width / 5, y: frame.midY)
    standButton.addTarget(self, selector: #selector(startStanding(_:)), forControlEvents: .TouchUpInside)
    addChild(standButton)

    let happyButton = TextButtonSprite()
    happyButton.setup(text: "Happy", fontSize: 15, autoResize: true)
    happyButton.color = .black
    happyButton.position = CGPoint(x: size.width / 5 * 2, y: frame.midY)
    happyButton.addTarget(self, selector: #selector(startBeingHappy(_:)), forControlEvents: .TouchUpInside)
    addChild(happyButton)

    let danceButton = TextButtonSprite()
    danceButton.setup(text: "Dance", fontSize: 15, autoResize: true)
    danceButton.color = .black
    danceButton.position = CGPoint(x: size.width / 5 * 3, y: frame.midY)
    danceButton.addTarget(self, selector: #selector(startDancing(_:)), forControlEvents: .TouchUpInside)
    addChild(danceButton)

    let yawnButton = TextButtonSprite()
    yawnButton.setup(text: "Yawn", fontSize: 15, autoResize: true)
    yawnButton.color = .black
    yawnButton.position = CGPoint(x: size.width / 5 * 4, y: frame.midY)
    yawnButton.addTarget(self, selector: #selector(startYawning(_:)), forControlEvents: .TouchUpInside)
    addChild(yawnButton)

    alphaSlider.position = CGPoint(x: frame.midX, y: 55)
    alphaSlider.addTarget(self, selector: #selector(sliderUpdated(_:)), forControlEvents: .ValueChanged)
    alphaSlider.value = 1
    alphaSlider.foregroundColor = .black
    addChild(alphaSlider)

    blueSlider.position = CGPoint(x: frame.midX, y: alphaSlider.position.y + blueSlider.size.height)
    blueSlider.addTarget(self, selector: #selector(sliderUpdated(_:)), forControlEvents: .ValueChanged)
    blueSlider.value = 78.0 / 255.0
    blueSlider.foregroundColor = .blue
    addChild(blueSlider)

    greenSlider.position = CGPoint(x: frame.midX, y: blueSlider.position.y + greenSlider.size.height)
    greenSlider.addTarget(self, selector: #selector(sliderUpdated(_:)), forControlEvents: .ValueChanged)
    greenSlider.value = 78.0 / 255.0
    greenSlider.foregroundColor = .green
    addChild(greenSlider)

    redSlider.position = CGPoint(x: frame.midX, y: greenSlider.position.y + redSlider.size.height)
    redSlider.addTarget(self, selector: #selector(sliderUpdated(_:)), forControlEvents: .ValueChanged)
    redSlider.value = 250.0 / 255.0
    redSlider.foregroundColor = .red
    addChild(redSlider)
  }

  func backButtonPressed(_ : TextButtonSprite) {
    let scene = MenuScene()
    scene.size = size
    let reveal = SKTransition.reveal(with: .right, duration: 1)

    view?.presentScene(scene, transition: reveal)
  }

  func startStanding(_ : AnyObject) {
    ska.playActionForState(state: .Standing)
  }

  func startBeingHappy(_ : AnyObject) {
    ska.playActionForState(state: .Happy)
  }

  func startDancing(_ : AnyObject) {
    ska.playActionForState(state: .Dance)
  }

  func startYawning(_ : AnyObject) {
    ska.playActionForState(state: .Yawn)
  }

  func sliderUpdated(_ someSlider : SliderSprite) {
    ska.color = SKColor(red: redSlider.value, green: greenSlider.value, blue: blueSlider.value, alpha: alphaSlider.value)
  }

  deinit {
    print("SliderFunScene destroyed")
  }
}
