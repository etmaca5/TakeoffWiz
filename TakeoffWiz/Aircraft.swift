//
//  Aircraft.swift
//  TakeoffWiz
//
//  Created by Etienne Casanova on 8/13/21.
//

import Foundation

protocol Aircraft {
    func giveMeTheAircraftName() -> String

    func takeoffRollGenericCalc()
    func takeoffRoll50ftCalc()
    func gradientCalc()
    func climbRateCalc()
    func executeCalc()
    func getStartingWeight() -> Float
    func hideWeightSlider() -> Bool
    func planeImage () -> String 
    
    var headwind: Float { get set }
    var temp: Float { get set }
    var altimeter: Float { get set }
    var elevation:Float { get set }
    var weight:Float { get set }
    
    var takeoffRoll:Float { get set }
    var over50Ft:Float { get set }
    var gradient:Float { get set }
    var climbRate:Float { get set }
    
}
