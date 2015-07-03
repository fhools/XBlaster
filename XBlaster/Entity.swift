//
//  Entity.swift
//  XBlaster
//
//  Created by FRANCIS HUYNH on 7/2/15.
//  Copyright (c) 2015 Big Nerd ranch. All rights reserved.
//

import Foundation
import SpriteKit
class Entity : SKSpriteNode {
    var direction = CGPointZero
    var maxHealth = 100.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(position: CGPoint, texture: SKTexture) {
        super.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        self.position = position
    }
    
    class func generateTexture() -> SKTexture? {
        return nil
    }
    
    func update(delta: NSTimeInterval) {
        
    }
}