/*-------------------------------
 
 - Classifier -
 
 @author thfrknyldz
 Created by CarbonCode Technology @2019
 All Rights reserved
 
 -------------------------------*/

import UIKit
import ParseFacebookUtilsV4
import Parse


class Wizard: UIViewController,
CLLocationManagerDelegate,
UIScrollViewDelegate
{

    /* Views */
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var signInButton: UIButton!
    
    
    
    
    /* Variables */
    var scrollTimer = Timer()

    
    
    
    
    
    
    
    // SET THE NUMBER OF IMAGES ACCORDINGLY TO THE IMAGES YOU'VE PLACED IN THE 'WIZARD IMAGES' FOLDER IN Assets.xcassets
    let numberOfImages = 3
    
    
    
    
    
// Hide the status bar
override var prefersStatusBarHidden : Bool {
    return true
}

    
    
override func viewDidLoad() {
        super.viewDidLoad()
    

    
    // Call functions
    setupWizardImages()
    
    
    // COMMENT THIS LINE OF CODE IF YOU DON'T WANT AN AUTOMATIC SCROLL OF THE WIZARD
    scrollTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(automaticScroll), userInfo: nil, repeats: true)

}


    
    
    
// MARK: - SETUP WIZARD IMAGES
func setupWizardImages() {
        // Variables for setting the Views
        var xCoord:CGFloat = 0
        let yCoord:CGFloat = 0
        let width:CGFloat = view.frame.size.width
        let height: CGFloat = view.frame.size.height
        
        // Counter for items
        var itemCount = 0
        
        // Loop for creating imageViews -----------------
        for i in 0..<numberOfImages {
            itemCount = i
            
            // Create the imageView
            let aImage = UIImageView()
            aImage.frame = CGRect(x: xCoord,
                                  y: yCoord,
                                  width: width,
                                  height: height)
            aImage.image = UIImage(named: "wizard\(i)")
            aImage.contentMode = .scaleAspectFill
            aImage.clipsToBounds = true
            aImage.alpha = 0.6
            
            
            // Create the Label
            let textLabel = UILabel()
            textLabel.frame = CGRect(x:xCoord + 20,
                                  y:view.frame.size.height - 280,
                                  width: view.frame.size.width - 40,
                                  height: 100)
            textLabel.numberOfLines = 8
            textLabel.adjustsFontSizeToFitWidth = true
            textLabel.font = UIFont(name: "Titillium-Regular", size: 15)
            textLabel.textColor = UIColor.white
            textLabel.textAlignment = .center
            textLabel.adjustsFontSizeToFitWidth = true
            textLabel.shadowOffset = CGSize(width: 1, height: 1)
            textLabel.shadowColor = UIColor.darkGray
            textLabel.text = wizardLabels[i]
            

            // Add imageViews one after the other
            xCoord +=  width
            containerScrollView.addSubview(aImage)
            containerScrollView.addSubview(textLabel)
        } // end For Loop --------------------------
        
        // Place ImageViews into the container ScrollView
        containerScrollView.contentSize = CGSize(width: width * CGFloat(itemCount+1), height: yCoord)
}
    
    

// MARK: - SCROLLVIEW DELEGATE: SHOW CURRENT PAGE IN THE PAGE CONTROL
func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let pageWidth = containerScrollView.frame.size.width
    let page = Int(floor((containerScrollView.contentOffset.x * 2 + pageWidth) / (pageWidth * 2)))
    pageControl.currentPage = page
    
    /*
    if page == numberOfImages-1 {
        // Show the Sign In button
        signInButton.isHidden = false
    }
     */
}
    
   
    
    
// MARK: - AUTOMATIC SCROLL
@objc func automaticScroll() {
    var scroll = containerScrollView.contentOffset.x
    if scroll < CGFloat(view.frame.size.width) * CGFloat(numberOfImages-1) {
        scroll += CGFloat(view.frame.size.width)
        containerScrollView.setContentOffset(CGPoint(x: scroll, y:0), animated: true)
    } else {
        // Stop the timer
        scrollTimer.invalidate()
    }
}


    
    
    

    
// MARK: - FACEBOOK LOGIN BUTTON
@IBAction func facebookButt(_ sender: Any)
{
    //let alert = UIAlertController(title: APP_NAME,
    //                              message: "Facebook Login is not available in demo app.",
    //                              preferredStyle: .alert)
//
    //self.present(alert, animated: true, completion: nil)
    
    
    let alertController = UIAlertController(title:APP_NAME,
                                            message:"Facebook Login is not available in demo app",
                                            preferredStyle:.alert)
    self.present(alertController,animated:true,completion:{Timer.scheduledTimer(withTimeInterval: 2, repeats:false, block: {_ in
        self.dismiss(animated: true, completion: nil)
    })})

    //let alert = UIAlertController(title: APP_NAME,
    //    message: "Do you agree with our Terms of Service?",
    //    preferredStyle: .alert)
    //
    //let yes = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
    //    // Set permissions required from the facebook user account
    //    let permissions = ["public_profile", "email"];
    //    //self.showHUD("Please Wait...")
    //
    //    // Login PFUser using Facebook
    //    PFFacebookUtils.logInInBackground(withReadPermissions: permissions) { (user, error) in
    //        if user == nil {
    //            self.simpleAlert("Facebook login cancelled")
    //            self.hideHUD()
    //
    //        } else if (user!.isNew) {
    //            print("NEW USER signed up and logged in through Facebook!");
    //            self.getFBUserData()
    //
    //        } else {
    //            print("OLD USER logged in through Facebook!");
    //
    //            // Go back to Home screen
    //            let tbc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBar") as! //UITabBarController
    //            tbc.selectedIndex = 0
    //            self.present(tbc, animated: false, completion: nil)
    //
    //            self.hideHUD()
    //        }}
    //})
    //
    //
    //// Read Terms of Service
    //let tos = UIAlertAction(title: "Read Terms of Service", style: .default, handler: { (action) -> Void in
    //    self.tosButt(self)
    //})
    //
    //
    //// Cancel button
    //let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
    //
    //alert.addAction(yes)
    //alert.addAction(tos)
    //alert.addAction(cancel)
    //present(alert, animated: true, completion: nil)
    //
//
    //
}
    
    
func getFBUserData() {
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, picture.type(large)"])
        let connection = FBSDKGraphRequestConnection()
        connection.add(graphRequest) { (connection, result, error) in
            if error == nil {
                let userData:[String:AnyObject] = result as! [String : AnyObject]
 
                let currUser = PFUser.current()!
                
                // Get data
                let facebookID = userData["id"] as! String
                let name = userData["name"] as! String
                var email = ""
                if userData["email"] != nil { email = userData["email"] as! String
                } else { email = "noemail@facebook.com" }
                
                // Get avatar
                let pictureURL = URL(string: "https://graph.facebook.com/\(facebookID)/picture?type=large")
                let urlRequest = URLRequest(url: pictureURL!)
                let session = URLSession.shared
                let dataTask = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                    if error == nil && data != nil {
                        let image = UIImage(data: data!)
                        let imageData = UIImageJPEGRepresentation(image!, 0.8)
                        let imageFile = PFFile(name:"avatar.jpg", data:imageData!)
                        currUser[USER_AVATAR] = imageFile
                        currUser.saveInBackground(block: { (succ, error) in
                            print("...AVATAR SAVED!")
                            self.hideHUD()

                            let tbc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
                            tbc.selectedIndex = 0
                            self.present(tbc, animated: false, completion: nil)
                        })
                    } else {
                        self.simpleAlert("\(error!.localizedDescription)")
                        self.hideHUD()
                }})
                dataTask.resume()
                
                
                // Update user data
                let nameArr = name.components(separatedBy: " ")
                var username = String()
                for word in nameArr {
                    username.append(word.lowercased())
                }
                currUser.username = username
                currUser.email = email
                currUser[USER_FULLNAME] = name
                currUser[USER_IS_REPORTED] = false
                
                let hasBlocked = [String]()
                currUser[USER_HAS_BLOCKED] = hasBlocked
                
                currUser.saveInBackground(block: { (succ, error) in
                    if error == nil {
                        print("USER'S DATA UPDATED...")
                }})
                
                
            } else {
                self.simpleAlert("\(error!.localizedDescription))")
                self.hideHUD()
        }}
        connection.start()
}
    
    
    
   
    
// MARK: - SIGN IN BUTTON
@IBAction func signInButt(_ sender: Any) {
    let aVC = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "Login") as! Login
    present(aVC, animated: true, completion: nil)
}
    
  
 
    
    
// MARK: - TERMS OF SERVICE BUTTON
@IBAction func tosButt(_ sender: Any) {
    let aVC = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "TermsOfService") as! TermsOfService
    present(aVC, animated: true, completion: nil)
}
    
    
    
    
    
// MARK: - DISMISS BUTTON 
@IBAction func dismissButton(_ sender: Any) {
    // Go to Home screen
    let tbc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
    tbc.selectedIndex = 0
    self.present(tbc, animated: false, completion: nil)
}
    
    
    
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
