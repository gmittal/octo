//
//  StartMenuScene.swift
//  Hydrogen
//
//  Created by Christian Hansen on 6/18/14.
//  Copyright (c) 2014 Gautam Mittal. All rights reserved.
//

import Foundation
import SpriteKit

class StartMenuScene:SKScene {
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
        self.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let title = SKLabelNode(fontNamed: "Avenir Next")
        title.text = "OCTO"
        title.position = CGPoint(x:0, y: 100)
        title.fontColor = UIColor.blackColor()
        title.fontSize = 100
        self.addChild(title)
        
        let titleSprite = SKSpriteNode(imageNamed:"player")
        titleSprite.xScale = 0.26
        titleSprite.yScale = 0.26
        titleSprite.position = CGPoint(x: 105, y:136)
        titleSprite.zPosition = 1000
        self.addChild(titleSprite)
        
        
        let background = SKSpriteNode(imageNamed:"background")
        background.position = CGPoint(x:0, y:0)
        background.xScale = 1.7
        background.yScale = 1.7
        background.zPosition = -1000
        self.addChild(background)
        
        let twentyFive = SKSpriteNode(imageNamed:"classicButton")
        twentyFive.position = CGPoint(x:0, y:-1000)
        twentyFive.xScale = 1.5
        twentyFive.yScale = 1.5
        twentyFive.name = "classic"
        self.addChild(twentyFive)
        
        let fifty = SKSpriteNode(imageNamed:"zenButton")
        fifty.position = CGPoint(x:0, y:-1070)
        fifty.xScale = 1.5
        fifty.yScale = 1.5
        fifty.name = "zen"
        self.addChild(fifty)
        
        let hundred = SKSpriteNode(imageNamed:"stressButton")
        hundred.position = CGPoint(x:0, y:-1140)
        hundred.xScale = 1.5
        hundred.yScale = 1.5
        hundred.name = "stress"
        self.addChild(hundred)
        
        twentyFive.runAction(SKAction.moveToY(0, duration: 0.8))
        fifty.runAction(SKAction.moveToY(-70, duration: 0.8))
        hundred.runAction(SKAction.moveToY(-140, duration: 0.8))
        
        titleSprite.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(1, duration: 0.8)))
        
        //gesture recognizers
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func presentGameScene() {
        let transition = SKTransition.crossFadeWithDuration(0.6)
        
        let scene = ClassicMenuScene(size: self.scene.size)
        scene.scaleMode = SKSceneScaleMode.AspectFill
        
        self.scene.view.presentScene(scene, transition: transition)
    }
    
    func zenGameScene() {
        let transition = SKTransition.crossFadeWithDuration(0.6)
        
        let scene = ZenMenuScene(size: self.scene.size)
        scene.scaleMode = SKSceneScaleMode.AspectFill
        
        self.scene.view.presentScene(scene, transition: transition)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
    
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            let tappedNode = nodeAtPoint(location)
            
            if (tappedNode.name) {
                if (tappedNode.name == "classic") {
                    //                    numColors = 25
                    presentGameScene()
                }
                
                if (tappedNode.name == "zen") {
                    //                    numColors = 50
                    zenGameScene()
                    println("Zen")
                }
                
                if (tappedNode.name == "stress") {
                    //                    numColors = 100
                    //                    presentGameScene()
                }
            }
        }
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                println("Swiped right")
            case UISwipeGestureRecognizerDirection.Left:
                println("Swiped left")
            default:
                break
            }
        }
    }

}