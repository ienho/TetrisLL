//
//  TetrisButton.swift
//  TetrisLite
//
//  Created by ian  on 16/9/3.
//  Copyright © 2016年 ian . All rights reserved.
//

import SpriteKit

class TetrisButton: SKSpriteNode {

    override func containsPoint(p: CGPoint) -> Bool {
        
        let centerX = CGRectGetMidX(self.frame)
        let centerY = CGRectGetMidY(self.frame)
        let distance = sqrt(pow(centerX - p.x, 2) + pow(centerY - p.y, 2))
        if distance < self.size.width / 2 {
            return true
        }
        
        return false
    }
}
