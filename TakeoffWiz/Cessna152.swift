//
//  Cessna152.swift
//  TakeoffWiz
//
//  Created by Etienne Casanova on 8/5/21.
//

import Foundation

class Cessna152 : Aircraft
{
    
    // Climb ----------------------------------------------------
    public static let climbColumnHeaders = [-20,0,20,40]
    public static let climbRowHeaders = [0,2000,4000,6000,8000,10000,12000]
    public static let climbRateTable = [
        [835,765,700,630],
        [735,670,600,535],
        [635,570,505,445],
        [535,475,415,355],
        [440,380,320,265],
        [340,285,230,175],
        [245,190,135,85]
    ]
    
    public static let climbSpeedTable = [
        [[0,2000],[67]],
        [[2000,4000],[66]],
        [[4000,6000],[65]],
        [[6000,8000],[63]],
        [[8000,10000],[62]],
        [[10000,12000],[61]],
        [[10000,18000],[60]]
    ]
    // Take off ----------------------------------------------------
    // Ground roll Normal conditions
    public static let groundRollColumnHeaders = [0,10,20,30,40]
    public static let groundRollRowHeaders = [0,1000,2000,3000,4000,5000,6000,7000,8000]
    // Ft 1670 lbs
    public static let groundRoll1670LbsTable = [
        [640,695,755,810,875],
        [705,765,825,890,960],
        [775,840,910,980,1055],
        [855,925,1000,1080,1165],
        [940,1020,1100,1190, 1285],
        [1040,1125,1215,1315,1420],
        [1145,1245,1345,1455,1570],
        [1270,1375,1490,1615,1745],
        [1405,1525,1655,1795,1940]
    ]
    
    // Ground roll 50Ft obstable 2550 lbs
    public static let groundRoll50FtObsColumnHeaders = [0,10,20,30,40]
    public static let groundRoll50FtObsRowHeaders = [0,1000,2000,3000,4000,5000,6000,7000,8000]
    // Ft 1670 lbs
    public static let groundRoll50FtObs1670LbsTable = [
        [1190,1290,1390,1495,1605],
        [1310,1420,1530,1645,1770],
        [1445,1565,1690,1820,1960],
        [1600,1730,1870,2020,2185],
        [1775,1920,2080,2250,2440],
        [1970,2140,2320,2525,2750],
        [2200,2395,2610,2855,3125],
        [2470,2705,2960,3255,3590],
        [2800,3080,3395,3765,4195]
    ]
    
    
    //
    
    //basic slider outputs
    var headwind:Float = 5.00
    var temp:Float = 10.00
    var altimeter:Float = 29.92
    var elevation:Float = 300.00
    var weight:Float = 1670.0
    
    var takeoffRoll:Float = 0.0
    var over50Ft:Float = 0.0
    var gradient:Float = 0.0
    var climbRate:Float = 0.0
    //C172 arrays with values
    //values will go as following (pressure altitude, temp, Ground roll, clear 50ft)
    //2550 pounds
    //this is calculated
    var pressureAltitude:Float = 0.0
    //weight factors
    var lightWeight:Int = 0
    var heavyWeight:Int = 0
    
    
    func pressureAltitudeCalc(){
        pressureAltitude = (29.92-altimeter)*1000 + elevation
    }
    

    func getStartingWeight() -> Float {
        return 1670.0
    }
    
    func hideWeightSlider() -> Bool {
        return true
    }
    
    
    func giveMeTheAircraftName ()-> String {
        "SHORT FIELD TAKEOFF 152"
    }
    
    func planeImage () -> String {
        return "152_wingspan_img.png";
    }
        
    func takeoffRoll50ftCalc()
    {
        let result:Float =
            Utilities.interpolateQuad(temp, pressureAltitude, Cessna152.groundRoll50FtObs1670LbsTable, Cessna152.groundRollColumnHeaders, Cessna152.groundRollRowHeaders)
        over50Ft = applyHeadwind(result)
    }
    
    func takeoffRollGenericCalc()
    {
        let result:Float =
            Utilities.interpolateQuad(temp, pressureAltitude, Cessna152.groundRoll1670LbsTable, Cessna152.groundRollColumnHeaders, Cessna152.groundRollRowHeaders)
        over50Ft = applyHeadwind(result)
        
        takeoffRoll = applyHeadwind(result)
    }
    
    func applyHeadwind(_ input:Float) -> Float
    {
        var factor:Float = 1.0
        if (headwind < 0)
        {
            factor = 1.0 + (abs(headwind) * 0.5) * 0.1
        }
        else
        {
            factor = 1.0 - (headwind/9) * 0.1
        }
        return factor * input
    }
   
    // final calculates here
    func gradientCalc(){
        var speed:Int = 60
        if(pressureAltitude < 2000)
        {
            speed = 67
        }
        else if(pressureAltitude <= 4000)
        {
            speed = 66
        }
        else if(pressureAltitude <= 6000)
        {
            speed = 65
        }
        else if(pressureAltitude <= 8000)
        {
            speed = 63
        }
        else if(pressureAltitude <= 10000)
        {
            speed = 62
        }
        else if(pressureAltitude <= 12000)
        {
            speed = 61
        }
        else if(pressureAltitude <= 18000)
        {
            speed = 60
        }
        gradient = climbRate * 60 / (Float(speed)-headwind)
        
    }
    
    func climbRateCalc(){
        climbRate = Utilities.interpolateQuad(temp, pressureAltitude, Cessna152.climbRateTable, Cessna152.climbColumnHeaders, Cessna152.climbRowHeaders)
    }
    
    func executeCalc()
    {
        pressureAltitudeCalc()
        takeoffRollGenericCalc()
        takeoffRoll50ftCalc()
        climbRateCalc()
        gradientCalc()
        
    }
    
    
}
