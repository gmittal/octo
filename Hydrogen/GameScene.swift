//
//  GameScene.swift
//  Hydrogen
//
//  Created by Gautam Mittal on 6/5/14.
//  Copyright (c) 2014 Gautam Mittal. All rights reserved.
//

import SpriteKit
// initialize globals
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

var numColors:Int = 0;

// colors
let turquoise:UIColor = UIColor(red: 0.086, green: 0.63, blue: 0.52, alpha: 1.0)
let blue:UIColor = UIColor(red: 0.161, green: 0.501, blue: 0.725, alpha: 1.0)
let black:UIColor = UIColor(red:0.173, green:0.243, blue:0.314, alpha:1.0)
let purple:UIColor = UIColor(red:0.557, green:0.267, blue:0.678, alpha:1.0)
let red:UIColor = UIColor(red: 0.91, green:0.298, blue:0.235, alpha:1.0)
let orange:UIColor = UIColor(red: 0.902, green:0.494, blue:0.133, alpha:1.0)
let yellow:UIColor = UIColor(red: 0.945, green:0.769, blue:0.059, alpha:1.0)
let green:UIColor = UIColor(red:0.18, green:0.8, blue:0.443, alpha: 1.0)

var timer:NSTimer = NSTimer();


// game scene class
class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
//        UIApplication.statusBarIsHidden = true;
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let screenCenter = CGPoint(x: 0, y: 0)
//        self.backgroundColor = UIColor.whiteColor()
//        self.backgroundColor = UIColor(red: 0.5, green: 0.55, blue: 0.553, alpha: 1.0)
//        rgba(189, 195, 199,1.0)
        
        
        let background = SKSpriteNode(imageNamed:"gameBackground")
        background.position = CGPoint(x:0, y:0)
        background.xScale = 1.7
        background.yScale = 1.7
        background.zPosition = -1000
        self.addChild(background)
        
        scoreLabel.text = "0.000";
        scoreLabel.fontSize = 55;
        scoreLabel.position = CGPoint(x:-130, y:330)
        scoreLabel.fontColor = UIColor.blackColor()
        self.addChild(scoreLabel)

        
        sectTappedLabel.text = "None";
        sectTappedLabel.fontSize = 35;
        sectTappedLabel.position = CGPoint(x:130, y:340)
//        if (self.frame)
        sectTappedLabel.fontColor = UIColor.whiteColor()
        self.addChild(sectTappedLabel)

        
        player.xScale = 1.2
        player.yScale = 1.2
        player.position = screenCenter
        player.name = "player"
        self.addChild(player)
        
        initColorArray()
        initColorDisplay()
        
        
    }
    
    
    // initialize color array
    
    func initColorArray() {
        for (var i = 0; i < numColors; i++) {
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
            } else {
                timeStarted = false
                
                // Set high score for game of 25
                if (numColors == 25) {

                    if (NSUserDefaults.standardUserDefaults().floatForKey("twentyFiveHighScore") == 0.0) {
                        NSUserDefaults.standardUserDefaults().setFloat(time, forKey: "twentyFiveHighScore")
                    }
                    
                    if (time < NSUserDefaults.standardUserDefaults().floatForKey("twentyFiveHighScore")) {
                        NSUserDefaults.standardUserDefaults().setFloat(time, forKey: "twentyFiveHighScore")
                    }
                }
                
                
                if (numColors == 50) {
                    
                    if (NSUserDefaults.standardUserDefaults().floatForKey("fiftyHighScore") == 0.0) {
                        NSUserDefaults.standardUserDefaults().setFloat(time, forKey: "fiftyHighScore")
                    }
                    
                    if (time < NSUserDefaults.standardUserDefaults().floatForKey("fiftyHighScore")) {
                        NSUserDefaults.standardUserDefaults().setFloat(time, forKey: "fiftyHighScore")
                    }
                }
                
                
                if (numColors == 100) {
                    
                    if (NSUserDefaults.standardUserDefaults().floatForKey("hundredHighScore") == 0.0) {
                        NSUserDefaults.standardUserDefaults().setFloat(time, forKey: "hundredHighScore")
                    }
                    
                    if (time < NSUserDefaults.standardUserDefaults().floatForKey("hundredHighScore")) {
                        NSUserDefaults.standardUserDefaults().setFloat(time, forKey: "hundredHighScore")
                    }
                }
                
                
                
                self.removeAllChildren()
                timer.invalidate()
                
                colorList = []
                gameOverTransition()
            }
        } else {
            self.removeAllChildren()
            timeStarted = false;
            colorList = []
            timer.invalidate()
            time = 0.0
//            println(colorList)
            presentFailureScene()
            
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
            colorDisplay.color = turquoise
        }
        
        if color == "Blue" {
            colorDisplay.color = blue
        }
        
        if color == "Black" {
            colorDisplay.color = black
        }
        
        if color == "Purple" {
            colorDisplay.color = purple
        }
        
        if color == "Red" {
            colorDisplay.color = red
        }
        
        if color == "Orange" {
            colorDisplay.color = orange
        }
        
        if color == "Yellow" {
            colorDisplay.color = yellow
        }
        
        if color == "Green" {
            
            colorDisplay.color = green
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
                    
                    
                    
                    if (timeStarted == false) {
                        timeStarted = true;
                        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateTimerLabel", userInfo: nil, repeats: true)
                    }
                    
                    
                    
                    if (colorList.count > 0) {
                        updateColorDisplay(colorTapped)
                    } else {
                        timeStarted = false;
//                        var alertView = UIAlertView();
//                        alertView.addButtonWithTitle("OK");
//                        alertView.title = "Game Over";
//                        alertView.message = "You've completed all of the colors in the colorList array.";
//                        alertView.show();
                    }
                    
//                    timeStarted = true;
                    
                    
                    
                }

                
            } else {
                println("NULL")
            }
            
            
        }
    
    }
   
    func updateTimerLabel()
    {
        if (timeStarted == true) {
            time += 0.01
            scoreLabel.text = NSString(format:"%.3f", time)
        }
        
    }
    
    
    
    func gameOverTransition() {
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 0.5)
        
        let scene = GameOverScene(size: self.scene.size)
        scene.scaleMode = SKSceneScaleMode.AspectFill
        
        self.scene.view.presentScene(scene, transition: transition)
    }
    
    
    func presentFailureScene() {
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 0.5)
        
        let scene = GameFailScene(size: self.scene.size)
        scene.scaleMode = SKSceneScaleMode.AspectFill
        
        self.scene.view.presentScene(scene, transition: transition)
    }
    
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
//        if (timeStarted == true) {
////            time += (1/60)
////            scoreLabel.text = String(time)
//        }
        
        if (colorList.count == 0) {
//            timeStarted = false;
        
//            gameOverTransition()
//            self.removeAllChildren()
        }
        
    
        
    
    }
    
}


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
        
        let twentyFive = SKSpriteNode(imageNamed:"twentyFiveButton")
        twentyFive.position = CGPoint(x:0, y:0)
        twentyFive.xScale = 1.5
        twentyFive.yScale = 1.5
        twentyFive.name = "twentyFive"
        self.addChild(twentyFive)
        
        let fifty = SKSpriteNode(imageNamed:"fiftyButton")
        fifty.position = CGPoint(x:0, y:-70)
        fifty.xScale = 1.5
        fifty.yScale = 1.5
        fifty.name = "fifty"
        self.addChild(fifty)
        
        let hundred = SKSpriteNode(imageNamed:"hundredButton")
        hundred.position = CGPoint(x:0, y:-140)
        hundred.xScale = 1.5
        hundred.yScale = 1.5
        hundred.name = "hundred"
        self.addChild(hundred)
        
        titleSprite.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(1, duration: 0.8)))
        
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
                if (tappedNode.name == "twentyFive") {
                    numColors = 25
                    presentGameScene()
                    
                }
                
                
                if (tappedNode.name == "fifty") {
                    numColors = 50
                    presentGameScene()
                    
                }
                
                
                if (tappedNode.name == "hundred") {
                    numColors = 100
                    presentGameScene()
                    
                }
            }
            
            
        }
        
    }

}




class GameFailScene: SKScene {
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
        self.backgroundColor = UIColor(red: 0.91, green: 0.3, blue: 0.235, alpha: 1.0)
        
        // rgba(231, 76, 60,1.0)
        
        let score = SKLabelNode(fontNamed:"HelveticaNeue-UltraLight");
        score.position = CGPoint(x:0, y:0)
        score.text = "Failed" //NSString(format:"%.2f", time)
        score.fontSize = 150
        self.addChild(score)
        
        
        var highScore = SKLabelNode(fontNamed:"HelveticaNeue-Bold")
        highScore.position = CGPoint(x:0, y: -70)
        highScore.fontSize = 50
        
        
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
                    presentStartMenu()
                    
                }
                
                if (tappedNode.name == "again") {
                    presentGameScene()
                }
            }
            
        }
        
    }
}


class GameOverScene: SKScene {
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
        self.backgroundColor = UIColor(red: 0.18, green: 0.8, blue: 0.44, alpha: 1.0)
        
        let score = SKLabelNode(fontNamed:"HelveticaNeue-UltraLight");
        score.position = CGPoint(x:0, y:0)
        score.text = NSString(format:"%.2f", time)
        score.fontSize = 150
        self.addChild(score)
        
        // need to wipe this before proceeding
        time = 0.0
        
        var highScore = SKLabelNode(fontNamed:"HelveticaNeue-Bold")
        highScore.position = CGPoint(x:0, y: -70)
        highScore.fontSize = 50
        
        
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
                    presentStartMenu()
                    
                }
                
                if (tappedNode.name == "again") {
                    presentGameScene()
                }
            }
            
        }
        
    }
}






