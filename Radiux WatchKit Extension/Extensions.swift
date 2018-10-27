//
//  Extensions.swift
//  Radiux WatchKit Extension
//
//  Created by Sam Richardson on 10/26/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import UIKit

extension CGPoint {
    // Take in r and theta and create a cartesian point
    init(r: CGFloat, theta: CGFloat) {
        let newx = r * cos(theta)
        let newy = r * sin(theta)
        self.init(x: newx, y: newy)
    }
}

extension CGVector {
    // Specify a CGVector with polar coordinates
    init(dr: CGFloat, dtheta: CGFloat) {
        let newdx = dr * cos(dtheta)
        let newdy = dr * sin(dtheta)
        self.init(dx: newdx, dy: newdy)
    }
}

extension CGFloat {
    // 2 * pi
    static let tau = CGFloat.pi * 2
}
