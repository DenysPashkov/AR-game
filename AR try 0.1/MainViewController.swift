//
//  GameViewController.swift
//  AR try 0.1
//
//  Created by denys pashkov on 11/11/2019.
//  Copyright © 2019 denys pashkov. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit
import SceneKit
import ARKit

class GameViewController: UIViewController, ARSCNViewDelegate {
    
//  MARK: - WIP

    //decleration of stuff from storyboard
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var tries: UILabel!
    
    let configuration = ARWorldTrackingConfiguration()
    
//    MARK: - Init
    
    // on start
    override func viewDidLoad() {
        
        gestureRecognizer()
        
        memeDatabase.loadFoundMemes()
        // Set the view's delegate
        sceneView.delegate = self
                    
        // Show statistics such as fps and timing information, pointless now
        sceneView.showsStatistics = false
        
        // Create a new scene
        let scene = SCNScene(named : "main.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // object to detect
        configuration.detectionObjects = ARReferenceObject.referenceObjects(inGroupNamed: "ToFind", bundle: Bundle.main)!
        
        //Run the view's session
        sceneView.session.run(configuration)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

//    MARK: - When object is found
    
//    when the object is found
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let objectAnchor = anchor as? ARObjectAnchor {
            
            nodeAdded(node, for: objectAnchor)

        }
        
        return node

    }
    
    // pop up appearing over the found object
    func nodeAdded(_ node: SCNNode, for objectAnchor: ARObjectAnchor){
        
        let spriteKitScene = SKScene(fileNamed: "foundMemePopup.sks")
        let memeImage = spriteKitScene?.childNode(withName: "MemeImage") as? SKSpriteNode
        
        let memeIndex: Int = Int(objectAnchor.referenceObject.name!)!
        
        if !memeDatabase.memeDict[memeIndex]!.found {
            memeDatabase.memeDict[memeIndex]!.found = true
            memeDatabase.storeFoundMeme()
        }
        
        memeImage?.texture = SKTexture(imageNamed: memeDatabase.memeDict[memeIndex]!.imageName)
        
//      create the 2d plane
        let plane = SCNPlane(width: 0.4 , height: 0.4)
        plane.cornerRadius = plane.width / 8
        plane.firstMaterial?.diffuse.contents = spriteKitScene
        plane.firstMaterial?.isDoubleSided = true
        plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1), 0, 1, 0)
        
//      put it in a 3d space
        let planeNode = SCNNode(geometry : plane)
        planeNode.position = SCNVector3(objectAnchor.referenceObject.center.x, objectAnchor.referenceObject.center.y + 0.35, objectAnchor.referenceObject.center.z)
    
        node.addChildNode(planeNode)
        
        // for not saturate the memory
        planeNode.runAction(SCNAction.sequence([.wait(duration: 60),.fadeOut(duration: 1),.removeFromParentNode()]))
        
        // TODO: image is not shown anymore
    }
    
//    MARK: - Gesture Managmemt
    
//    new gesture
    private func gestureRecognizer(){
        
        let tapGestureRecognizer = UITapGestureRecognizer(target : self, action : #selector(tapped))
        
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        
    }
 
//    when you touch the pop-up
    @objc func tapped(recognizer : UIGestureRecognizer){
        
        let sceneView = recognizer.view as! SCNView
        let touchLocation = recognizer.location(in: sceneView)
        let hitResult = sceneView.hitTest(touchLocation, options: [:])
        
        if !hitResult.isEmpty{
            
            let node = hitResult[0].node
            
//          action to do when pressed
//          TODO: - add something more fancy
            node.runAction(SCNAction.sequence([.wait(duration: 1),.fadeOut(duration: 2),.removeFromParentNode()]))
            
        }
        
    }
    
//    MARK: - Transfer Information
    
//    MARK: - Stuffs
    
    // Present an error message to the user
    func session(_ session: ARSession, didFailWithError error: Error) {}
    
    // Inform the user that the session hs been interrupted, for example, by presenting an overlay
    func sessionWasInterrupted(_ session: ARSession) {}
    
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    func sessionInterruptionEnded(_ session: ARSession) {}

    func returnNumber() -> Int {

        return ARReferenceObject.referenceObjects(inGroupNamed: "ToFind", bundle: Bundle.main)!.count
        
    }
    
}
