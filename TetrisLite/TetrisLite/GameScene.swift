//
//  GameScene.swift
//  TetrisLite
//
//  Created by ian  on 16/9/3.
//  Copyright (c) 2016年 ian . All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var game: TRSGameEngine? = nil
    var gamepadLayer: TRSControllerNode? = nil
    var gameInfoLayer: TRSInfoLayerNode = TRSInfoLayerNode.init()
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToView(view: SKView) {
        
        // tetrisShape
        let offsetY = self.size.height - (20 * 40)
        let offsetX = (self.size.width - (40 * 10)) / 2
        let shapeLayer = TRSShapeLayerNode()
        shapeLayer.position = CGPoint(x: offsetX, y: offsetY)
        shapeLayer.setKillLinesBlock { (kills) in
            self.gameInfoLayer.linesLabel.text = "lines \(shapeLayer.killLines)"
            self.gameInfoLayer.scoreLabel.text = "score \(shapeLayer.killLines)"
        }
        
        // next
        let nextLayer = TRSNextShapeLayerNode()
        nextLayer.position = CGPoint(x: offsetX + 40 * 10 + 10, y: self.size.height - 40 * 5)
        
        // info
        gameInfoLayer.position = CGPoint(x: 0, y: 0)
        
        // controller
        self.gamepadLayer = TRSControllerNode()
        
        self.game = TRSGameEngine(shapeLayer: shapeLayer, nextLayer: nextLayer, blockWidth: 40)
        self.game?.startGame()
        self.game?.statusChanged = { status in
            var msg = ""
            switch status {
            case .Ready:
                msg = "ready"
            case .Playing:
                msg = "Playing"
            case .Over:
                msg = "game over"
            default:
                msg = ""
            }
            self.gameInfoLayer.msssageLabel.text = msg
        }
        
        self.addChild(shapeLayer)
        self.addChild(nextLayer)
        self.addChild(self.gameInfoLayer)
        self.addChild(self.gamepadLayer!)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if (self.gamepadLayer!.btnLeft.containsPoint(location)) {
                self.game?.moveLeft()
            }
            else if (self.gamepadLayer!.btnDrop.containsPoint(location)) {
                self.game?.moveDrop()
            }
            else if (self.gamepadLayer!.btnRight.containsPoint(location)) {
                self.game?.moveRight()
            }
            else if (self.gamepadLayer!.btnDown.containsPoint(location)) {
                self.game?.moveDown()
            }
            else if (self.gamepadLayer!.btnRotate.containsPoint(location)) {
                self.game?.moveRotate()
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.game!.updateGame(currentTime)
    }
}
