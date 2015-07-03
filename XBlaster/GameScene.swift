//
//  GameScene.swift
//  XBlaster
//
//  Created by FRANCIS HUYNH on 6/28/15.
//  Copyright (c) 2015 Big Nerd ranch. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let playerLayerNode = SKNode()
    let hudLayerNode = SKNode()
    var bulletLayerNode = SKNode()
    let scoreLabel = SKLabelNode(fontNamed: "Edit Undo Line BRK")
    let playableRect: CGRect
    let hudHeight: CGFloat = 90
    let healthBarString: NSString = "===================="
    let playerHealthLabel = SKLabelNode(fontNamed: "Arial")
    
    var playerShip: PlayerShip!
    var deltaPoint = CGPointZero
    
    var bulletInterval: NSTimeInterval = 0
    var lastUpdateTime: NSTimeInterval = 0
    var dt: NSTimeInterval = 0
    
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 16.0/9.0 // iphone 5 AR. This is ratio of height to width!
        let maxAspectRatioWidth = size.height / maxAspectRatio
        let playableMargin = (size.width-maxAspectRatioWidth) / 2.0
        playableRect = CGRect(x: playableMargin, y:0, width: maxAspectRatioWidth, height: size.height - hudHeight)
        println("\(playableRect)")
        super.init(size: size)
        setupSceneLayers()
        setupUI()
        setupEntities()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not used")
    }
    
    func setupEntities() {
        playerShip = PlayerShip(entityPosition: CGPoint(x: size.width / 2, y: 100))
        playerLayerNode.addChild(playerShip)
    }
    func setupSceneLayers() {
        playerLayerNode.zPosition = 50
        hudLayerNode.zPosition = 100
        bulletLayerNode.zPosition = 25
        addChild(playerLayerNode)
        addChild(hudLayerNode)
        addChild(bulletLayerNode)
        
    }
    
    func setupUI() {
        let backgroundSize = CGSize(width: size.width, height: hudHeight)
        let backgroundColor = SKColor.blackColor()
        let hudBarBackground = SKSpriteNode(color: backgroundColor, size: backgroundSize)
        hudBarBackground.position = CGPoint(x: 0, y: size.height - hudHeight)
        hudBarBackground.anchorPoint = CGPointZero
        hudLayerNode.addChild(hudBarBackground)
        
        scoreLabel.fontSize = 50
        scoreLabel.text = "Score: 0"
        scoreLabel.name = "scoreLabel"
        scoreLabel.verticalAlignmentMode = .Center
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height - scoreLabel.frame.size.height + 3)
        hudLayerNode.addChild(scoreLabel)
        
        let scoreFlashAction = SKAction.sequence([SKAction.scaleTo(1.2, duration: 1.0),
                SKAction.scaleTo(1.0, duration: 1.0)])
        scoreLabel.runAction(SKAction.repeatActionForever(scoreFlashAction))
        
        let playerHealthBackgroundLabel = SKLabelNode(fontNamed: "Arial")
        playerHealthBackgroundLabel.name = "playerHealthBackground"
        playerHealthBackgroundLabel.fontColor = SKColor.darkGrayColor()
        playerHealthBackgroundLabel.fontSize = 50
        playerHealthBackgroundLabel.text = healthBarString as String
        playerHealthBackgroundLabel.horizontalAlignmentMode = .Left
        playerHealthBackgroundLabel.verticalAlignmentMode = .Top
        playerHealthBackgroundLabel.position = CGPoint(x: CGRectGetMinX(playableRect), y: size.height - CGFloat(hudHeight) + playerHealthBackgroundLabel.frame.size.height)
        hudLayerNode.addChild(playerHealthBackgroundLabel)
        
        playerHealthLabel.name = "playerHealthLabel"
        playerHealthLabel.fontColor = SKColor.greenColor()
        playerHealthLabel.fontSize = 50
        playerHealthLabel.text = healthBarString.substringToIndex(20 * 75/100)
        playerHealthLabel.horizontalAlignmentMode = .Left
        playerHealthLabel.verticalAlignmentMode = .Top
        playerHealthLabel.position = CGPoint(x: CGRectGetMinX(playableRect), y: size.height - CGFloat(hudHeight) + playerHealthLabel.frame.size.height)
        hudLayerNode.addChild(playerHealthLabel)
        
    }
    override func didMoveToView(view: SKView) {
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let currentPoint = touch.locationInNode(self)
        let previousTouchLocation = touch.previousLocationInNode(self)
        deltaPoint = currentPoint - previousTouchLocation
    }

   
    override func update(currentTime: CFTimeInterval) {
        var newPoint: CGPoint = playerShip.position + deltaPoint
        newPoint.x.clamp(CGRectGetMinX(playableRect), CGRectGetMaxX(playableRect))
        newPoint.y.clamp(CGRectGetMinY(playableRect), CGRectGetMaxY(playableRect))
        playerShip.position = newPoint
        deltaPoint = CGPointZero
        
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime
        
        bulletInterval += dt
        if bulletInterval > 0.15 {
            bulletInterval = 0
            
            let bullet = Bullet(entityPosition: playerShip.position)
            bulletLayerNode.addChild(bullet)
            
            bullet.runAction(SKAction.sequence([SKAction.moveToY(size.height - hudHeight + bullet.frame.size.height/2, duration: 1.0),
                SKAction.removeFromParent()]));
            
        }
    }
}
