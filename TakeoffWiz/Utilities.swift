//
//  Utilities.swift
//  TakeoffWiz
//
//  Created by Etienne Casanova on 8/5/21.
//

import Foundation

class Utilities
{
    static func convertFloatToString(_ f: Float ) ->String
    {
        let s = String(format: "%.0f", f)
        return s
    }
    
    static func convertFloatToStringTwo(_ f: Float ) ->String
    {
        let s = String(format: "%.2f", f)
        return s
    }
    
    static func roundForBrain (_ inputVal : Float, step : Float) -> Float
    {
        return trunc(inputVal / step) * step
    }
    
    static func displayMetric(_ inputVal : Float, step : Float) -> String
    {
            return "\(Int(trunc(inputVal / step) * step))"
    }
    
    static func getQuad(_ xtemp:Float,_ ypressure:Float,_ data:[[Int]],_ columns:[Int],_ rows:[Int])->[[Int]]
    {
        var lowerColumn:Int = 0
        var higherColumn:Int = 0
        var lowerRow:Int = 0
        var higherRow:Int = 0
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
            else if(Float(columns[n]) == xtemp)
            {
                lowerColumn = n
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
            else if(Float(rows[n]) == ypressure)
            {
                lowerRow = n
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
    
    static func interpolateQuad(_ xtemp:Float,_ ypressure:Float,_ data:[[Int]],_ columns:[Int],_ rows:[Int])->Float
    {
        
        let quad:[[Int]] = getQuad(xtemp, ypressure, data, columns, rows)
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
        let higherDifference:Int = quad[3][1]-quad[3][0]
        let higher:Float = Float(higherDifference) * tempRatio + Float(quad[3][0])
        let difference:Float = higher - lower
        return difference * pressureRatio + lower
    }
    
}
