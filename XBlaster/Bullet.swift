//
//  Bullet.swift
//  XBlaster
//
//  Created by FRANCIS HUYNH on 7/2/15.
//  Copyright (c) 2015 Big Nerd ranch. All rights reserved.
//

import Foundation
import SpriteKit
class Bullet : Entity {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(entityPosition: CGPoint) {
        let entityTexture = Bullet.generateTexture()!
        super.init(position: entityPosition, texture: entityTexture)
        name = "bullet"
    }
    
    override class func generateTexture() -> SKTexture? {
        struct SharedTexture {
            static var texture = SKTexture()
            static var onceToken : dispatch_once_t = 0
        }
        
        dispatch_once(&SharedTexture.onceToken) {
            let bulletChar = SKLabelNode(fontNamed: "Arial")
            bulletChar.name = "bulletchar"
            bulletChar.fontSize = 20
            bulletChar.fontColor = SKColor.whiteColor()
            bulletChar.text = "●"
            let textureView = SKView()
            SharedTexture.texture = textureView.textureFromNode(bulletChar)
            SharedTexture.texture.filteringMode = .Nearest
        }
        return SharedTexture.texture
    }
    
    override func update(delta: NSTimeInterval) {
        
    }
}