//
//  TRSGameEngine.swift
//  TetrisLite
//
//  Created by ian  on 16/9/3.
//  Copyright © 2016年 ian . All rights reserved.
//

import UIKit

enum TRSGameStatus {
    case Ready
    case Playing
    case Paused
    case Over
}

class TRSGameEngine: NSObject {
    
    private var currentTickGameTime: CFTimeInterval = 0
    private var lastUpdateGameTime: CFTimeInterval = 0
    private var currentIntervarSeconds: Double = 0.8
    private var blockWidth: CGFloat = 40
    private var cols: Int = 10
    private var rows: Int = 20
    
    var currentShape: TRSShape? = nil
    var currentShadow: TRSShape? = nil
    var nextShape: TRSShape?
    var gameStatus: TRSGameStatus = .Ready {
        didSet {
            if self.statusChanged != nil {
                self.statusChanged!(status: self.gameStatus)
            }
        }
    }
    var currentScore: Int = 0
    var currentLines: Int = 0
    var totoalTime: CFTimeInterval = 0
    var shapeLayer: TRSShapeLayerNode?
    var nextLayer: TRSNextShapeLayerNode?
    var showShadow: Bool = true
    
    var statusChanged: ((status: TRSGameStatus) -> ())? = nil
    
    init(shapeLayer: TRSShapeLayerNode, nextLayer:TRSNextShapeLayerNode , blockWidth: CGFloat) {
        super.init()
        self.shapeLayer = shapeLayer
        self.nextLayer = nextLayer
        self.blockWidth = blockWidth
    }
    
    func startGame() {
        self.genNextShape()
        self.gameStatus = .Playing
        print("开始游戏")
    }
    
    func pauseGame() {
        
    }
    
    func resumeGame() {
        
    }
    
    func restartGame() {
        
    }
    
    func saveGame() -> Bool {
        return true
    }
    
    func updateGame(currentTime: CFTimeInterval) {
        if gameStatus == TRSGameStatus.Playing {
            if lastUpdateGameTime == 0 {
                lastUpdateGameTime = currentTime
            } else {
                let duration = currentTime - lastUpdateGameTime
                self.totoalTime += duration
                currentTickGameTime += duration
                lastUpdateGameTime = currentTime
                
                if currentTickGameTime > currentIntervarSeconds {
                    currentTickGameTime = 0
                    self.hitTimeTick()
                }
            }
        }
    }
    
    func hitTimeTick() {
        if self.canMoveDown(self.currentShape!) {
            self.currentShape!.moveDown()
        } else {
            self.shapeLayer!.receiveShape(self.currentShape!)
            self.currentShape!.removeFromParent()
            self.genNextShape()
        }
    }
    
    func didGameOver() {
        self.gameStatus = .Over
        print("game over")
    }
    
    /**
     generate next
     */
    func genNextShape() {
        
        if self.nextShape == nil {
            self.nextShape = self.genRandomShape()
        }
        self.currentShape = self.nextShape;
        self.nextShape = self.genRandomShape()
        
        let minTop = self.currentShape?.minBlockTop
        self.currentShape?.left = 3
        self.currentShape?.top = 19 - 4 + minTop!
        print("new \(self.currentShape!.classForCoder) with statusIndex:\(self.currentShape!.statusIndex) left:\(self.currentShape!.left) top:\(self.currentShape!.top)")
        
        if self.currentShadow != nil {
            self.currentShadow!.removeFromParent()
        }
        self.currentShadow = self.currentShape!.copyShadow()
        self.setShadowPosition()
        
        self.nextLayer?.setNextShape(self.nextShape!)
        self.shapeLayer!.addChild(self.currentShape!)
        self.shapeLayer!.addChild(self.currentShadow!)
        
        if self.isGameOver() {
            self.didGameOver()
        }
    }
    
    func isGameOver() -> Bool {
        if self.isCollision(self.currentShape!) {
            return true
        }
        
        return false
    }
    
    func isCollision(shape: TRSShape) -> Bool {
        var isCollision = false
        
        for shapeBlock in shape.blocks! {
            let tempTop = shape.top + shapeBlock.top
            let tempLeft = shape.left + shapeBlock.left
            
            for fixedBlock in self.shapeLayer!.fixedBlocks {
                if tempLeft == fixedBlock.left && tempTop == fixedBlock.top {
                    isCollision = true
                    break
                }
            }
        }
        
        return isCollision
    }
    
    func moveLeft() {
        if self.canMoveLeft(self.currentShape!) {
            self.currentShape!.moveLeft()
            
            if self.showShadow {
                self.currentShadow!.left = self.currentShape!.left;
                self.currentShadow!.top = self.currentShape!.top;
                self.setShadowPosition()
            }
        }
    }
    
    func moveRight() {
        if self.canMoveRight(self.currentShape!) {
            self.currentShape!.moveRight()
            
            if self.showShadow {
                self.currentShadow!.left = self.currentShape!.left;
                self.currentShadow!.top = self.currentShape!.top;
                self.setShadowPosition()
            }
        }
    }
    
    func moveDown() {
        if self.canMoveDown(self.currentShape!) {
            self.currentShape!.moveDown()
        }
    }
    
    func moveDrop() {
        while self.canMoveDown(self.currentShape!) {
            self.currentShape?.moveDown()
        }
        
        // reset
        self.currentTickGameTime = 0
        
        self.shapeLayer!.receiveShape(self.currentShape!)
        self.currentShape!.removeFromParent()
        self.genNextShape()
        
        print("\(self.currentShape!.classForCoder) move drop to \(self.currentShape!.top)")
    }
    
    func moveRotate() {
        
        let can = self.canRotateClockWise(self.currentShape!)
        if can.can {
            self.currentShape?.clockwise(can.offsetLeft, offsetTop: can.offsetTop, isTemp: false)
            
            // set shadow
            if self.showShadow {
                self.currentShadow?.clockwise(can.offsetLeft, offsetTop: can.offsetTop, isTemp: true)
                self.currentShadow?.left = (self.currentShape?.left)!
                self.currentShadow?.top = (self.currentShape?.top)!
                self.setShadowPosition()
            }
        }
    }
    
    func setShadowPosition() {
        while (self.canMoveDown(self.currentShadow!)) {
            self.currentShadow!.moveDown();
        }
    }
    
    //
    
    func canMoveLeft(shape: TRSShape) -> Bool {
        
        var isCan = true
        
        for shapeBlock in shape.blocks! {
            let tempTop = shape.top + shapeBlock.top
            let tempLeft = shape.left + shapeBlock.left - 1
            
            if tempLeft < 0 {
                isCan = false
                break;
            }
            
            for fixedBlock in self.shapeLayer!.fixedBlocks {
                if tempLeft == fixedBlock.left && tempTop == fixedBlock.top {
                    isCan = false
                    break
                }
            }
        }
        
        return isCan
    }
    
    func canMoveRight(shape: TRSShape) -> Bool {
        var isCan = true
        
        for shapeBlock in shape.blocks! {
            let tempTop = shape.top + shapeBlock.top
            let tempLeft = shape.left + shapeBlock.left + 1
            
            if tempLeft > self.cols - 1 {
                isCan = false
                break;
            }
            
            for fixedBlock in self.shapeLayer!.fixedBlocks {
                if tempLeft == fixedBlock.left && tempTop == fixedBlock.top {
                    isCan = false
                    break
                }
            }
        }
        
        return isCan
    }
    
    func canMoveDown(shape: TRSShape) -> Bool {
        var isCan = true
        
        for shapeBlock in shape.blocks! {
            let tempTop = shape.top + shapeBlock.top - 1
            let tempLeft = shape.left + shapeBlock.left
            
            if tempTop < 0  {
                isCan = false
                break;
            }
            
            for fixedBlock in self.shapeLayer!.fixedBlocks {
                if tempLeft == fixedBlock.left && tempTop == fixedBlock.top {
                    isCan = false
                    break
                }
            }
        }
        
        return isCan
    }
    
    func canRotateClockWise(shape: TRSShape) -> (can: Bool, offsetLeft: Int, offsetTop: Int) {
        
        var isCan = true
        var offsetLeft = 0
        let offsetTop = 0
        
        let tempShape = shape.copyRotateShape(true)
        let minLeftInLayer = tempShape.left + tempShape.minBlockLeft
        let maxLeftInLayer = tempShape.left + tempShape.maxBlockLeft
        let minTopInLayer = tempShape.top + tempShape.minBlockTop
        
        if minLeftInLayer < 0 {
            tempShape.left = tempShape.left + (-minLeftInLayer)
            if self.isCollision(tempShape) {
                isCan = false
            }
            else {
                offsetLeft = -minLeftInLayer
                print("kick right offset \(offsetLeft)")
            }
        } else if maxLeftInLayer > self.cols - 1 {
            tempShape.left = tempShape.left - (maxLeftInLayer - (self.cols - 1))
            if self.isCollision(tempShape) {
                isCan = false
            }
            else {
                offsetLeft = -(maxLeftInLayer - (self.cols - 1))
                print("kick move left offset \(-offsetLeft)")
            }
        } else if minTopInLayer < 0 {
            isCan = false
        } else {
            if self.isCollision(tempShape) {
                isCan = false
            }
        }
        
        return (isCan, offsetLeft, offsetTop)
    }
    
    func genRandomShape() -> TRSShape? {
        
        var shape: TRSShape? = nil
        let type = arc4random() % 7
        let status = arc4random() % 4
        switch type {
        case 0:
            shape = TRSShapeI.init(left: 0, top: 0, statusIndex: Int(status), imageName: "pure_1.png", unitWidth: self.blockWidth)
        case 1:
            shape = TRSShapeO.init(left: 0, top: 0, statusIndex: Int(status), imageName: "pure_2.png", unitWidth: self.blockWidth)
        case 2:
            shape = TRSShapeT.init(left: 0, top: 0, statusIndex: Int(status), imageName: "pure_3.png", unitWidth: self.blockWidth)
        case 3:
            shape = TRSShapeZ.init(left: 0, top: 0, statusIndex: Int(status), imageName: "pure_4.png", unitWidth: self.blockWidth)
        case 4:
            shape = TRSShapeZR.init(left: 0, top: 0, statusIndex: Int(status), imageName: "pure_5.png", unitWidth: self.blockWidth)
        case 5:
            shape = TRSShapeL.init(left: 0, top: 0, statusIndex: Int(status), imageName: "pure_6.png", unitWidth: self.blockWidth)
        case 6:
            shape = TRSShapeLR.init(left: 0, top: 0, statusIndex: Int(status), imageName: "pure_7.png", unitWidth: self.blockWidth)
        default:
            shape = TRSShapeI.init(left: 0, top: 0, statusIndex: Int(status), imageName: "pure_1.png", unitWidth: self.blockWidth)
        }
        
        return shape
    }
}
