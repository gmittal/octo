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

// labels
var scoreLabel = SKLabelNode(fontNamed:"HelveticaNeue-UltraLight")
var sectTappedLabel = SKLabelNode(fontNamed:"HelveticaNeue-Bold")

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

var colorList:Array = [];

var colorDisplay:SKSpriteNode = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(260, 75))
var timerDisplay:SKSpriteNode = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(260, 75))

var timeStarted:Bool = false;

var time:Float = 0.0;


class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
//        UIApplication.statusBarIsHidden = true;
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let screenCenter = CGPoint(x: 0, y: 0)
        self.backgroundColor = UIColor(red: 0.5, green: 0.55, blue: 0.553, alpha: 1.0)
//        rgba(189, 195, 199,1.0)
        
        
        scoreLabel.text = "0.00";
        scoreLabel.fontSize = 55;
        scoreLabel.position = CGPoint(x:-130, y:330)
        scoreLabel.fontColor = UIColor.blackColor()
        self.addChild(scoreLabel)

        
        sectTappedLabel.text = "None";
        sectTappedLabel.fontSize = 35;
        sectTappedLabel.position = CGPoint(x:130, y:340)
        sectTappedLabel.fontColor = UIColor.whiteColor()
        self.addChild(sectTappedLabel)

        
        player.xScale = 0.6
        player.yScale = 0.6
        player.position = screenCenter
        player.name = "player"
        self.addChild(player)
        
        initColorArray()
        initColorDisplay()
        
        
    }
    
    
    
    
    func initColorArray() {
        for (var i = 0; i < 10; i++) {
            var color:UInt32 = arc4random()%(8-1+1) + 1
            var colorPick:CDouble = CDouble(color)
            
            if (colorPick == 1) {
                colorList.append("Turquoise")
            }
            
            if (colorPick == 2) {
                colorList.append("Blue")
            }
            
            if (colorPick == 3) {
                colorList.append("Black")
            }
            
            if (colorPick == 4) {
                colorList.append("Purple")
            }
            
            if (colorPick == 5) {
                colorList.append("Red")
            }
            
            if (colorPick == 6) {
                colorList.append("Orange")
            }
            
            if (colorPick == 7) {
                colorList.append("Yellow")
            }
            
            if (colorPick == 8) {
                colorList.append("Green")
            }
        }
        
        println(colorList)
        
        let firstColor:String = String(colorList[0] as NSString)
        updateSectLabelFirstTime(firstColor)
        
        
    }
    
    
    
    func colorize (hex: Int, alpha: Double = 1.0) -> UIColor {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF)) / 255.0
        var color: UIColor = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha:CGFloat(alpha) )
        return color
    }
    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
    
    
    func updateColorDisplay(color:String) {
        if (color == String(colorList[0] as NSString)) {
            colorList.removeAtIndex(0)
            
            if (colorList.count > 0) {
                
                println(colorList)
                updateSectLabelFirstTime(String(colorList[0] as String))
            }
        }
        
    }
    
    
    func initColorDisplay() {
        colorDisplay.position = CGPoint(x:130, y:350)
        self.addChild(colorDisplay)
        
        timerDisplay.position = CGPoint(x:-130, y:350)
        self.addChild(timerDisplay)
        
    }
    
    
    
    
    
    
    func updateSectLabelFirstTime(color:String) {
        if color == "Turquoise" {
            colorDisplay.color = UIColor(red: 0.086, green: 0.63, blue: 0.52, alpha: 1.0)
        }
        
        if color == "Blue" {
            colorDisplay.color = UIColor.blueColor()
        }
        
        if color == "Black" {
            colorDisplay.color = UIColor.blackColor()
        }
        
        if color == "Purple" {
            colorDisplay.color = UIColor.purpleColor()
        }
        
        if color == "Red" {
            colorDisplay.color = UIColor.redColor()
        }
        
        if color == "Orange" {
            colorDisplay.color = UIColor.orangeColor()
        }
        
        if color == "Yellow" {
            colorDisplay.color = UIColor.yellowColor()
        }
        
        if color == "Green" {
            
            colorDisplay.color = UIColor(red: 0.18, green: 0.8, blue: 0.44, alpha: 1.0)
        }
        
        
        colorDisplay.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.1), SKAction.fadeInWithDuration(0.1)]))
//        colorDisplay.runAction(SKAction.fadeInWithDuration(0.1))
        sectTappedLabel.text = color;
        
    }
    
    
    func boundsCheck(angle: CDouble) -> String {
        var color:String = "None"
        
        if angle >= turqBound1 && angle <= turqBound2 {
            println("Turquoise tapped")
            color = "Turquoise"
        }
        
        if angle >= blueBound1 && angle <= blueBound2 {
            println("Blue tapped")
            color = "Blue"
        }
        
        if angle >= blackBound1 && angle <= blackBound2 {
            println("Black tapped")
            color = "Black"
        }
        
        if angle >= purpleBound1 && angle <= purpleBound2 {
            println("Purple tapped")
            color = "Purple"
        }
        
        if angle >= redBound1 && angle <= redBound2 {
            println("Red tapped")
            color = "Red"
        }
        
        if angle >= orangeBound1 && angle <= orangeBound2 {
            println("Orange tapped")
            color = "Orange"
        }
        
        if angle >= yellowBound1 && angle <= yellowBound2 {
            println("Yellow tapped")
            color = "Yellow"
        }
        
        if angle >= greenBound1 && angle <= greenBound2 {
            println("Green tapped")
            color = "Green"
        }
        
        return color
        
    }
    
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            let tappedNode = nodeAtPoint(location)
            
            if (tappedNode.name) {
                
                if (tappedNode.name == "player") {
                    
                    
                    let pos1:CGPoint = location
                    let pos2:CGPoint = player.position
                    
                    let deltaY:CDouble = CDouble(pos2.y) - CDouble(pos1.y)
                    let deltaX:CDouble = CDouble(pos2.x) - CDouble(pos1.x)
                    
                    let angleInDegrees = atan2(deltaY, deltaX) * 180 / M_PI
            
                    
                    
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
                    
                    
//                    println(shipAngle)
                    
                    
                    let colorTapped:String = boundsCheck(shipAngle)
                    
                    if (colorList.count > 0) {
                        updateColorDisplay(colorTapped)
                    } else {
                        var alertView = UIAlertView();
                        alertView.addButtonWithTitle("OK");
                        alertView.title = "Game Over";
                        alertView.message = "You've completed all of the colors in the colorList array.";
                        alertView.show();
                    }
                    
//                    timeStarted = true;
                    NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateTimerLabel", userInfo: nil, repeats: true)
                    
                }

                
            } else {
                println("NULL")
            }
            
            
        }
    
    }
   
    func updateTimerLabel()
    {
        time += 0.01
        scoreLabel.text = NSString(format:"%.3f", time)
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
//        if (timeStarted == true) {
////            time += (1/60)
////            scoreLabel.text = String(time)
//        }
        
        
    
        
    
    }
    
}











