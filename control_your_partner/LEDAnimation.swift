//
//  LEDAnimation.swift
//  control_your_woman
//
//  Created by Marcin on 13.03.2016.
//  Copyright © 2016 Marcin. All rights reserved.
//

import UIKit

public class LEDAnimation {

    public var colorON: UIColor
    public var colorOFF: UIColor
    
    private let view: UIView
    private let led : CAShapeLayer
    
    init(view: UIView){
        self.view = view
        self.colorON = UIColor(red: 105/255, green: 109/255, blue: 104/255, alpha: 1)
        self.colorOFF = UIColor(red: 46/255, green: 255/255, blue: 5/255, alpha: 1)
        
        
        let screenDotSizeX = Float(Utils.getScreenResolution()["width"]!/100)
        let screenDotSizeY = Float(Utils.getScreenResolution()["height"]!/100)
        
        let radius: CGFloat = CGFloat(((screenDotSizeY+screenDotSizeY)/3))
        let posX: CGFloat = CGFloat(screenDotSizeX * Float(75)) - radius/2
        let posY: CGFloat = CGFloat(screenDotSizeY * Float(4)) - radius/2
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: posX, y: posY), radius: radius, startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        self.led = CAShapeLayer()
        self.led.path = circlePath.CGPath
        self.led.strokeColor = UIColor.blackColor().CGColor
        self.led.lineWidth = 1.0
        self.led.fillColor = colorON.CGColor
        self.view.layer.addSublayer(self.led)
    }
    
    func blink() {
        let colors = [self.colorOFF.CGColor,
                      self.colorON.CGColor]
        
        for i in Range(0..<6) {
            let delay = 0.1 * Double(i)
            let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                let colorId = i % colors.count
                self.led.fillColor = colors[colorId]
            })
        }
    }
}