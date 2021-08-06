//
//  ViewController.swift
//  TakeoffWiz
//
//  Created by Etienne Casanova on 7/26/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var warningLabel: UILabel!
    
    
    
    //slider values
    @IBOutlet weak var headwindValue: UILabel!
    @IBOutlet weak var tempValue: UILabel!
    @IBOutlet weak var altimeterValue: UILabel!
    @IBOutlet weak var elevationValue: UILabel!
    @IBOutlet weak var weightValue: UILabel!
    //slider actual values
    @IBOutlet weak var headwindSliderValue: UISlider!
    @IBOutlet weak var temperatureSliderValue: UISlider!
    @IBOutlet weak var altimeterSldierValue: UISlider!
    @IBOutlet weak var elevationSliderValue: UISlider!
    @IBOutlet weak var weightSliderValue: UISlider!
    //final calculations
    @IBOutlet weak var takeoffValue: UILabel!
    @IBOutlet weak var overValue: UILabel!
    @IBOutlet weak var climbValue: UILabel!
    @IBOutlet weak var gradientValue: UILabel!
    
    
    
    var brain = Brain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetValues()
    }
    
    //fix value sliders
    //make adjustments for decimal points
    //create new vars for output values
    func convertFloatToString(_ f: Float ) ->String{
        let s = String(format: "%.0f", f)
        return s
    }
    func convertFloatToStringTwo(_ f: Float ) ->String{
        let s = String(format: "%.2f", f)
        return s
    }
    
    func resetValues(){
        //changes the label next to the slider
        headwindValue.text = displayMetric(brain.headwind,step: 1.0)
        tempValue.text = displayMetric(brain.temp,step: 1.0 )
        altimeterValue.text = convertFloatToStringTwo(brain.altimeter)
        elevationValue.text = displayMetric(brain.elevation,step: 100.0 )
        weightValue.text = displayMetric(brain.weight,step: 50.0)
        //resets the actual slider value
        headwindSliderValue.value = brain.headwind
        temperatureSliderValue.value = brain.temp
        altimeterSldierValue.value = brain.altimeter
        elevationSliderValue.value = brain.elevation
        weightSliderValue.value = brain.weight
        //starting value for each
        takeoffValue.text = convertFloatToString(brain.takeoffRoll)
        overValue.text = convertFloatToString(brain.over50Ft)
        climbValue.text = convertFloatToString(brain.climbRate)
        gradientValue.text = convertFloatToString(brain.gradient)
    }
    
    func updateCalc(){
        //needs to calculate necessary values in brain first
        //so calculates pressure altitude first
        brain.pressureAltitudeCalc()
        brain.calcCessnaWeight()
        print(brain.weight)
        //calculates all the final values at the end
        brain.takeoffRollGenericCalc()
        brain.takeoffRoll50ftCalc()
        brain.climbRateCalc()
        brain.gradientCalc()
        //changes the calculated values
        takeoffValue.text = convertFloatToString(brain.takeoffRoll)
        overValue.text = convertFloatToString(brain.over50Ft)
        climbValue.text = convertFloatToString(brain.climbRate)
        gradientValue.text = convertFloatToString(brain.gradient)
        
        //this should ne put in a function
        //this needs to change for each plane
        
        
        
        //this is test
        let test = brain.interpolateWeight(brain.weight,brain.lightWeight, brain.heavyWeight, brain.temp, brain.pressureAltitude,brain.groundRoll50FtObs2400LbsTable, brain.groundRoll50FtObs2550LbsTable, brain.groundRoll50FtObsColumnHeaders, brain.groundRoll50FtObsRowHeaders)
        print("Interpolated takeoff \(test)")
    }
    func roundForBrain (_ inputVal : Float, step : Float) -> Float {
        return trunc(inputVal / step) * step
    }
    func displayMetric(_ inputVal : Float, step : Float) -> String {
            return "\(Int(trunc(inputVal / step) * step))"
    }
    
    
    @IBAction func headwindSlider(_ sender: UISlider) {
        brain.headwind = roundForBrain(sender.value,step: 1.0)
        headwindValue.text = displayMetric(brain.headwind, step: 1.0)
        //now changes values
        updateCalc()
    }
    @IBAction func temperatureSlider(_ sender: UISlider) {
        brain.temp = roundForBrain(sender.value,step: 1.0)
        tempValue.text = displayMetric(brain.temp, step: 1.0)
        updateCalc()
    }
    @IBAction func altimeterSlider(_ sender: UISlider) {
        brain.altimeter = roundForBrain(sender.value,step: 0.01)
        altimeterValue.text = convertFloatToStringTwo(brain.altimeter)
        updateCalc()
    }
    @IBAction func elevationSlider(_ sender: UISlider) {
        brain.elevation = roundForBrain(sender.value,step: 100.0)
        elevationValue.text = displayMetric(brain.elevation, step: 100.0)
        updateCalc()
    }
    @IBAction func weightSlider(_ sender: UISlider) {
        brain.weight = roundForBrain(sender.value,step: 50.0)
        weightValue.text = displayMetric(brain.weight, step: 50.0)
        updateCalc()
    }
    
    
    
    
    // gonna have a function called update and every time any of the sliders are touched you call the function and update the value of sliderLabel
}

