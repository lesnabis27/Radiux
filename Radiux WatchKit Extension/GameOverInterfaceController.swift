//
//  GameOverInterfaceController.swift
//  Radiux WatchKit Extension
//
//  Created by Sam Richardson on 11/5/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import WatchKit
import Foundation


class GameOverInterfaceController: WKInterfaceController {

    @IBOutlet weak var scoreLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        setTitle("Play Again")
        if context != nil {
            let contextInt = context as! Int
            scoreLabel.setText(String(contextInt))
        } else {
            scoreLabel.setText("Error")
        }
        super.awake(withContext: context)
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

}
