//
//  ViewController.swift
//  SceneKitTest
//
//  Created by Andres Rojas on 6/26/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {

    // MARK: - Properties

    private lazy var sceneView: SCNView = {
        let view = SCNView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var scene = SCNScene()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(sceneView)

        setupConstraints()

        setupScene()

        setupLights()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }

    private func setupScene() {
        sceneView.backgroundColor = .white
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = false

        let plane = SCNPlane(width: 1.0, height: 1.0)
        plane.firstMaterial?.diffuse.contents = UIColor.blue
        let planeNode = SCNNode(geometry: plane)

        scene.rootNode.addChildNode(planeNode)

        let cylinder = SCNCylinder(radius: 1.0, height: 1.0)
//        cylinder.firstMaterial?.diffuse.contents = UIColor.yellow

        let textureMaterial = SCNMaterial()


        textureMaterial.diffuse.contents = UIColor.yellow
        textureMaterial.multiply.contents = UIImage(named: "roughness")
        textureMaterial.roughness.contents = UIImage(named: "roughness")
        textureMaterial.metalness.contents = UIImage(named: "metalness")

//        textureMaterial.multiply.wrapS = .repeat
//        textureMaterial.multiply.wrapT = .repeat
//        textureMaterial.multiply.minificationFilter = .none
//        textureMaterial.multiply.mipFilter = .none

        textureMaterial.isDoubleSided = true
        textureMaterial.lightingModel = .physicallyBased

        cylinder.materials = [textureMaterial]

        let cylinderNode = SCNNode(geometry: cylinder)
        cylinderNode.position = SCNVector3(x: 0, y: 0, z: 0.0)

        scene.rootNode.addChildNode(cylinderNode)

    }

    private func setupLights() {
        let spotLight = SCNLight()
        spotLight.type = .spot
        spotLight.spotInnerAngle = 45
        spotLight.spotOuterAngle = 45
        spotLight.intensity = 500
        spotLight.temperature = 6000

        let spotNode = SCNNode()
        spotNode.light = spotLight
        spotNode.position = SCNVector3(10, 10, 10)
        spotNode.look(at: SCNVector3(0, 0, 0))

        let spotLight2 = SCNLight()
        spotLight2.type = .spot
        spotLight2.spotInnerAngle = 45
        spotLight2.spotOuterAngle = 45
        spotLight2.intensity = 500
        spotLight2.temperature = 6000

        let spotNode2 = SCNNode()
        spotNode2.light = spotLight2
        spotNode2.position = SCNVector3(-10, -10, -10)
        spotNode2.look(at: SCNVector3(0, 0, 0))

        let ambientLight = SCNLight()
        ambientLight.type = .ambient
        ambientLight.intensity = 400
        ambientLight.temperature = 6000

        let ambientNode = SCNNode()
        ambientNode.position = SCNVector3(10, 10, 0)
        ambientNode.look(at: SCNVector3(0, 0, 0))

        scene.rootNode.addChildNode(spotNode)
        scene.rootNode.addChildNode(spotNode2)
        scene.rootNode.addChildNode(ambientNode)
    }

}

