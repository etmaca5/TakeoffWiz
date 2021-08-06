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
    

    //this is for the cessna
    //need to figure out what the best parameters for this are, keeping in mind that the planes might change
    //we still need something that will get the heavier weight and the lighter weight
    func interpolateWeight(_ weight:Float, _ lightWeight:Int, _ heavyWeight:Int ,_ xtemp:Float,_ ypressure:Float,_ dataLight:[[Int]],_ dataHeavy:[[Int]],_ columns:[Int],_ rows:[Int])-> Float
    {
        let lighterWeightOutput: Float = Utilities.interpolateQuad(xtemp, ypressure, dataLight, columns, rows)
        let heavierWeightOutput: Float = Utilities.interpolateQuad(xtemp, ypressure, dataHeavy, columns, rows)
        
        //need to change for each plane
        var weightFactor:Float = (weight - Float(lightWeight)) / Float(heavyWeight - lightWeight)
        if( heavyWeight == lightWeight )
        {
            weightFactor = 0
        }
        let outputDifference:Float = heavierWeightOutput - lighterWeightOutput
        return lighterWeightOutput + (outputDifference * weightFactor)
    }
    
    func calcWithWeight(_ finaldataLight:[[Int]], _ finaldataHeavy:[[Int]], _ columnHeaders:[Int], _ rowHeaders:[Int])-> Float
    {
        return interpolateWeight(weight, lightWeight, heavyWeight , temp, pressureAltitude, finaldataLight, finaldataHeavy, columnHeaders , rowHeaders)
    }
    
    func takeoffRoll50ftCalc()
    {
        var result:Float = 0.0
        
        if(heavyWeight == 2550 &&
            lightWeight == 2400)
        {
            result = calcWithWeight(Cessna172S.groundRoll50FtObs2400LbsTable,Cessna172S.groundRoll50FtObs2550LbsTable , Cessna172S.groundRollColumnHeaders, Cessna172S.groundRollRowHeaders)
        }
        else if (heavyWeight == 2400 &&
                    lightWeight == 2200)
        {
            result = calcWithWeight(Cessna172S.groundRoll50FtObs2200LbsTable,Cessna172S.groundRoll50FtObs2400LbsTable , Cessna172S.groundRollColumnHeaders, Cessna172S.groundRollRowHeaders)
        }
        else if(heavyWeight == lightWeight){
            if(heavyWeight == 2200){
                result = calcWithWeight(Cessna172S.groundRoll50FtObs2200LbsTable,Cessna172S.groundRoll50FtObs2200LbsTable , Cessna172S.groundRollColumnHeaders, Cessna172S.groundRollRowHeaders)
            }
            if (heavyWeight == 2400){
                result = calcWithWeight(Cessna172S.groundRoll50FtObs2400LbsTable,Cessna172S.groundRoll50FtObs2400LbsTable , Cessna172S.groundRollColumnHeaders, Cessna172S.groundRollRowHeaders)
            }
            if( heavyWeight == 2550)
            {
                result = calcWithWeight(Cessna172S.groundRoll50FtObs2550LbsTable,Cessna172S.groundRoll50FtObs2550LbsTable , Cessna172S.groundRollColumnHeaders, Cessna172S.groundRollRowHeaders)
            }
        }
        over50Ft = applyHeadwind(result)
    }
    
    func takeoffRollGenericCalc()
    {
        var result:Float = 0.0
        
        if(heavyWeight == 2550 &&
            lightWeight == 2400)
        {
            result = calcWithWeight(Cessna172S.groundRoll2400LbsTable,Cessna172S.groundRoll2550LbsTable , Cessna172S.groundRollColumnHeaders, Cessna172S.groundRollRowHeaders)
        }
        else if (heavyWeight == 2400 &&
                    lightWeight == 2200)
        {
            result = calcWithWeight(Cessna172S.groundRoll2200LbsTable,Cessna172S.groundRoll2400LbsTable , Cessna172S.groundRollColumnHeaders, Cessna172S.groundRollRowHeaders)
        }
        else if(heavyWeight == lightWeight){
            if(heavyWeight == 2200){
                result = calcWithWeight(Cessna172S.groundRoll2200LbsTable,Cessna172S.groundRoll2200LbsTable , Cessna172S.groundRollColumnHeaders, Cessna172S.groundRollRowHeaders)
            }
            if (heavyWeight == 2400){
                result = calcWithWeight(Cessna172S.groundRoll2400LbsTable,Cessna172S.groundRoll2400LbsTable , Cessna172S.groundRollColumnHeaders, Cessna172S.groundRollRowHeaders)
            }
            if( heavyWeight == 2550)
            {
                result = calcWithWeight(Cessna172S.groundRoll2550LbsTable,Cessna172S.groundRoll2550LbsTable , Cessna172S.groundRollColumnHeaders, Cessna172S.groundRollRowHeaders)
            }
        }
        
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
        var speed:Int = 72
        if(pressureAltitude < 2000)
        {
            speed = 74
        }
        else if(pressureAltitude <= 8000)
        {
            speed = 73
        }
        gradient = climbRate * 60 / (Float(speed)-headwind)
        
    }
    
    func climbRateCalc(){
        climbRate = Utilities.interpolateQuad(temp, pressureAltitude, Cessna172S.climbRateTable, Cessna172S.climbColumnHeaders, Cessna172S.climbRowHeaders)
    }
    
    func setWeightTables()
    {
        if (weight<2400)
        {
            heavyWeight = 2400
            lightWeight = 2200
        }
        else if (weight == 2200.0 ||
                    weight == 2400.0 ||
                    weight == 2550.0)
        {
            heavyWeight = Int(weight)
            lightWeight = Int(weight)
        }
        else
        {
            heavyWeight = 2550
            lightWeight = 2400
        }
    }
    func executeCalc()
    {
        pressureAltitudeCalc()
        setWeightTables()
        takeoffRollGenericCalc()
        takeoffRoll50ftCalc()
        climbRateCalc()
        gradientCalc()
        
    }
    
}
