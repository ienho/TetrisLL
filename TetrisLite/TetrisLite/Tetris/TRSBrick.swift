//
//  TRSBrick.swift
//  TetrisLite
//
//  Created by ian  on 16/9/3.
//  Copyright © 2016年 ian . All rights reserved.
//

import SpriteKit

public class TRSBrick: SKSpriteNode {
    
    var left : Int = 0 {
        didSet {
            self.setPosition()
        }
    }
    var top : Int = 0 {
        didSet {
            self.setPosition()
        }
    }
    var width : CGFloat = 0.0 {
        didSet {
            self.setSize()
        }
    }
    var imageName : String? {
        didSet {
            if (imageName != nil) {
                self.texture = SKTexture(imageNamed: imageName!)
            }
        }
    }
    var fixed : Bool = false
    
    func setPosition() -> () {
        self.position = CGPoint(x: width * CGFloat(left), y: width * CGFloat(top))
    }
    
    func setSize() -> () {
        self.size = CGSize(width: width, height: width)
    }
    
    convenience init(left : Int, top : Int, width : CGFloat, imageName : String) {
        self.init(imageNamed : imageName)
        self.imageName = imageName
        self.left = left
        self.top = top
        self.width = width
        
        self.texture = SKTexture(imageNamed: imageName)
        self.setPosition()
        self.setSize()
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size:size)
    }
    
    override public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInt(Int32(self.left), forKey:"left")
        aCoder.encodeInt(Int32(self.top), forKey:"top")
        aCoder.encodeFloat(Float(self.width), forKey: "width")
        aCoder.encodeObject(self.imageName, forKey: "imageName")
        aCoder.encodeCGPoint(self.anchorPoint, forKey: "anchorPoint")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.left = Int(aDecoder.decodeIntForKey("left"));
        self.top = Int(aDecoder.decodeIntForKey("top"));
        self.width = CGFloat(aDecoder.decodeFloatForKey("width"));
        self.imageName = aDecoder.decodeObjectForKey("imageName") as! String?;
        self.anchorPoint = aDecoder.decodeCGPointForKey("anchorPoint")
    }

    override public var description: String {

        return "left:\(left) top:\(top) width:\(width) imageName:\(imageName)"
    }
}
