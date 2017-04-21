//
//  SKASprite.swift
//  SKAControlExample
//
//  Created by Marc Vandehey on 4/20/17.
//  Copyright © 2017 SpriteKit Alliance. All rights reserved.
//

import SpriteKit

class SKASprite : SKSpriteNode {
  private let atlas = SKTextureAtlas(named: "SKA")
  private var currentState = SKASpriteState.Standing

  init() {
    let texture = atlas.textureNamed("ska-stand")
    super.init(texture: texture, color: .green, size: texture.size())

    colorBlendFactor = 1
  }

  required init?(coder aDecoder: NSCoder) {
    let texture = atlas.textureNamed("ska-stand")
    super.init(texture: texture, color: .white, size: texture.size())

    colorBlendFactor = 1
  }

  func playActionForState(state : SKASpriteState) {
    if currentState == state { return }

    removeAllActions()

    currentState = state

    switch state {
    case .Happy:
      run(SKAction.repeatForever(getHappyAnimation()))
    case .Dance:
      run(SKAction.repeatForever(getDanceAnimation()))
    case .Yawn:
      run(SKAction.repeatForever(getYawnAnimation()))
    default:
      texture = getStandingTexture()
    }
  }

  private func getStandingTexture() -> SKTexture {
    return atlas.textureNamed("ska-stand")
  }

  private func getHappyAnimation() -> SKAction {
    let standingTexture = getStandingTexture()
    let frame1 = atlas.textureNamed("ska-happy-1")
    let frame2 = atlas.textureNamed("ska-happy-2")

    var textureFrames = [standingTexture]

    for _ in 0...5 {
      textureFrames.append(frame1)
      textureFrames.append(frame2)
    }

    textureFrames.append(standingTexture)
    textureFrames.append(standingTexture)
    textureFrames.append(standingTexture)

    return createAnimationFromFrames(frames: textureFrames, timePerFrame:  0.12)
  }

  private func getDanceAnimation() -> SKAction {
    let standingTexture = getStandingTexture()
    let frame1 = atlas.textureNamed("ska-dance-1")
    let frame2 = atlas.textureNamed("ska-dance-2")
    let frame3 = atlas.textureNamed("ska-dance-3")

    var textureFrames = [standingTexture]

    for _ in 0...4 {
      textureFrames.append(frame1)
      textureFrames.append(frame2)
      textureFrames.append(frame1)
      textureFrames.append(frame3)
    }

    textureFrames.append(frame1)
    textureFrames.append(standingTexture)
    textureFrames.append(standingTexture)
    textureFrames.append(standingTexture)

    return createAnimationFromFrames(frames: textureFrames, timePerFrame: 0.12)
  }

  private func getYawnAnimation() -> SKAction {
    let standingTexture = getStandingTexture()
    var textureFrames = [standingTexture]

    for i in 1...6 {
      textureFrames.append(atlas.textureNamed("ska-yawn-\(i)"))
    }

    textureFrames.append(standingTexture)
    textureFrames.append(standingTexture)
    textureFrames.append(standingTexture)

    return createAnimationFromFrames(frames: textureFrames, timePerFrame: 0.18)
  }

  private func createAnimationFromFrames(frames : [SKTexture], timePerFrame: TimeInterval) -> SKAction {
    return SKAction.animate(with: frames, timePerFrame: timePerFrame, resize: true, restore: true)
  }

  enum SKASpriteState {
    case Standing
    case Happy
    case Dance
    case Yawn
   }
}
