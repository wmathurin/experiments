//
//  ViewController.swift
//  Simple App
//
//  Created by Wolfgang Mathurin on 12/20/17.
//  Copyright © 2017 Wolfgang Mathurin. All rights reserved.
//

import UIKit

extension ViewController {
    
}

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var gv: GraphView!
    var speed : Double = 1
    let maxDelta : Double = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let displaylink = CADisplayLink(target: self,
                                    selector: #selector(step))
        
        displaylink.add(to: .current,
                        forMode: .defaultRunLoopMode)

        let rotationGesture = UIRotationGestureRecognizer(target:self, action:#selector(rotate))
        rotationGesture.delegate = self
        gv.isUserInteractionEnabled = true
        gv.addGestureRecognizer(rotationGesture)
    }
    
    @objc
    func rotate(_ gesture:UIRotationGestureRecognizer) {
        if (gesture.rotation.sign == speed.sign) {
            speed += gesture.rotation > 0 ? 1 : -1
        }
        else {
            speed = gesture.rotation > 0 ? 1 : -1
        }
    }
    
    @objc
    func step(displaylink: CADisplayLink) {
        let delta = 2*maxDelta / (1 + exp(-speed)) - maxDelta;
        gv.angle += delta / 3600 * Double.pi * 2
        print("Needs display with \(gv.angle)")
        gv.setNeedsDisplay()

    }

}

