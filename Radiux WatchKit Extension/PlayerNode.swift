//
//  PlayerNode.swift
//  Radiux WatchKit Extension
//
//  Created by Sam Richardson on 10/26/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import SpriteKit

class PlayerNode: SKSpriteNode {

    init() {
        super.init(texture: nil, color: .white, size: CGSize(width: 10.0, height: 20.0))
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        name = "player"
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.pinned = true
    }
    
    func shoot() {
        if parent != nil {
            let projectile = ProjectileNode()
            let vector = CGVector(dr: 300, dtheta: zRotation - CGFloat.pi * 0.5)
            let action = SKAction.move(by: vector, duration: 1.0)
            let remove = SKAction.removeFromParent()
            projectile.position = position
            projectile.zRotation = zRotation
            parent!.addChild(projectile)
            projectile.run(SKAction.sequence([action, remove]))
        }
    }
    
}
