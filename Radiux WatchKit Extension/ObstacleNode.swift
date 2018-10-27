//
//  ObstacleNode.swift
//  Radiux WatchKit Extension
//
//  Created by Sam Richardson on 10/26/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import SpriteKit

class ObstacleNode: SKSpriteNode {

    init() {
        super.init(texture: nil, color: .white, size: CGSize(width: 10.0, height: 10.0))
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        name = "obstacle"
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10.0, height: 10.0))
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
    }
    
}
