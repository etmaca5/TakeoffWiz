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
    
    
    // Climb ----------------------------------------------------
    public let climbColumnHeaders = [-20,0,20,40]
    public let climbRowHeaders = [0,2000,4000,6000,8000,10000,12000]
    public let climbRateTable = [
        [855,785,710,645],
        [760,695,625,560],
        [685,620,555,495],
        [575,515,450,390],
        [465,405,345,285],
        [360,300,240,180],
        [255,195,135,-9999]
    ]
    public let climbSpeedTable = [
        [[0,2000],[74]],
        [[2000,4000],[73]],
        [[4000,6000],[73]],
        [[6000,8000],[73]],
        [[8000,10000],[72]],
        [[10000,12000],[72]],
        [[10000,18000],[72]]
    ]
    // Take off ----------------------------------------------------
    // Ground roll Normal conditions
    public let groundRollColumnHeaders = [0,10,20,30,40]
    public let groundRollRowHeaders = [0,1000,2000,3000,4000,5000,6000,7000,8000]
    // Ft 2550 lbs
    public let groundRoll2550LbsTable = [
        [860,925,995,1070,1150],
        [940,1010,1090,1170,1260],
        [1025,1110,1195,1285,1380],
        [1125,1215,1310,1410,1515],
        [1235,1335,1440,1550,1660],
        [1355,1465,1585,1705,1825],
        [1495,1615,1745,1875,2010],
        [1645,1785,1920,2065,2215],
        [1820,1970,2120,2280,2450]
    ]
    // Ft 2400 lbs
    public let groundRoll2400LbsTable = [
        [745,800,860,925,995],
        [810,875,940,1010,1085],
        [885,955,1030,1110,1190],
        [970,1050,1130,1215,1305],
        [1065,1150,1240,1335,1430],
        [1170,1265,1360,1465,1570],
        [1285,1390,1500,1610,1725],
        [1415,1530,1650,1770,1900],
        [1560,1690,1815,1950,2095]
    ]
    // Ft 2200 lbs
    public let groundRoll2200LbsTable = [
        [610,655,705,760,815],
        [665,720,770,830,890],
        [725,785,845,905,975],
        [795,860,925,995,1065],
        [870,940,1010,1090,1165],
        [955,1030,1110,1195,1275],
        [1050,1130,1220,1310,1400],
        [1150,1245,1340,1435,1540],
        [1270,1370,1475,1580,1695]
    ]
    // Ground roll 50Ft obstable 2550 lbs
    public let groundRoll50FtObsColumnHeaders = [0,10,20,30,40]
    public let groundRoll50FtObsRowHeaders = [0,1000,2000,3000,4000,5000,6000,7000,8000]
    // Ft 2550 lbs
    public let groundRoll50FtObs2550LbsTable = [
        [1465,1575,1690,1810,1945],
        [1600,1720,1850,1990,2135],
        [1755,1890,2035,2190,2355],
        [1925,2080,2240,2420,2605],
        [2120,2295,2480,2685,2880],
        [2345,2545,2755,2975,3205],
        [2605,2830,3075,3320,3585],
        [2910,3170,3440,3730,4045],
        [3265,3575,3880,4225,4615]
    ]
    // Ft 2400 lbs
    public let groundRoll50FtObs2400LbsTable = [
        [1275,1370,1470,1570,1685],
        [1390,1495,1605,1720,1845],
        [1520,1635,1760,1890,2030],
        [1665,1795,1930,2080,2230],
        [1830,1975,2130,2295,2455],
        [2015,2180,2355,2530,2715],
        [2230,2410,2610,2805,3015],
        [2470,2685,2900,3125,3370],
        [2755,3000,3240,3500,3790]
    ]
    // Ft 2200 lbs
    public let groundRoll50FtObs2200LbsTable = [
        [1055,1130,1205,1290,1380],
        [1145,1230,1315,1410,1505],
        [1250,1340,1435,1540,1650],
        [1365,1465,1570,1685,1805],
        [1490,1605,1725,1855,1975],
        [1635,1765,1900,2035,2175],
        [1800,1940,2090,2240,2395],
        [1985,2145,2305,2475,2650],
        [2195,2375,2555,2745,2950]
    ]
    func pressureAltitudeCalc(){
        pressureAltitude = (29.92-altimeter)*1000 + elevation
    }
    var lowerColumn:Int = 0
    var higherColumn:Int = 0
    var lowerRow:Int = 0
    var higherRow:Int = 0
    
    
    
    func getQuad(_ xtemp:Float,_ ypressure:Float,_ data:[[Int]],_ columns:[Int],_ rows:[Int])->[[Int]]
    {
        if(Float(columns[0]) == xtemp)
        {
            lowerColumn=0
            higherColumn=0
        }
        for n in 1...columns.count - 1{
            if(xtemp > Float(columns[n-1]) &&
                xtemp < Float(columns[n])){
                lowerColumn = n-1
                higherColumn = n
            }
        }
        //highest column case
        if(Float(columns[columns.count - 1]) == xtemp){
            lowerColumn = columns.count - 1
            higherColumn = columns.count - 1
        }
        if(Float(rows[0]) == ypressure)
        {
            lowerRow=0
            higherRow=0
        }
        
        for n in 1...rows.count - 1{
            if(ypressure > Float(rows[n-1]) &&
                ypressure < Float(rows[n])){
                lowerRow = n-1
                higherRow = n
            }
        }
        //highest rows case
        if(Float(rows[rows.count - 1]) == ypressure){
            lowerRow = rows.count - 1
            higherRow = rows.count - 1
        }
        let lowercolder:Int = data[lowerRow][lowerColumn]
        let lowerhotter:Int = data[lowerRow][higherColumn]
        let highercolder:Int = data[higherRow][lowerColumn]
        let higherhotter:Int = data[higherRow][higherColumn]
        
        //need to use this in the interpolate quad
        let quad:[[Int]] = [
            [lowerColumn,higherColumn],
            [lowerRow,higherRow],
            [lowercolder,lowerhotter],
            [highercolder,higherhotter]
        ]
        return quad
    }
    
    
    
    
    func interpolateQuad(_ xtemp:Float,_ ypressure:Float,_ data:[[Int]],_ columns:[Int],_ rows:[Int])->Float
    {
        
        let quad:[[Int]] = getQuad(xtemp, ypressure, data, columns, rows)
        
        print(quad[2][0])
        print(quad[2][1])
        print(quad[3][0])
        print(quad[3][1])
        
        var tempRatio:Float = (xtemp - Float(columns[quad[0][0]])) / Float(columns[quad[0][1]] - columns[quad[0][0]])
        if(columns[quad[0][1]] == columns[quad[0][0]])
        {
            tempRatio = 0.0
        }
        //there was an index out of bounds here vvvv
        var pressureRatio:Float = (ypressure - Float(rows[quad[1][0]])) / Float(rows[quad[1][1]] - rows[quad[1][0]])
        if(rows[quad[1][1]] == rows[quad[1][0]])
        {
            pressureRatio = 0.0
        }
        
        let lowerDifference:Int = quad[2][1]-quad[2][0]
        let lower:Float = Float(lowerDifference) * tempRatio + Float(quad[2][0])
        
        print("lower = \(String(lower))")
        
        let higherDifference:Int = quad[3][1]-quad[3][0]
        let higher:Float = Float(higherDifference) * tempRatio + Float(quad[3][0])
        
        print("higher = \(String(higher))")
        
        let difference:Float = higher - lower
        let finalResult =  difference * pressureRatio + lower
        
        print("finalResult: \(finalResult)")
        return finalResult
    }
    
    
    
    //this is for the cessna
    //need to figure out what the best parameters for this are, keeping in mind that the planes might change
    //we still need something that will get the heavier weight and the lighter weight
    func interpolateWeight(_ weight:Float, _ lightWeight:Int, _ heavyWeight:Int ,_ xtemp:Float,_ ypressure:Float,_ dataLight:[[Int]],_ dataHeavy:[[Int]],_ columns:[Int],_ rows:[Int])-> Float
    {
        let lighterWeightOutput: Float = interpolateQuad(xtemp, ypressure, dataLight, columns, rows)
        let heavierWeightOutput: Float = interpolateQuad(xtemp, ypressure, dataHeavy, columns, rows)
        print("Lighterweightoutput \(lighterWeightOutput)")
        print("Heavierweightoutput \(lighterWeightOutput)")
        
        
        //need to change for each plane
        var weightFactor:Float = (weight - Float(lightWeight)) / Float(heavyWeight - lightWeight)
        if( heavyWeight == lightWeight )
        {
            weightFactor = 0
        }
        let outputDifference:Float = heavierWeightOutput - lighterWeightOutput
        let finalResult:Float = lighterWeightOutput + (outputDifference * weightFactor)
        
        return finalResult
    }
    
    
    func finalCalc(_ finaldataLight:[[Int]], _ finaldataHeavy:[[Int]], _ columnHeaders:[Int], _ rowHeaders:[Int])-> Float
    {
        return interpolateWeight(weight, lightWeight, heavyWeight , temp, pressureAltitude, finaldataLight, finaldataHeavy, columnHeaders , rowHeaders)
    }
    func takeoffRoll50ftCalc()
    {
        var finalTakeoff:Float = 0.0
        if(heavyWeight == 2550 &&
            lightWeight == 2400)
        {
            finalTakeoff = finalCalc(groundRoll50FtObs2400LbsTable,groundRoll50FtObs2550LbsTable , groundRollColumnHeaders, groundRollRowHeaders)
        }
        else if (heavyWeight == 2400 &&
                    lightWeight == 2200)
        {
            finalTakeoff = finalCalc(groundRoll50FtObs2200LbsTable,groundRoll50FtObs2400LbsTable , groundRollColumnHeaders, groundRollRowHeaders)
        }
        else if(heavyWeight == lightWeight){
            if(heavyWeight == 2200){
                finalTakeoff = finalCalc(groundRoll50FtObs2200LbsTable,groundRoll50FtObs2200LbsTable , groundRollColumnHeaders, groundRollRowHeaders)
            }
            if (heavyWeight == 2400){
                finalTakeoff = finalCalc(groundRoll50FtObs2400LbsTable,groundRoll50FtObs2400LbsTable , groundRollColumnHeaders, groundRollRowHeaders)
            }
            if( heavyWeight == 2550)
            {
                finalTakeoff = finalCalc(groundRoll50FtObs2550LbsTable,groundRoll50FtObs2550LbsTable , groundRollColumnHeaders, groundRollRowHeaders)
            }
        }
        over50Ft = applyHeadwind(finalTakeoff)
    }
    func takeoffRollGenericCalc()
    {
        var finalTakeoff:Float = 0.0
        if(heavyWeight == 2550 &&
            lightWeight == 2400)
        {
            finalTakeoff = finalCalc(groundRoll2400LbsTable,groundRoll2550LbsTable , groundRollColumnHeaders, groundRollRowHeaders)
        }
        else if (heavyWeight == 2400 &&
                    lightWeight == 2200)
        {
            finalTakeoff = finalCalc(groundRoll2200LbsTable,groundRoll2400LbsTable , groundRollColumnHeaders, groundRollRowHeaders)
        }
        else if(heavyWeight == lightWeight){
            if(heavyWeight == 2200){
                finalTakeoff = finalCalc(groundRoll2200LbsTable,groundRoll2200LbsTable , groundRollColumnHeaders, groundRollRowHeaders)
            }
            if (heavyWeight == 2400){
                finalTakeoff = finalCalc(groundRoll2400LbsTable,groundRoll2400LbsTable , groundRollColumnHeaders, groundRollRowHeaders)
            }
            if( heavyWeight == 2550)
            {
                finalTakeoff = finalCalc(groundRoll2550LbsTable,groundRoll2550LbsTable , groundRollColumnHeaders, groundRollRowHeaders)
            }
        }
        takeoffRoll = applyHeadwind(finalTakeoff)
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
        gradient = climbRate * 60 / (Float(speed))
        
    }
    func climbRateCalc(){
        climbRate = interpolateQuad(temp, pressureAltitude, climbRateTable, climbColumnHeaders, climbRowHeaders)
    }
    func calcCessnaWeight()
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
    
    
}
