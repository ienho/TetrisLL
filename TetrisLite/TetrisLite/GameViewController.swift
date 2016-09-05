//
//  GameViewController.swift
//  TetrisLite
//
//  Created by ian  on 16/9/3.
//  Copyright (c) 2016年 ian . All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var gameScene: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let skView = SKView.init(frame: UIScreen.mainScreen().bounds)
        skView.contentMode = UIViewContentMode.ScaleToFill;
        skView.showsFPS = true;
        skView.showsNodeCount = true;
        skView.backgroundColor = UIColor.lightGrayColor()
        skView.ignoresSiblingOrder = true;
        self.view = skView;
        
        let deviceScreenMode = UIScreen.mainScreen().currentMode;
        self.gameScene = GameScene.init(size: CGSize(width: (deviceScreenMode?.size.width)!, height: (deviceScreenMode?.size.height)!))
        self.gameScene!.scaleMode = .AspectFit
        self.gameScene?.backgroundColor = UIColor.darkGrayColor()
        skView.presentScene(self.gameScene)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .Portrait
        } else {
            return .Portrait
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
