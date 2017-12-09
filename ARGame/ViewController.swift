//
//  ViewController.swift
//  ARGame
//
//  Created by Ryan Gess on 12/3/17.
//  Copyright © 2017 Ryan Gess. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    let debug = true
    
    @IBAction func touch(_ sender: Any) {
        let bulletsNode = Projectile()
        
        let (direction, position) = self.getUserDirection()
        
        bulletsNode.position = position
        let bulletDirection = direction
        
        bulletsNode.physicsBody?.applyForce(bulletDirection, asImpulse: true)
        sceneView.scene.rootNode.addChildNode(bulletsNode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.scene.physicsWorld.contactDelegate = self
        
        addNewTarget()
        addNewTarget()
        debugMode()
    }
    
    func debugMode(){
        if (debug){
            self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
            self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin]
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = ARWorldTrackingConfiguration.PlaneDetection.horizontal
        sceneView.session.run(configuration)
    }
    
    func addNewTarget(){
        let cubeNode = Target()
        let (_, position) = self.getUserDirection()
        let x_pos = randomFloat(-0.5, and: 1.5) + position.x
        let y_pos = randomFloat(-0.5, and: 1.5) + position.y
        let z_pos = randomFloat(-0.5, and: 1.5) + position.z
        cubeNode.position = SCNVector3Make(x_pos, y_pos, z_pos)
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    
    func randomFloat(_ first: Float,  and second: Float) -> Float {
        return (Float(arc4random()) / Float(UInt32.max)) * (first - second) + second
    }
    
    func getUserDirection() -> (SCNVector3, SCNVector3) {
        if let frame = self.sceneView.session.currentFrame {
            let user_matrix = SCNMatrix4(frame.camera.transform)
            let direction = SCNVector3(-1 * user_matrix.m31, -1 * user_matrix.m32, -1 * user_matrix.m33)
            let position = SCNVector3(user_matrix.m41, user_matrix.m42, user_matrix.m43)
            return (direction, position)
        }
        return (SCNVector3(0, 0, -1), SCNVector3(0, 0, -0.2))
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            contact.nodeA.removeFromParentNode()
            contact.nodeB.removeFromParentNode()
        })
        print("Big Baller!!")
        self.addNewTarget()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

