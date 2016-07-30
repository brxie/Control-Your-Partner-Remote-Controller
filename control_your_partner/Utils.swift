//
//  Utils.swift
//  control_your_woman
//
//  Created by Marcin on 12.03.2016.
//  Copyright © 2016 Marcin. All rights reserved.
//
import UIKit
import AVFoundation

public class Utils {
    

    private var debugLabel: UILabel?
    
    func debugLabel(view: UIView, text: String){
        if self.debugLabel == nil {
            self.debugLabel = UILabel(frame: CGRectMake(0, 0, 200, 20))
            self.debugLabel!.textColor = UIColor.greenColor()
            self.debugLabel!.font = self.debugLabel!.font.fontWithSize(15)
            self.debugLabel!.backgroundColor = UIColor.clearColor()
            view.addSubview(self.debugLabel!)
        }
        self.debugLabel!.text = text
    }
    
    class func drawButton(target: AnyObject, name: String, width: Float, height: Float, x_shift: Float, y_shift: Float, image: String) {
        // calculate size and position
        let screenDotSizeX = Float(self.getScreenResolution()["width"]!/100)
        let screenDotSizeY = Float(self.getScreenResolution()["height"]!/100)
        
        let buttonWidth: CGFloat = CGFloat((screenDotSizeX/3.0) * width)
        let buttonHeight: CGFloat = CGFloat((screenDotSizeY/5.325) * height)
        let posX: CGFloat = CGFloat(screenDotSizeX * x_shift - Float(buttonWidth)/2)
        let posY: CGFloat = CGFloat(screenDotSizeY * y_shift - Float(buttonHeight)/2)
        
        // draw buttons
        let image = UIImage(named: image) as UIImage?
        let button = UIButton(type: UIButtonType.Custom) as UIButton
        button.frame = CGRectMake(posX,
                                  posY,
                                  buttonWidth,
                                  buttonHeight)
        button.setImage(image, forState: .Normal)
        button.setTitle(name, forState: UIControlState.Normal)
        button.titleLabel!.hidden = true
        
        button.addTarget(target, action:#selector(ControlYourPartnerViewController.buttonTapped(_:)), forControlEvents:.TouchUpInside)
        
        target.view.addSubview(button)
    }
    
    class func drawGraphic(target: AnyObject, width: Float, height: Float, x_shift: Float, y_shift: Float, image: String) {
        // calculate size and position
        let screenDotSizeX = Float(Utils.getScreenResolution()["width"]!/100)
        let screenDotSizeY = Float(Utils.getScreenResolution()["height"]!/100)
            
        let buttonWidth: CGFloat = CGFloat((screenDotSizeX/3.0) * width)
        let buttonHeight: CGFloat = CGFloat((screenDotSizeY/5.325) * height)
        let posX: CGFloat = CGFloat(screenDotSizeX * x_shift) - buttonWidth/2
        let posY: CGFloat = CGFloat(screenDotSizeY * y_shift) - buttonHeight/2
            
        // draw graphics
        let image = UIImage(named: image) as UIImage?
        
        let imageView = UIImageView(image: image!)
            
        imageView.frame = CGRectMake(posX,
                                     posY,
                                     buttonWidth,
                                     buttonHeight)
        target.view.addSubview(imageView)
    }
    
    class func getScreenResolution() -> Dictionary<String, CGFloat> {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let properties = ["width": screenWidth, "height": screenHeight]
        return properties
    }
    
    class func getVolumeLevel() -> Float {
        let asess = AVAudioSession()
        let volLvl = asess.outputVolume
        return volLvl
    }
    
    class func drawBackground(view: UIView, imgFileName: String) {
        let bkgdImage = UIImage(named: imgFileName)
        let bkgdImageView = UIImageView(image: bkgdImage!)
        
        bkgdImageView.frame = CGRect(x: 0, y: 0,
                                     width: Utils.getScreenResolution()["width"]!,
                                     height: Utils.getScreenResolution()["height"]!)
        view.addSubview(bkgdImageView)
    }
}