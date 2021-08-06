//
//  Brain 2.swift
//  TakeoffWiz
//
//  Created by Etienne Casanova on 8/4/21.
//

import Foundation

class BrainTwo {
    
    
    /*
    
    //basic slider outputs
    var headwind:Float = 5.00
    var temp:Float = 10.00
    var altimeter:Float = 29.92
    var elevation:Float = 300.00
    var weight:Float = 2350.00
    
    var takeoffRoll:Float = 0.0
    var over50Ft:Float = 0.0
    var gradient:Float = 0.0
    var climbRate:Float = 0.0
    //C172 arrays with values
    //values will go as following (pressure altitude, temp, Ground roll, clear 50ft)
    //2550 pounds
    //this is calculated
    var pressureAltitude:Float = 0.0
    
    
    let heavyPlane:Array = [
        [0,0,860,1465],[0,10,925,1575],[0,20,995,1690],[0,30,1070,1810],[0,40,1150,1945],[1000,0,940,1600],[1000,10,1010,1720],[1000,20,1090,1720],[1000,30,1090,1850],[1000,40,1260,2135],[2000,0,1025,1755],[2000,10,1110,1890],[2000,20,1195,2035],[2000,30,1285,2190],[2000,40,1380,2355],[3000,0,1125,1925],[3000,10,1215,2080],[3000,20,1310,2240],[3000,30,1410,2420],[3000,40,1515,2605],[4000,0,1235,2120],[4000,10,1335,2295],[4000,20,1440,2480],[4000,30,1550,2685],[4000,40,1660,2880],[5000,0,1355,2345],[5000,10,1465,2545],[5000,20,1585,2755],[5000,30,1705,2975],[5000,40,1825,3205],[6000,0,1495,2605],[6000,10,1615,1830],[6000,20,1745,3075],[6000,30,1875,3320],[6000,40,2010,3585],[7000,0,1645,2910],[7000,10,1785,3170],[7000,20,1920,3440],[7000,30,2065,3730],[7000,40,2215,4045],[8000,0,1820,3265],[8000,10,1970,3575],[8000,20,2120,3880],[8000,30,2280,4225],[8000,40,2450,4615]
    ]
    
    //2400
    let mediumPlane:Array = [[0,0,745,1275],[0,10,800,1370],[0,20,860,1470],[0,30,925,1570],[0,40,995,1685],[1000,0,810,1390],[1000,10,875,1495],[1000,20,940,1605],[1000,30,1010,1720],[1000,40,1085,1845],[2000,0,885,1520],[2000,10,955,1635],[2000,20,1030,1760],[2000,30,1110,1890],[2000,40,1190,2030],[3000,0,970,1665],[3000,10,1050,1795],[3000,20,1130,1930],[3000,30,1215,2080],[3000,40,1305,2230],[4000,0,1065,1830],[4000,10,1150,1975],[4000,20,1240,2130],[4000,30,1335,2295],[4000,40,1430,2455],[5000,0,1170,2015],[5000,10,1265,2180],[5000,20,1360,2355],[5000,30,1465,2530],[5000,40,1570,2715],[6000,0,1285,2230],[6000,10,1390,2410],[6000,20,1500,2610],[6000,30,1610,2805],[6000,40,1725,3015],[7000,0,1415,2470],[7000,10,1530,2685],[7000,20,1650,2900],[7000,30,1770,3125],[7000,40,1900,2270],[8000,0,1560,2755],[8000,10,1690,3000],[8000,20,1815,3240],[8000,30,1950,3500],[8000,40,2095,3790]
    ]
    
    //2200
    let lightPlane:Array = [ [0,0,610,1055],[0,10,655,1130],[0,20,705,1205],[0,30,760,1290],[0,40,815,1380],[1000,0,665,1145],[1000,10,720,1230],[1000,20,770,1315],[1000,30,830,1410],[1000,40,890,1505],[2000,0,725,1250],[2000,10,785,1340],[2000,20,845,1435],[2000,30,905,1540],[2000,40,975,1650],[3000,0,795,1365],[3000,10,860,1465],[3000,20,925,1570],[3000,30,995,1685],[3000,40,1065,1805],[4000,0,870,1490],[4000,10,940,1605],[4000,20,1010,1725],[4000,30,1090,1855],[4000,40,1165,1975],[5000,0,955,1635],[5000,10,1030,1765],[5000,20,1110,1900],[5000,30,1195,2035],[5000,40,1275,2175],[6000,0,1050,1800],[6000,10,1130,1940],[6000,20,1220,2090],[6000,30,1310,2240],[6000,40,1400,2395],[7000,0,1150,1985],[7000,10,1245,2145],[7000,20,1340,2305],[7000,30,1435,2475],[7000,40,1540,2650],[8000,0,1270,2195],[8000,10,1370,2375],[8000,20,1475,2555],[8000,30,1580,2745],[8000,40,1695,2950]
                             
                             
    ]
    
    //pressure altitude calculator which goes first always
    func pressureAltitudeCalc(){
        pressureAltitude = (29.92-altimeter)*1000 + elevation
        
    }
    //pressure altitude = (standard pressure - your current pressure setting) x 1,000 + field elevation
    
    
    
    // final calculates here
    func takeoffRollGenericCalc(){
        //for temperature less than 10 difference in searching algorithm
        //for loop
        //search for condition where temp is less than 10 from && pressure altitude is less than 1000 from
        //for condition in heavyPlane{}
        
        var lighterlowercolderTakeoff:Int = 0
        var lighterlowerhotterTakeoff:Int = 0
        var lighterhighercolderTakeoff:Int = 0
        var lighterhigherhotterTakeoff:Int = 0
        
        var heavierlowercolderTakeoff:Int = 0
        var heavierlowerhotterTakeoff:Int = 0
        var heavierhighercolderTakeoff:Int = 0
        var heavierhigherhotterTakeoff:Int = 0
        
        
            //50ft
        var lighterlowercolderFiftyFt:Int = 0
        var lighterlowerhotterFiftyFt:Int = 0
        var lighterhighercolderFiftyFt:Int = 0
        var lighterhigherhotterFiftyFt:Int = 0
        
        var heavierlowercolderFiftyFt:Int = 0
        var heavierlowerhotterFiftyFt:Int = 0
        var heavierhighercolderFiftyFt:Int = 0
        var heavierhigherhotterFiftyFt:Int = 0
        
        var topPressureAltitude:Int = 0
        var topTemp:Int = 0

        
        if (weight<2350)
        {
            for n in 0...(lightPlane.count - 1)
            {
                if( Float(lightPlane[n][0]) >= pressureAltitude &&
                    Float(lightPlane[n][0]) < pressureAltitude + 1000 &&
                    Float(lightPlane[n][1]) >= temp &&
                    Float(lightPlane[n][1]) < temp + 10 )//these conditions check that we're within 10 and 1000 below the elevation and temp values, this
                {
                    //sets the top temp and top Pressure altitude
                    topTemp = lightPlane[n][1]
                    topPressureAltitude = lightPlane[n][0]
                    
                    lighterlowercolderTakeoff = lightPlane[n-6][2]
                    lighterlowerhotterTakeoff = lightPlane[n-5][2]
                    lighterhighercolderTakeoff = lightPlane[n-1][2]
                    lighterhigherhotterTakeoff = lightPlane[n][2]
                    
                    heavierlowercolderTakeoff = mediumPlane[n-6][2]
                    heavierlowerhotterTakeoff = mediumPlane[n-5][2]
                    heavierhighercolderTakeoff = mediumPlane[n-1][2]
                    heavierhigherhotterTakeoff = mediumPlane[n][2]
                        //this has calculated light values for 50ft takeoff roll and take off roll
                    lighterlowercolderFiftyFt = lightPlane[n-6][3]
                    lighterlowerhotterFiftyFt = lightPlane[n-5][3]
                    lighterhighercolderFiftyFt = lightPlane[n-1][3]
                    lighterhigherhotterFiftyFt = lightPlane[n][3]
                    
                    heavierlowercolderFiftyFt = mediumPlane[n-6][3]
                    heavierlowerhotterFiftyFt = mediumPlane[n-5][3]
                    heavierhighercolderFiftyFt = mediumPlane[n-1][3]
                    heavierhigherhotterFiftyFt = mediumPlane[n][3]
                }
                
                
            }
            
            
            
        }
        else
        {
            for n in 0...(mediumPlane.count - 1)
            {
                if( Float(mediumPlane[n][0]) >= pressureAltitude &&
                    Float(mediumPlane[n][0]) < pressureAltitude + 1000 &&
                    Float(mediumPlane[n][1]) >= temp &&
                    Float(mediumPlane[n][1]) < temp + 10 )//these conditions check that we're within 10 and 1000 below the elevation and temp values, this
                {
                    topTemp = lightPlane[n][1]
                    topPressureAltitude = lightPlane[n][0]
                    
                    lighterlowercolderTakeoff = mediumPlane[n-6][2]
                    lighterlowerhotterTakeoff = mediumPlane[n-5][2]
                    lighterhighercolderTakeoff = mediumPlane[n-1][2]
                    lighterhigherhotterTakeoff = mediumPlane[n][2]
                    
                    heavierlowercolderTakeoff = heavyPlane[n-6][2]
                    heavierlowerhotterTakeoff = heavyPlane[n-5][2]
                    heavierhighercolderTakeoff = heavyPlane[n-1][2]
                    heavierhigherhotterTakeoff = heavyPlane[n][2]
                        //this has calculated light values for 50ft takeoff roll and take off roll
                    lighterlowercolderFiftyFt = mediumPlane[n-6][3]
                    lighterlowerhotterFiftyFt = mediumPlane[n-5][3]
                    lighterhighercolderFiftyFt = mediumPlane[n-1][3]
                    lighterhigherhotterFiftyFt = mediumPlane[n][3]
                    
                    heavierlowercolderFiftyFt = heavyPlane[n-6][3]
                    heavierlowerhotterFiftyFt = heavyPlane[n-5][3]
                    heavierhighercolderFiftyFt = heavyPlane[n-1][3]
                    heavierhigherhotterFiftyFt = heavyPlane[n][3]
                }
                
                
            }
            
        }
        //at this point we've set the values we just need the averages then to assign a final
        //first cut down temp into two
        let tempFactor:Float = (Float(temp) - (Float(topTemp)-10.0))/10.0
        
        
        //second from temp cut down pressure altitude
        let pressureAltitudeFactor:Float = (Float(pressureAltitude) - (Float(topPressureAltitude)-1000.0))/1000.0
        
        
        //then once you're down with that cut down difference between weights
        var weightFactor:Float = 0
        if (weight<2350){
            weightFactor = (weight-2200)/150
        }
        else{
            weightFactor = (weight-2350)/200//the divisible part is the difference between the two ranges
        }
        //interpolating based on temperature
        let lighterlowerTakeoff:Float = Float(lighterlowercolderTakeoff) + Float(lighterlowerhotterTakeoff-lighterlowercolderTakeoff)*tempFactor
        let lighterhigherTakeoff:Float = Float(lighterhighercolderTakeoff) + Float(lighterhigherhotterTakeoff-lighterhighercolderTakeoff)*tempFactor
        let heavierlowerTakeoff:Float = Float(heavierlowercolderTakeoff) + Float(heavierlowerhotterTakeoff-heavierlowercolderTakeoff)*tempFactor
        let heavierhigherTakeoff:Float = Float(heavierhighercolderTakeoff) + Float(heavierhigherhotterTakeoff-heavierhighercolderTakeoff)*tempFactor
        //50 ft now interpolation
        let lighterlowerFiftyFt:Float = Float(lighterlowercolderFiftyFt) + Float(lighterlowerhotterFiftyFt-lighterlowercolderFiftyFt)*tempFactor
        let lighterhigherFiftyFt:Float = Float(lighterhighercolderFiftyFt) + Float(lighterhigherhotterFiftyFt-lighterhighercolderFiftyFt)*tempFactor
        let heavierlowerFiftyFt:Float = Float(heavierlowercolderFiftyFt) + Float(heavierlowerhotterFiftyFt-heavierlowercolderFiftyFt)*tempFactor
        let heavierhigherFiftyFt:Float = Float(heavierhighercolderFiftyFt) + Float(heavierhigherhotterFiftyFt-heavierhighercolderFiftyFt)*tempFactor
        //now
        
        
        
        
        
        
        
    }
    
    
    
    
    func gradientCalc(){
        
        gradient = headwind+elevation+altimeter+temp+weight
    }
    func climbRateCalc(){
        
        climbRate = headwind+elevation+altimeter+temp+weight
    }
    
    */
    
}

