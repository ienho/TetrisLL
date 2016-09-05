//
//  TRSInfoLayerNode.swift
//  TetrisLite
//
//  Created by ian  on 16/9/3.
//  Copyright © 2016年 ian . All rights reserved.
//

import SpriteKit

class TRSInfoLayerNode: SKNode {
    
    internal var scoreLabel: SKLabelNode = SKLabelNode(fontNamed:"Chalkduster")
    internal var linesLabel: SKLabelNode = SKLabelNode(fontNamed:"Chalkduster")
    internal var msssageLabel: SKLabelNode = SKLabelNode(fontNamed:"Chalkduster")
    
    override init() {
        super.init()
        
        let deviceScreenMode = UIScreen.mainScreen().currentMode;
        
        scoreLabel.text = "score 0"
        scoreLabel.fontSize = 22
        scoreLabel.position = CGPoint(x: 60 ,y: (deviceScreenMode?.size.height)! - 50)
        
        linesLabel.text = "lines 0"
        linesLabel.fontSize = 22
        linesLabel.position = CGPoint(x: 60, y: (deviceScreenMode?.size.height)! - 80)
        
        msssageLabel.text = ""
        msssageLabel.fontSize = 22
        msssageLabel.position = CGPoint(x: 70, y: (deviceScreenMode?.size.height)! - 110)
        
        self.addChild(scoreLabel)
        self.addChild(linesLabel)
        self.addChild(msssageLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
