import Foundation

class Brain {
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
    //weight factors
    var lightWeight:Int = 0
    var heavyWeight:Int = 0
    
    
    func pressureAltitudeCalc(){
        pressureAltitude = (29.92-altimeter)*1000 + elevation
    }
    
    var aircraft: Aircraft = Cessna152();
    
    func setAircraft (_ name: String) {
        if (name == "Cessna152") {
            aircraft = Cessna152();
        } else {
            aircraft =  Cessna172S();
        }
        weight = aircraft.getStartingWeight()
    }
    
    func takeoffRoll50ftCalc()
    {
        return aircraft.takeoffRoll50ftCalc();
        
    }
    
    func takeoffRollGenericCalc()
    {
        return aircraft.takeoffRollGenericCalc()
    }
    
    func climbRateCalc(){
        return aircraft.climbRateCalc()
    }
    
    func executeCalc()
    {
        pressureAltitudeCalc()
        aircraft.temp = temp
        aircraft.headwind = headwind
        aircraft.altimeter = altimeter
        aircraft.weight = weight
        aircraft.elevation = elevation
        aircraft.executeCalc()
        
        takeoffRoll = aircraft.takeoffRoll
        over50Ft = aircraft.over50Ft
        gradient = aircraft.gradient
        climbRate = aircraft.climbRate
        
    }
    
}
