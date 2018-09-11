//
//  ViewController.swift
//  ARDraw
//
//  Created by vld on 5/17/18.
//  Copyright © 2018 vld. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var button: UIButton!
    
    var color: UIColor = UIColor.black
    var size: CGFloat = 0.01
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    
    @IBOutlet weak var magentaButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var cyanButton: UIButton!
    @IBOutlet weak var whiteButton: UIButton!
    
    @IBOutlet weak var sizeIncrease: UIButton!
    @IBOutlet weak var sizeDecrease: UIButton!
    
    @IBAction func reset(_ sender: UIButton) {
        restartSession()
    }
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration() //track the position and orientation
    
override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin,ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.showsStatistics = true
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
    
        // Do any additional setup after loading the view, typically from a nib.
    }

override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard let pointOfView = sceneView.pointOfView else {return}                //current location of orientation
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31,-transform.m32,-transform.m33)
        let location = SCNVector3(transform.m41,transform.m42,transform.m43)
        let currentPositionOfCamera = orientation + location                       

        if self.button.isHighlighted {
            let sphereNode = SCNNode(geometry: SCNSphere(radius: self.size))
            sphereNode.position = currentPositionOfCamera
            self.sceneView.scene.rootNode.addChildNode(sphereNode)
            sphereNode.geometry?.firstMaterial?.diffuse.contents = self.color
            sphereNode.geometry?.firstMaterial?.specular.contents = UIColor.white
    }
//        } else {
//            let pointer = SCNNode(geometry: SCNBox(width: 0.01, height: 0.01, length: 0.01, chamferRadius: 0.01/2))
//            pointer.position = currentPositionOfCamera
//
//            self.sceneView.scene.rootNode.enumerateChildNodes({(node, _) in
//                if node.geometry is SCNBox {
//                    node.removeFromParentNode()
//                }
//            })
//            pointer.geometry?.firstMaterial?.diffuse.contents = UIColor.red
//        }
    
        buttonType(button: redButton)
        buttonType(button: greenButton)
        buttonType(button: blueButton)
        buttonType(button: yellowButton)
        buttonType(button: magentaButton)
        buttonType(button: orangeButton)
        buttonType(button: cyanButton)
        buttonType(button: whiteButton)
        buttonType(button: sizeIncrease)
        buttonType(button: sizeDecrease)
    
        if sizeIncrease.isHighlighted {
            self.size += 0.002
        }
        if sizeDecrease.isHighlighted {
            self.size -= 0.002
                if self.size <= 0 {
                    self.size = 0
                }
        }
    
        if redButton.isHighlighted {
            self.color = UIColor.red
        }
        
        if greenButton.isHighlighted {
            self.color = UIColor.green
        }
        
        if blueButton.isHighlighted {
            self.color = UIColor.blue
        }
        
        if yellowButton.isHighlighted {
            self.color = UIColor.yellow
        }
        
        if magentaButton.isHighlighted {
            self.color = UIColor.magenta
        }
        
        if orangeButton.isHighlighted {
            self.color = UIColor.orange
        }
        
        if cyanButton.isHighlighted {
            self.color = UIColor.cyan
        }
        
        if whiteButton.isHighlighted {
            self.color = UIColor.white
        }
    }
    
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes {(node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.removeExistingAnchors,.resetTracking])
    }
    
    func buttonType (button: UIButton) {
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
    }
}

func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}

