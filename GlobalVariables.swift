//
//  GlobalVariables.swift
//  Hydrogen
//
//  Created by Christian Hansen on 6/18/14.
//  Copyright (c) 2014 Gautam Mittal. All rights reserved.
//

import Foundation
import SpriteKit

// initialize globals

var shipAngle:CDouble = 0

// labels
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

let colorDictionary = ["turq": turquoise,
    "blue": blue,
    "black": black,
    

]

var timer:NSTimer = NSTimer();
var gameMode:String = String();

// zen mode
var numCorrects:Int = 0;
var startTime = 0;
var timeLeft = 0;

var scoreLabelAdded:Bool = false;
var sectLabelAdded:Bool = false;
var colorDisplay1Added:Bool = false;
var colorDisplay0Added:Bool = false;
var playerAdded:Bool = false;

var scoreLabelTag:Int = 0;
var sectLabelTag:Int = 0;
var colorDisplay1Tag:Int = 0;
var colorDisplay0Tag:Int = 0;
var playerTag:Int = 0;

