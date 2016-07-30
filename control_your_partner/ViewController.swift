import UIKit


class ViewController: UIViewController, ControlYourPartnerViewControllerDelegate {
    
    @IBOutlet weak var urlLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGrayColor()
        Utils.drawBackground(self.view, imgFileName: "background.png")
        
        Utils.drawButton(self,
                         name: "man",
                         width: 120,
                         height: 120,
                         x_shift: 28,
                         y_shift: 40,
                         image: "man_select_menu_button")
        Utils.drawButton(self,
                         name: "woman",
                         width: 120, height: 120,
                         x_shift: 72,
                         y_shift: 40,
                         image: "woman_select_menu_button")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonTapped(button: UIButton) {
        let buttonTitle = button.titleLabel?.text
        let controller = ControlYourPartnerViewController()
        controller.controlYourPartnerDelegate = self
        controller.buttonParamsFile = buttonTitle! + "_buttonsParams"
        controller.imagesParamsFile = buttonTitle! + "_imagesParams"
        controller.backgroundImgFile = buttonTitle! + "_background.png"
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    // turn off autorotate
    override func shouldAutorotate() -> Bool {
        return false
    }
}
