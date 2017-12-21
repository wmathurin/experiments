//
//  GraphView.swift
//  Simple App
//
//  Created by Wolfgang Mathurin on 12/20/17.
//  Copyright © 2017 Wolfgang Mathurin. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable class GraphView: UIView {
    
    @IBInspectable var startColor: UIColor = .red
    @IBInspectable var endColor: UIColor = .green
   
    private var _angle : CDouble = 0
    var angle: CDouble {
        set {
            _angle = newValue.truncatingRemainder(dividingBy: Double.pi*2);
        }
        
        get {
            return _angle
        }
    }
    
    
    
    override func draw(_ rect: CGRect) {
        print("Drawing with \(angle)")
        let context = UIGraphicsGetCurrentContext()!
        let length = sqrt(CDouble(bounds.width*bounds.width) + CDouble(bounds.height*bounds.height))
        let origin = CGPoint(x: bounds.width/2,
                             y: bounds.height/2)
        let dx = CGFloat(cos(angle) * length)
        let dy = CGFloat(sin(angle) * length)
        
        let startPoint = CGPoint(x: origin.x - dx,
                                 y: origin.y - dy)

        
        let endPoint = CGPoint(x: origin.x + dx,
                               y: origin.y + dy)

        // Gradient
        let colors = [startColor.cgColor, endColor.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
        
        // Line
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(10)
        context.move(to:startPoint)
        context.addLine(to:endPoint);
        context.drawPath(using:.fillStroke)
    }
}
