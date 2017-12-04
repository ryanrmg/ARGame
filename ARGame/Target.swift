//
//  Target.swift
//  ARGame
//
//  Created by Ryan Gess on 12/3/17.
//  Copyright © 2017 Ryan Gess. All rights reserved.
//

import UIKit
import SceneKit


class Target: SCNNode {
    override init(){
        super.init()
        let target = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        self.geometry = target
        let physics_shape = SCNPhysicsShape(geometry: target, options: nil)
        target.firstMaterial?.diffuse.contents = UIColor.blue 
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: physics_shape)
        self.physicsBody?.isAffectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionCategory.target.rawValue
        self.physicsBody?.contactTestBitMask = CollisionCategory.projectile.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct CollisionCategory: OptionSet {
        let rawValue: Int
        
        static let projectile  = CollisionCategory(rawValue: 1 << 0)
        static let target = CollisionCategory(rawValue: 1 << 1)
    }
}
