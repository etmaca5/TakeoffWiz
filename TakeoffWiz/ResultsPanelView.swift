//
//  ResultsPanelView.swift
//  TakeoffWiz
//
//  Created by Etienne Casanova on 8/11/21.
//

import UIKit

class ResultsPanelView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var over50Ft: UILabel!
    @IBOutlet weak var climbRate: UILabel!
    @IBOutlet weak var gradient: UILabel!
    
    @IBOutlet weak var titlename: UILabel!
    @IBOutlet weak var takeoffRoll: UILabel!
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupView()
    }
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
    }
    
    //common func to init our view
    private func setupView() {
        Bundle.main.loadNibNamed("ResultsPanelView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    func updateResult(takeoffRoll: String, over50Ft: String, climbRate: String, gradient: String, titlename: String) {
        self.takeoffRoll.text = takeoffRoll
        self.over50Ft.text = over50Ft
        self.climbRate.text = climbRate
        self.gradient.text = gradient
        self.titlename.text = titlename
    }
}
