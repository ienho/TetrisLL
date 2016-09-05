//
//  TRSControllerNode.swift
//  TetrisLite
//
//  Created by ian  on 16/9/3.
//  Copyright © 2016年 ian . All rights reserved.
//

import SpriteKit

class TRSControllerNode: SKNode {
    
    internal var btnLeft: TetrisButton = TetrisButton(imageNamed: "button_left.png")
    internal var btnDrop: TetrisButton = TetrisButton(imageNamed: "button_drop.png")
    internal var btnRight: TetrisButton = TetrisButton(imageNamed: "button_right.png")
    internal var btnDown: TetrisButton = TetrisButton(imageNamed: "button_down.png")
    internal var btnRotate: TetrisButton = TetrisButton(imageNamed: "button_rotate.png")
    
    override init() {
        super.init()
        
        let deviceScreenMode = UIScreen.mainScreen().currentMode;
        let btnWidth = (deviceScreenMode?.size.width)! / 5
        
        btnLeft.position = CGPoint(x: 50, y: 50 + btnWidth * 0.8)
        btnLeft.anchorPoint = CGPointZero
        btnLeft.size = CGSize(width: btnWidth, height: btnWidth)
        
        btnDrop.position = CGPoint(x: 50 + btnWidth * 0.8, y: 50 + btnWidth * 1.6)
        btnDrop.anchorPoint = CGPointZero
        btnDrop.size = CGSize(width: btnWidth, height: btnWidth)
        
        btnRight.position = CGPoint(x: 50 + btnWidth * 1.6, y: 50 + btnWidth * 0.8)
        btnRight.anchorPoint = CGPointZero
        btnRight.size = CGSize(width: btnWidth, height: btnWidth)
        
        btnDown.position = CGPoint(x: 50 + btnWidth * 0.8, y: 50)
        btnDown.anchorPoint = CGPointZero
        btnDown.size = CGSize(width: btnWidth, height: btnWidth)
        
        btnRotate.position = CGPoint(x: (deviceScreenMode?.size.width)! - 50 - btnWidth - 50, y: 50 + btnWidth * 0.8 - 15)
        btnRotate.anchorPoint = CGPointZero
        btnRotate.size = CGSize(width: btnWidth + 50, height: btnWidth + 50)

        self.addChild(btnLeft)
        self.addChild(btnDrop)
        self.addChild(btnRight)
        self.addChild(btnDown)
        self.addChild(btnRotate)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
