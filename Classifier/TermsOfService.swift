/*-------------------------------
 
 - Classifier -
 
 @author thfrknyldz
 Created by CarbonCode Technology @2019
 All Rights reserved
 
 -------------------------------*/

import UIKit

class TermsOfService: UIViewController {
    
    /* Views */
    
    @IBOutlet var webView: UIWebView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set app main color
        view.backgroundColor = MAIN_COLOR
        
        // Show tou.html
        let url = Bundle.main.url(forResource: "tos", withExtension: "html")
        webView.loadRequest(URLRequest(url: url!))
    }
    
    // DISMISS BUTTON
    @IBAction func dismissButt(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
