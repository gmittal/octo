//
//  GameOverScene.swift
//  Hydrogen
//
//  Created by Christian Hansen on 6/18/14.
//  Copyright (c) 2014 Gautam Mittal. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
        self.backgroundColor = UIColor(red: 0.18, green: 0.8, blue: 0.44, alpha: 1.0)
        
        let score = SKLabelNode(fontNamed:"HelveticaNeue-UltraLight");
        score.position = CGPoint(x:0, y:0)
        if (gameMode == "Classic") {
            score.text = NSString(format:"%.2f", time)
        } else if (gameMode == "Zen") {
            score.text = NSString(format:"%.i", numCorrects)
        }
        score.fontSize = 150
        self.addChild(score)
        
        // need to wipe this before proceeding
        time = 0.0
        numCorrects = 0
        
        var highScore = SKLabelNode(fontNamed:"HelveticaNeue-Bold")
        highScore.position = CGPoint(x:0, y: -70)
        highScore.fontSize = 50
        
        if (gameMode == "Classic") {
            if (numColors == 25) {
                var highScoreFloat = NSUserDefaults.standardUserDefaults().floatForKey("twentyFiveHighScore")
                highScore.text = NSString(format:"BEST %.2f", highScoreFloat)
            }
            
            if (numColors == 50) {
                var highScoreFloat = NSUserDefaults.standardUserDefaults().floatForKey("fiftyHighScore")
                highScore.text = NSString(format:"BEST %.2f", highScoreFloat)
            }
            
            if (numColors == 100) {
                var highScoreFloat = NSUserDefaults.standardUserDefaults().floatForKey("hundredHighScore")
                highScore.text = NSString(format:"BEST %.2f", highScoreFloat)
            }
            
        } else if (gameMode == "Zen") {
            if (startTime == 15) {
                var highScoreInt = NSUserDefaults.standardUserDefaults().integerForKey("fifteenHighScore")
                highScore.text = NSString(format:"BEST %i", highScoreInt)
            }
            
            if (startTime == 30) {
                var highScoreInt = NSUserDefaults.standardUserDefaults().integerForKey("thirtyHighScore")
                highScore.text = NSString(format:"BEST %i", highScoreInt)
            }
            
            if (startTime == 45) {
                var highScoreInt = NSUserDefaults.standardUserDefaults().integerForKey("fortyFiveHighScore")
                highScore.text = NSString(format:"BEST %i", highScoreInt)
            }
        }
        
        self.addChild(highScore)
        
        let exit = SKSpriteNode(imageNamed:"exitButton")
        exit.position = CGPoint(x:0, y:-160)
        exit.xScale = 1.5
        exit.yScale = 1.5
        exit.name = "exit"
        self.addChild(exit)
        
        let again = SKSpriteNode(imageNamed:"againButton")
        again.position = CGPoint(x:0, y:-230)
        again.xScale = 1.5
        again.yScale = 1.5
        again.name = "again"
        self.addChild(again)
    }
    
    func presentStartMenu() {
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Right, duration: 0.5)
        
        let scene = StartMenuScene(size: self.scene.size)
        scene.scaleMode = SKSceneScaleMode.AspectFill
        
        self.scene.view.presentScene(scene, transition: transition)
    }
    
    func presentGameScene() {
        let transition = SKTransition.crossFadeWithDuration(0.6)
        
        let scene = GameScene(size: self.scene.size)
        scene.scaleMode = SKSceneScaleMode.AspectFill
        
        self.scene.view.presentScene(scene, transition: transition)
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            let tappedNode = nodeAtPoint(location)
            
            if (tappedNode.name) {
                if (tappedNode.name == "exit") {
                    //                    scoreLabel.removeFromParent()
                    self.removeAllChildren()
                    scoreLabelAdded = false;
                    sectLabelAdded = false;
                    colorDisplay1Added = false;
                    colorDisplay0Added = false;
                    playerAdded = false;
                    
                    timeLeft = 0
                    
                    presentStartMenu()
                }
                
                if (tappedNode.name == "again") {
                    //                    scoreLabel.removeFromParent()
                    self.removeAllChildren()
                    
                    scoreLabelAdded = false;
                    sectLabelAdded = false;
                    colorDisplay1Added = false;
                    colorDisplay0Added = false;
                    playerAdded = false;
                    
                    timeLeft = 0
                    
                    presentGameScene()
                }
            }
        }
    }
}