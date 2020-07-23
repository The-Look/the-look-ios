/*-------------------------------
 
 - Classifier -
 
 @author thfrknyldz
 Created by CarbonCode Technology @2019
 All Rights reserved
 
 -------------------------------*/

import UIKit

class Sell: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let aVC = storyboard?.instantiateViewController(withIdentifier: "SellEditItem") as! SellEditItem
        present(aVC, animated: true, completion: nil)
    }
}
