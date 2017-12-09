//
//  Projectile.swift
//  ARGame
//
//  Created by Ryan Gess on 12/3/17.
//  Copyright © 2017 Ryan Gess. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class Projectile: SCNNode {
    
    override init(){
        super.init()
        let sphere = SCNSphere(radius: 0.05)
        self.geometry = sphere
        let physics_shape = SCNPhysicsShape(geometry: sphere, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: physics_shape)
        self.physicsBody?.isAffectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionCategory.projectile.rawValue
        self.physicsBody?.contactTestBitMask = CollisionCategory.target.rawValue
        self.physicsBody?.mass = 0.05
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
