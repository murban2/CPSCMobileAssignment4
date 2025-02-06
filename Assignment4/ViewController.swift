//
//  ViewController.swift
//  Assignment4
//
//  Created by user269254 on 2/6/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var clockLabel: UILabel!
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startClock()
        
    }
    
    func startClock() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)
    }
    
    @objc func updateClock() {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
        clockLabel.text = formatter.string(from: Date())
        
        let formatterTwo = DateFormatter()
        formatterTwo.dateFormat = "a"
        
        let amPm = formatterTwo.string(from: Date())
        
        
        
        
    }

}

