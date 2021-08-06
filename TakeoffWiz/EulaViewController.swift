//
//  EulaViewController.swift
//  TakeoffWiz
//
//  Created by Etienne Casanova on 8/5/21.
//

import UIKit

class EulaViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func agreePressed(_ sender: UIButton)
    {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "hasAgreedToEula")
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "agree")
        controller?.modalPresentationStyle = .fullScreen
        controller?.modalTransitionStyle = .coverVertical
        present(controller!, animated: true, completion: nil)
    }
    
    @IBAction func declinePressed(_ sender: UIButton)
    {
        let controller = storyboard?.instantiateViewController(withIdentifier: "decline")
        controller?.modalPresentationStyle = .fullScreen
        controller?.modalTransitionStyle = .coverVertical
        present(controller!, animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
