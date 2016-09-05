//
//  TRSShapeZR.swift
//  TetrisLite
//
//  Created by ian  on 16/9/3.
//  Copyright © 2016年 ian . All rights reserved.
//

import UIKit

class TRSShapeZR: TRSShape {
    
    static let array: Array<NSArray> = [
        [
            0, 1, 1, 0,
            1, 1, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0
        ],
        [
            1, 0, 0, 0,
            1, 1, 0, 0,
            0, 1, 0, 0,
            0, 0, 0, 0
        ]
    ]
    override var statusArray: Array<NSArray>? {
        set {
            self.statusArray = newValue
        }
        get {
            return TRSShapeZR.array
        }
    }
}
