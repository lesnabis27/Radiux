//
//  Game.swift
//  Radiux WatchKit Extension
//
//  Created by Sam Richardson on 10/26/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import SpriteKit

// Bit masks
struct PhysicsCategory {
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max
    static let projectile: UInt32 = 0b1
    static let player: UInt32 = 0b10
    static let pickup: UInt32 = 0b100
    static let obstacle: UInt32 = 0b1000
}

class Game: SKScene, SKPhysicsContactDelegate {

    // Owning interface controller
    var interfaceDelegate: GameInterfaceController?
    
    // Nodes
    let player = PlayerNode()
    let scoreLabel = ScoreNode()
    var score: Int = 0 {
        didSet {
            scoreLabel.text = String(score)
        }
    }
    
    // Insets
    var layoutMargins = NSDirectionalEdgeInsets() {
        didSet {
            scoreLabel.position = CGPoint(x: layoutMargins.leading,
                                          y: frame.maxY - layoutMargins.leading)
        }
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        // Set up world
        backgroundColor = UIColor.black
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        physicsWorld.contactDelegate = self
        // Set up nodes
        addChild(player)
        addChild(scoreLabel)
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        print("Setup complete")
    }
    
    func start() {
        scoreLabel.countdown()
        let shootLoop = SKAction.sequence([SKAction.run {
            self.player.shoot()
            }, SKAction.wait(forDuration: 0.7)])
        let obstacleLoop = SKAction.sequence([SKAction.run {
            self.addObstacle()
            }, SKAction.wait(forDuration: 3.0)])
        let pickupLoop = SKAction.sequence([SKAction.run {
            self.addPickup()
            }, SKAction.wait(forDuration: 20.0)])
        player.run(SKAction.repeatForever(shootLoop))
        run(SKAction.repeatForever(obstacleLoop))
        run(SKAction.repeatForever(pickupLoop))
    }
    
    func reset() {
        for child in children {
            if child.name != "player" && child.name != "score" {
                child.removeFromParent()
            }
        }
        score = 0
        // Do the countdown again
        // Reset all powerups
        // Return to default enemy whatever
    }
    
    func gameOver() {
        interfaceDelegate!.presentController(withName: "gameOver", context: score)
        reset()
    }
    
    func rotatePlayer(by amount: CGFloat) {
        player.zRotation += amount * 3
    }
    
    // Spawns
    
    func addObstacle() {
        let obstacle = ObstacleNode()
        let spawnPoint = CGPoint(r: 300, theta: CGFloat.random(in: 0..<CGFloat.tau))
        let action = SKAction.move(to: player.position, duration: 10.0)
        let remove = SKAction.removeFromParent()
        obstacle.position = spawnPoint
        addChild(obstacle)
        obstacle.run(SKAction.sequence([action, remove]))
    }
    
    func addPickup() {
        let pickup = PickupNode()
        let spawnPoint = CGPoint(r: 300, theta: CGFloat.random(in: 0..<CGFloat.tau))
        let action = SKAction.move(to: player.position, duration: 12.0)
        let remove = SKAction.removeFromParent()
        pickup.position = spawnPoint
        addChild(pickup)
        pickup.run(SKAction.sequence([action, remove]))
    }
    
    // Contact
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // Test for projectile collisions
        if (firstBody.categoryBitMask & PhysicsCategory.projectile != 0) {
            if ((secondBody.categoryBitMask & PhysicsCategory.pickup != 0) || (secondBody.categoryBitMask & PhysicsCategory.obstacle != 0)) {
                if let pickup = secondBody.node as? SKSpriteNode, let projectile = secondBody.node as? SKSpriteNode {
                    projectileDidCollide(projectile: projectile, other: pickup)
                }
            }
        }
        // Test for player collisions
        else if (firstBody.categoryBitMask & PhysicsCategory.player != 0) {
            if (secondBody.categoryBitMask & PhysicsCategory.pickup != 0) {
                if let pickup = secondBody.node as? SKSpriteNode {
                    pickupDidCollideWithPlayer(pickup: pickup)
                }
            } else if (secondBody.categoryBitMask & PhysicsCategory.obstacle != 0) {
                if let obstacle = secondBody.node as? SKSpriteNode {
                    obstacleDidCollideWithPlayer(obstacle: obstacle)
                }
            }
        }
    }
    
    func projectileDidCollide(projectile: SKSpriteNode, other: SKSpriteNode) {
        projectile.removeFromParent()
        if other.name! == "obstacle" {
            score += 1
        }
        other.removeFromParent()
    }
    
    func obstacleDidCollideWithPlayer(obstacle: SKSpriteNode) {
        obstacle.removeFromParent()
        gameOver()
    }
    
    func pickupDidCollideWithPlayer(pickup: SKSpriteNode) {
        pickup.removeFromParent()
        score += 1
        // Implement some kind of power up system
    }
    
}
