//
//  Cessna172s.swift
//  TakeoffWiz
//
//  Created by Etienne Casanova on 8/5/21.
//

import Foundation

class Cessna172S
{
    
    // Climb ----------------------------------------------------
    public static let climbColumnHeaders = [-20,0,20,40]
    public static let climbRowHeaders = [0,2000,4000,6000,8000,10000,12000]
    public static let climbRateTable = [
        [855,785,710,645],
        [760,695,625,560],
        [685,620,555,495],
        [575,515,450,390],
        [465,405,345,285],
        [360,300,240,180],
        [255,195,135,-9999]
    ]
    public static let climbSpeedTable = [
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
    public static let groundRollColumnHeaders = [0,10,20,30,40]
    public static let groundRollRowHeaders = [0,1000,2000,3000,4000,5000,6000,7000,8000]
    // Ft 2550 lbs
    public static let groundRoll2550LbsTable = [
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
    public static let groundRoll2400LbsTable = [
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
    public static let groundRoll2200LbsTable = [
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
    public static let groundRoll50FtObsColumnHeaders = [0,10,20,30,40]
    public static let groundRoll50FtObsRowHeaders = [0,1000,2000,3000,4000,5000,6000,7000,8000]
    // Ft 2550 lbs
    public static let groundRoll50FtObs2550LbsTable = [
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
    public static let groundRoll50FtObs2400LbsTable = [
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
    public static let groundRoll50FtObs2200LbsTable = [
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
    
    
    
    
}