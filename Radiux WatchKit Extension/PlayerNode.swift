//
//  PlayerNode.swift
//  Radiux WatchKit Extension
//
//  Created by Sam Richardson on 10/26/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import SpriteKit

class PlayerNode: SKSpriteNode {

    let image = SKTexture(imageNamed: "player")
    
    init() {
        super.init(texture: image, color: .clear, size: image.size())
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        name = "player"
        physicsBody = SKPhysicsBody(circleOfRadius: size.width * 0.5)
        physicsBody?.categoryBitMask = PhysicsCategory.player
        physicsBody?.contactTestBitMask = PhysicsCategory.obstacle | PhysicsCategory.pickup
        physicsBody?.collisionBitMask = PhysicsCategory.none
        physicsBody?.pinned = true
    }
    
    func shoot() {
        if parent != nil {
            let projectile = ProjectileNode()
            let vector = CGVector(dr: 300, dtheta: zRotation + CGFloat.pi * 0.5)
            let action = SKAction.move(by: vector, duration: 0.5)
            let remove = SKAction.removeFromParent()
            projectile.position = position
            projectile.zRotation = zRotation
            parent!.addChild(projectile)
            projectile.run(SKAction.sequence([action, remove]))
        }
    }
    
}
