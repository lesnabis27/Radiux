//
//  ScoreNode.swift
//  Radiux WatchKit Extension
//
//  Created by Sam Richardson on 10/26/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import SpriteKit

class ScoreNode: SKLabelNode {

    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        text = "0"
        fontName = "SFCompactText-Regular"
        fontSize = 24
        fontColor = UIColor.white
        horizontalAlignmentMode = .left
        verticalAlignmentMode = .top
    }
    
    func countdown() {
        let wait = SKAction.wait(forDuration: 1.0)
        let three = SKAction.run {
            self.text = "3"
        }
        let two = SKAction.run {
            self.text = "2"
        }
        let one = SKAction.run {
            self.text = "1"
        }
        let zero = SKAction.run {
            self.text = "0"
        }
        let sequence = SKAction.sequence([three, wait, two, wait, one, wait, zero])
        run(sequence)
    }
    
}
