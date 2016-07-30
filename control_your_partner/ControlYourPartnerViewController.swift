
//
//  ViewController.swift
//  control_your_woman
//
//  Created by Marcin on 27.12.2015.
//
//

import UIKit
import AVFoundation


protocol ControlYourPartnerViewControllerDelegate: class {
}


class ControlYourPartnerViewController: UINavigationController {
    
    weak var controlYourPartnerDelegate: ControlYourPartnerViewControllerDelegate?
    var statusBarStyle: UIStatusBarStyle = .Default
    
    var buttonParamsFile: String! = nil // zmienic na konstruktor klasy
    var imagesParamsFile: String! = nil // zmienic na konstruktor klasy
    var backgroundImgFile: String! = nil // zmienic na konstruktor klasy
    
    var buttonParams = Dictionary<String, Dictionary<String, String>>()
    var imagesParams = Dictionary<String, Dictionary<String, String>>()
    var player: AudioPlayer?
    var led: LEDAnimation?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        statusBarStyle = UIApplication.sharedApplication().statusBarStyle
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().setStatusBarStyle(statusBarStyle, animated: animated)
    }
    
    
    func loadMediaObjectsParams(jsonFileName: String) -> Dictionary<String, Dictionary<String, String>> {
        var params = Dictionary<String, Dictionary<String, String>>()
        if let path = NSBundle.mainBundle().pathForResource(jsonFileName, ofType: "json")
        {
            let jsonData = NSData(contentsOfFile: path)
            do {
                if let jsonConfig = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: []) as? NSDictionary {
                    for (key, value) in jsonConfig {
                        //self.buttonParams[btnname as! String] = (btncfg as! Dictionary)
                        params[key as! String] = (value as! Dictionary)
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        return params
    }
    
    func drawButtons() {
        for (btnname, btncfg) in self.buttonParams {
            Utils.drawButton(self, name: btnname,
                             width: Float(btncfg["width"]!)!,
                             height: Float(btncfg["height"]!)!,
                             x_shift: Float(btncfg["x_shift"]!)!,
                             y_shift: Float(btncfg["y_shift"]!)!,
                             image: btncfg["image"]!)
        }
    }
    
    func drawGraphics() {
        for (_, imgcfg) in self.imagesParams {
            Utils.drawGraphic(self,
                              width: Float(imgcfg["width"]!)!,
                              height: Float(imgcfg["height"]!)!,
                              x_shift: Float(imgcfg["x_shift"]!)!,
                              y_shift: Float(imgcfg["y_shift"]!)!,
                              image: imgcfg["image"]!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.hidden = true
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        Utils.drawBackground(self.view, imgFileName: self.backgroundImgFile)
        self.buttonParams = loadMediaObjectsParams(self.buttonParamsFile)
        self.imagesParams = loadMediaObjectsParams(self.imagesParamsFile)
        drawButtons()
        drawGraphics()
        self.led = LEDAnimation(view: self.view)
        self.player = AudioPlayer()
        
        for (_, btncfg) in self.buttonParams {
            player?.prepareToPlay(btncfg["audio_file"]!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonTapped(tappedButton: UIButton) {
        let buttonTitle = tappedButton.titleLabel?.text
        //print("Tapped button: \(buttonTitle)")
        
        if (buttonTitle == "button_exit") {
            backToSelectMenu()
        }
        
        let buttonSoundName = buttonParams[buttonTitle!]!["audio_file"]
        self.player!.play(buttonSoundName!)
        self.led!.blink()
    }

    func backToSelectMenu() {
        let controller = ViewController()
        presentViewController(controller, animated: true, completion: nil)
    }
    
    // turn off autorotate
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    // hide status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
