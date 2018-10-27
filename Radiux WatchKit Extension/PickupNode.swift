//
//  PickupNode.swift
//  Radiux WatchKit Extension
//
//  Created by Sam Richardson on 10/26/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import SpriteKit

class PickupNode: SKSpriteNode {
    
    init() {
        super.init(texture: nil, color: .green, size: CGSize(width: 10.0, height: 10.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
