//
//  PickupNode.swift
//  Radiux WatchKit Extension
//
//  Created by Sam Richardson on 10/26/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import SpriteKit

class PickupNode: SKSpriteNode {
    
    let image = SKTexture(imageNamed: "pickup")
    
    init() {
        super.init(texture: image, color: .clear, size: image.size())
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        name = "pickup"
        physicsBody = SKPhysicsBody(circleOfRadius: size.width * 0.5)
        physicsBody?.categoryBitMask = PhysicsCategory.pickup
        physicsBody?.contactTestBitMask = PhysicsCategory.player | PhysicsCategory.projectile
        physicsBody?.collisionBitMask = PhysicsCategory.none
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
    }
    
}
