//
//  GameScene.swift
//  Hydrogen
//
//  Created by Gautam Mittal on 6/5/14.
//  Copyright (c) 2014 Gautam Mittal. All rights reserved.
//


import SpriteKit

var colorList:Array = [];

// game scene class
class GameScene: SKScene {

    // class scope objects
    var scoreLabel = SKLabelNode(fontNamed:"HelveticaNeue-UltraLight")
    var sectTappedLabel = SKLabelNode(fontNamed:"HelveticaNeue-Bold")
    
    let player = SKSpriteNode(imageNamed:"player")
    
    var colorDisplay:SKSpriteNode = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(260, 75))
    var timerDisplay:SKSpriteNode = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(260, 75))
    var selfHeight:CGFloat = CGFloat()
    var selfWidth:CGFloat = CGFloat()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //        UIApplication.statusBarIsHidden = true;
        
        selfHeight = self.view.bounds.size.height
        selfWidth = self.view.bounds.size.width;
        //        CGFloat boxHeight=box.bounds.size.height;
        //        CGFloat boxWidth=box.bounds.size.width;
        
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
        
        scoreLabel.text = "0";
        scoreLabel.fontSize = 55;
        
        println(selfHeight) // if 568, the device is an iPhone 5, otherwise, it is an iPhone 4S
        
        scoreLabel.position = CGPoint(x:-130, y:330)
        
        // iPhone 5 positioning
        if (selfHeight == 568.0) {
            scoreLabel.position = CGPoint(x:-110, y:330)
        }
        
        scoreLabel.fontColor = UIColor.blackColor()
        //        scoreLabel.name = NSString(format:"%i", scoreLabel)
        
        if (scoreLabelAdded == false) {
            scoreLabelAdded = true;
            self.addChild(scoreLabel)
        }
        
        sectTappedLabel.text = "None";
        sectTappedLabel.fontSize = 35;
        sectTappedLabel.position = CGPoint(x:130, y:340)
        
        if (selfHeight == 568.0) {
            sectTappedLabel.position = CGPoint(x:110, y:340)
        }
        
        //        if (self.frame)
        sectTappedLabel.fontColor = UIColor.whiteColor()
        sectTappedLabel.name = NSString(format:"%i", sectTappedLabel)
        
        if (sectLabelAdded == false) {
            sectLabelAdded = true;
            self.addChild(sectTappedLabel)
        }
        
        player.xScale = 1.2
        player.yScale = 1.2
        
        if (selfHeight == 568.0) {
            player.xScale = 1.0
            player.yScale = 1.0
        }
        
        player.position = screenCenter
        player.name = "player"
        //        player. = playerTag
        if (playerAdded == false) {
            playerAdded = true
            self.addChild(player)
        }
        initColorArray()
        initColorDisplay()
    }
    
    // initialize color array

    func initColorArray() {
        for (var i = 0; i < numColors; i++) {
            var color:UInt32 = arc4random()%(8-1+1) + 1
            var colorPick:CDouble = CDouble(color)
            
            switch colorPick {
            case 1:
                colorList.append("Turquoise")
            case 2:
                colorList.append("Blue")
            case 3:
                colorList.append("Black")
            case 4:
                colorList.append("Purple")
            case 5:
                colorList.append("Red")
            case 6:
                colorList.append("Orange")
            case 7:
                colorList.append("Yellow")
            case 8:
                colorList.append("Green")
            default:
                println("Error: Shouldn't fall through to default")
            }
        }
        
        println("\(colorList)")
        
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
                
                if (gameMode == "Zen") {
                    numCorrects++;
                    updateTimerLabel()
                }
                
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
                //                self.removeAllChildren()
                timer.invalidate()
                
                colorList = []
                gameOverTransition()
            }
        } else {
            //            self.removeAllChildren()
            timeStarted = false;
            colorList = []
            timer.invalidate()
            time = 0.0
            numCorrects = 0
            //            println(colorList)
            presentFailureScene()
        }
    }
    
    func initColorDisplay() {
        colorDisplay.position = CGPoint(x:130, y:350)
        colorDisplay.name = NSString(format:"%i", colorDisplay0Tag)
        if (colorDisplay0Added == false) {
            colorDisplay0Added = true;
            self.addChild(colorDisplay)
        }
        
        timerDisplay.position = CGPoint(x:-130, y:350)
        timerDisplay.name = NSString(format:"%i", colorDisplay1Tag)
        if (colorDisplay1Added == false) {
            colorDisplay1Added = true
            self.addChild(timerDisplay)
        }
    }
    
    func updateSectLabelFirstTime(color:String) {
        //TODO enumerate colors to avoid strings and cover all cases without default

        switch color {
        case "Turquoise":
            colorDisplay.color = turquoise
        case "Blue":
            colorDisplay.color = blue
        case "Black":
            colorDisplay.color = black
        case "Purple":
            colorDisplay.color = purple
        case "Red":
            colorDisplay.color = red
        case "Orange":
            colorDisplay.color = orange
        case "Yellow":
            colorDisplay.color = yellow
        case "Green":
            colorDisplay.color = green
        default:
            println("Error: Shouldn't fall through to default")
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
                    
                    
                    if (gameMode == "Classic") {
                        if (timeStarted == false) {
                            timeStarted = true;
                            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateTimerLabel", userInfo: nil, repeats: true)
                        }
                    }
                    
                    if (gameMode == "Zen") {
                        if (timeStarted == false) {
                            timeStarted = true;
                            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "checkTimerForZen", userInfo: nil, repeats: true)
                        }
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
        if (gameMode == "Classic") {
            if (timeStarted == true) {
                time += 0.01
                scoreLabel.text = NSString(format:"%.3f", time)
            }
        }
        
        if (gameMode == "Zen") {
            scoreLabel.text = NSString(format:"%i", numCorrects)
        }
        
    }

    func checkTimerForZen() {
        timeLeft++
        println(timeLeft)
        if (timeLeft == startTime) {
            timeLeft = 0
            timer.invalidate()
            timeStarted = false
            
            if (startTime == 15) {
                
                if (NSUserDefaults.standardUserDefaults().integerForKey("fifteenHighScore") == 0) {
                    NSUserDefaults.standardUserDefaults().setInteger(numCorrects, forKey: "fifteenHighScore")
                }
                
                if (numCorrects > NSUserDefaults.standardUserDefaults().integerForKey("fifteenHighScore")) {
                    NSUserDefaults.standardUserDefaults().setInteger(numCorrects, forKey: "fifteenHighScore")
                }
            }
            
            if (startTime == 30) {
                
                if (NSUserDefaults.standardUserDefaults().integerForKey("thirtyHighScore") == 0) {
                    NSUserDefaults.standardUserDefaults().setInteger(numCorrects, forKey: "thirtyHighScore")
                }
                
                if (numCorrects > NSUserDefaults.standardUserDefaults().integerForKey("thirtyHighScore")) {
                    NSUserDefaults.standardUserDefaults().setInteger(numCorrects, forKey: "thirtyHighScore")
                }
            }
        
            if (startTime == 45) {
                
                if (NSUserDefaults.standardUserDefaults().integerForKey("fortyFiveHighScore") == 0) {
                    NSUserDefaults.standardUserDefaults().setInteger(numCorrects, forKey: "fortyFiveHighScore")
                }
                
                if (numCorrects > NSUserDefaults.standardUserDefaults().integerForKey("fortyFiveHighScore")) {
                    NSUserDefaults.standardUserDefaults().setInteger(numCorrects, forKey: "fortyFiveHighScore")
                }
            }
            gameOverTransition()
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
    }
    
}