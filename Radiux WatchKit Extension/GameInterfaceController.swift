//
//  GameInterfaceController.swift
//  Radiux WatchKit Extension
//
//  Created by Sam Richardson on 10/26/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import WatchKit
import Foundation


class GameInterfaceController: WKInterfaceController, WKCrownDelegate {

    @IBOutlet weak var sceneInterface: WKInterfaceSKScene!
    
    let gameScene = Game(size: WKInterfaceDevice.current().screenBounds.size)
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        sceneInterface.presentScene(gameScene)
        gameScene.start()
    }

    override func willActivate() {
        super.willActivate()
        crownSequencer.delegate = self
        crownSequencer.focus()
        gameScene.isPaused = false
    }

    override func didAppear() {
        // This is the first place this will work
        gameScene.layoutMargins = systemMinimumLayoutMargins
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        gameScene.isPaused = true
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        // Update player rotation
        gameScene.rotatePlayer(by: CGFloat(rotationalDelta))
    }

}
