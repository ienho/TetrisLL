//
//  TRSNextShapeLayerNode.swift
//  TetrisLite
//
//  Created by ian  on 16/9/4.
//  Copyright © 2016年 ian . All rights reserved.
//

import SpriteKit

class TRSNextShapeLayerNode: SKNode {
    
    var next: TRSShape? = nil
    
    override init() {
        super.init()
    }
    
    func setNextShape(newNext: TRSShape) {
        if next != nil {
            self.next!.removeFromParent()
        }
        
        self.next = newNext
        
        newNext.left = 0
        newNext.top = 0
        self.addChild(newNext)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
