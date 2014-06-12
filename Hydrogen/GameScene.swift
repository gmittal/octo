//
//  GameScene.swift
//  Hydrogen
//
//  Created by Gautam Mittal on 6/5/14.
//  Copyright (c) 2014 Gautam Mittal. All rights reserved.
//

import SpriteKit

let player = SKSpriteNode(imageNamed:"player")
var shipAngle:CDouble = 0

var turqBound1:CDouble = 0
var turqBound2:CDouble = turqBound1 + 45
var blueBound1:CDouble = turqBound2
var blueBound2:CDouble = blueBound1 + 45
var blackBound1:CDouble = blueBound2
var blackBound2:CDouble = blackBound1 + 45
var purpleBound1:CDouble = blackBound2
var purpleBound2:CDouble = purpleBound1 + 45
var redBound1:CDouble = purpleBound2
var redBound2:CDouble = redBound1 + 45
var orangeBound1:CDouble = redBound2
var orangeBound2:CDouble = orangeBound1 + 45
var yellowBound1:CDouble = orangeBound2
var yellowBound2:CDouble = yellowBound1 + 45
var greenBound1:CDouble = yellowBound2
var greenBound2:CDouble = greenBound1 + 45



class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let screenCenter = CGPoint(x: 0, y: 0)
        self.backgroundColor = UIColor.whiteColor()
        
        let myLabel = SKLabelNode(fontNamed:"HelveticaNeue-UltraLight")
        myLabel.text = "Patternz";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:0, y:0)
        myLabel.fontColor = UIColor.blackColor()

        
    
        
        // The sprites for the sectors
        
        player.xScale = 0.5
        player.yScale = 0.5
        player.position = screenCenter
        self.addChild(player)
        
//        player.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(1, duration: 2)))
        
        
        
        
        
        
    }
    
    
    func radiansToDegrees(radians: CFloat) -> CFloat {
        return radians * CGFloat(180.0/(3.14159265358979323846264338327))
        
    }
    
    
    func boundsCheck(angle: CDouble) {
        if angle >= turqBound1 && angle <= turqBound2 {
            println("Turqoise tapped")
        }
        
        if angle >= blueBound1 && angle <= blueBound2 {
            println("Blue tapped")
        }
        
        if angle >= blackBound1 && angle <= blackBound2 {
            println("Black tapped")
        }
        
        if angle >= purpleBound1 && angle <= purpleBound2 {
            println("Purple tapped")
        }
        
        if angle >= redBound1 && angle <= redBound2 {
            println("Red tapped")
        }
        
        if angle >= orangeBound1 && angle <= orangeBound2 {
            println("Orange tapped")
        }
        
        if angle >= yellowBound1 && angle <= yellowBound2 {
            println("Yellow tapped")
        }
        
        if angle >= greenBound1 && angle <= greenBound2 {
            println("Green tapped")
        }
        
        
    }
    
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            
            let pos1:CGPoint = location
            let pos2:CGPoint = player.position
            
            let deltaY:CDouble = CDouble(pos2.y) - CDouble(pos1.y)
            let deltaX:CDouble = CDouble(pos2.x) - CDouble(pos1.x)
            
            let angleInDegrees = atan2(deltaY, deltaX) * 180 / M_PI
            
//            println(angleInDegrees)
            
            
            
            
            if(pos1.y - pos2.y > 0)
            {
                if(pos1.x - pos2.x < 0)
                {
                    shipAngle = (90-angleInDegrees);
                }
                else if(pos1.x - pos2.x > 0)
                {
                    shipAngle = (90-angleInDegrees);
                }
            }
            else if(pos1.y - pos2.y < 0)
            {
                if(pos1.x - pos2.x < 0)
                {
                    shipAngle = (-270-angleInDegrees);
                }
                else if(pos1.x - pos2.x > 0)
                {
                    shipAngle = (90-angleInDegrees);
                }
            }
            
            if (shipAngle < 0)
            {
                shipAngle+=360;
            }
            
            
            if (shipAngle == 0) {
//                shipAngle = 90;
            }
            
            
            println(shipAngle)

            
            boundsCheck(shipAngle)
            
            
            
        }
    
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    
    }
    
}
