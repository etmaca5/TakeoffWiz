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
    
    @IBOutlet weak var resultsPanel: ResultsPanelView!
    
    var brain = Brain()
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brain.setAircraft("Cessna152");
        resetValues()
        calcAndDisplayResults()
        
        backgroundImage.image = UIImage(named: brain.aircraft.planeImage())
        backgroundImage.contentMode = .scaleAspectFit
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    // displays results from the brain
    private func displayAutoResultsFromBrain()
    {
        resultsPanel.updateResult(takeoffRoll: Utilities.convertFloatToString(brain.takeoffRoll), over50Ft: Utilities.convertFloatToString(brain.over50Ft), climbRate: Utilities.convertFloatToString(brain.climbRate), gradient: Utilities.convertFloatToString(brain.gradient), titlename: brain.aircraft.giveMeTheAircraftName())
            weightSliderValue.isHidden = brain.aircraft.hideWeightSlider()
            weightValue.text = Utilities.displayMetric(brain.weight,step: 50.0)
    }
    
    // sets and displays label preset values from Brain
    func displayLabelValuesFromBrain()
    {
        headwindValue.text = Utilities.displayMetric(brain.headwind,step: 1.0)
        tempValue.text = Utilities.displayMetric(brain.temp,step: 1.0 )
        altimeterValue.text = Utilities.convertFloatToStringTwo(brain.altimeter)
        elevationValue.text = Utilities.displayMetric(brain.elevation,step: 100.0 )
        weightValue.text = Utilities.displayMetric(brain.weight,step: 50.0)
    }
    
    //  sets starting slider values to preset brain values
    func setSliderValuesFromBrain()
    {
        headwindSliderValue.value = brain.headwind
        temperatureSliderValue.value = brain.temp
        altimeterSldierValue.value = brain.altimeter
        elevationSliderValue.value = brain.elevation
        weightSliderValue.value = brain.weight
    }
    
    //sets all the values on the display to preset values
    func resetValues()
    {
        displayLabelValuesFromBrain()
        setSliderValuesFromBrain()
        displayAutoResultsFromBrain()
    }
    
    //calculates all values in Brain and then displays them
    func calcAndDisplayResults()
    {
        brain.executeCalc()
        displayAutoResultsFromBrain()
    }
    
    
    @IBAction func headwindSlider(_ sender: UISlider) {
        brain.headwind = Utilities.roundForBrain(sender.value,step: 1.0)
        headwindValue.text = Utilities.displayMetric(brain.headwind, step: 1.0)
        //now changes values
        calcAndDisplayResults()
    }
    @IBAction func temperatureSlider(_ sender: UISlider) {
        brain.temp = Utilities.roundForBrain(sender.value,step: 1.0)
        tempValue.text = Utilities.displayMetric(brain.temp, step: 1.0)
        calcAndDisplayResults()
    }
    @IBAction func altimeterSlider(_ sender: UISlider) {
        brain.altimeter = Utilities.roundForBrain(sender.value,step: 0.01)
        altimeterValue.text = Utilities.convertFloatToStringTwo(brain.altimeter)
        calcAndDisplayResults()
    }
    @IBAction func elevationSlider(_ sender: UISlider) {
        brain.elevation = Utilities.roundForBrain(sender.value,step: 100.0)
        elevationValue.text = Utilities.displayMetric(brain.elevation, step: 100.0)
        calcAndDisplayResults()
    }
    @IBAction func weightSlider(_ sender: UISlider) {
        brain.weight = Utilities.roundForBrain(sender.value,step: 50.0)
        weightValue.text = Utilities.displayMetric(brain.weight, step: 50.0)
        calcAndDisplayResults()
    }
    
    
    @IBAction func changeAircraft(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            brain.setAircraft("Cessna152")
        } else {
            brain.setAircraft("Cessna172")
        }
        
        backgroundImage.image = UIImage(named: brain.aircraft.planeImage())
        backgroundImage.contentMode = .scaleAspectFit
        self.view.insertSubview(backgroundImage, at: 0)
        
        calcAndDisplayResults()
    }
    
    
    // gonna have a function called update and every time any of the sliders are touched you call the function and update the value of sliderLabel
}

