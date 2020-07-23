/*-------------------------------
 
 - Classifier -
 
 @author thfrknyldz
 Created by CarbonCode Technology @2019
 All Rights reserved
 
 -------------------------------*/

import UIKit
import Parse
import GoogleMobileAds
import AudioToolbox

// MARK: - CATEGORY CELL
class CategoryCell: UICollectionViewCell {
    //@IBOutlet weak var catLabel: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var catLabel: UILabel!
}


// MARK: - HOME CONTROLLER
class Home: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var safeAreaView: UIView!
    @IBOutlet weak var headerView: UIView!
    

    
    @IBOutlet weak var adBannerView: UIView!
    @IBOutlet weak var adBannerViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var categoriesCollView: UICollectionView!
    
    @IBOutlet weak var chatsOutlet: UIButton!
    
    
    @IBOutlet weak var appNameLabel: UILabel!
    
    
    let adMobBannerView = GADBannerView()
    
    /* Variables */
    var categoriesArray: [PFObject] = []
    var cellSize = CGSize()
    var string: String?
    var substringchat: String?
    var substringlike: String?
    var substringcomment: String?
    var substringfeedback: String?
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appNameLabel.text = APP_NAME.uppercased()
        
        IQKeyboardManager.shared.enable = false
        
        
        // Set cells size
        let cellSizeConst = homecellWidth
        cellSize = CGSize(width: cellSizeConst, height: cellSizeConst/2.35)
        
        // Set header background color
        headerView.backgroundColor = MAIN_COLOR
        safeAreaView.backgroundColor = MAIN_COLOR
        
        // Init ad banners
        //initAdMobBanner()
        
        // Call query
        queryCategories()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //searchPlaceholderLabel.isHidden = !searchTextField.text!.isEmpty
        selectedCategory = "All"
        selectedSubCategory = "All"

        //changeTabBar(hidden: false, animated: true)


        
        //setupPushNotifications()
    }
    
    // ENTER CHATS BUTTON
    @IBAction func chatsButt(_ sender: Any) {
        if PFUser.current() != nil {

            let aVC = storyboard?.instantiateViewController(withIdentifier: "Chats") as! Chats
            navigationController?.pushViewController(aVC, animated: true)
        } else {
            showLoginAlert("You need to be logged in to see your Chats. Want to Login now?")
        }
    }

    
    
    // MARK: - QUERY CATEGORIRS
    func queryCategories() {
        showHUD("Please Wait...")
        
        let query = PFQuery(className: CATEGORIES_CLASS_NAME)
        query.order(byAscending: "createdAt")
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                //self.categoriesArray.insert(objects![0], at: 0)
                //self.categoriesArray.insert(objects![1], at: 1)
                //self.categoriesArray.insert(objects![4], at: 2)
                self.categoriesArray = objects!
                self.hideHUD()
                self.categoriesCollView.reloadData()
            } else {
                self.simpleAlert("\(error!.localizedDescription)")
                self.hideHUD()
            }
        }
    }
    
    //func changeTabBar(hidden:Bool, animated: Bool){
    //    let tabBar = self.tabBarController?.tabBar
    //    let offset = (hidden ? UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.height - //(tabBar?.frame.size.height)! )
    //    if offset == tabBar?.frame.origin.y {return}
    //    print("changing origin y position")
    //    let duration:TimeInterval = (animated ? 0.5 : 0.0)
    //    UIView.animate(withDuration: duration,
    //                   animations: {tabBar?.frame.origin.y = offset},
    //                   completion:nil)
    //}
    
    //// MARK: - ADMOB BANNER METHODS
    //func initAdMobBanner() {
    //    adMobBannerView.adSize = GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
    //    adMobBannerView.frame = adBannerView.frame
    //    adMobBannerView.adUnitID = ADMOB_BANNER_UNIT_ID
    //    adMobBannerView.rootViewController = self
    //    adMobBannerView.delegate = self
    //
    //    view.addSubview(adMobBannerView)
    //
    //    let request = GADRequest()
    //    adMobBannerView.load(request)
    //}
    //
    //// Hide the banner
    //func hideBanner(_ banner: UIView) {
    //    UIView.beginAnimations("hideBanner", context: nil)
    //    banner.frame = adBannerView.frame
    //    UIView.commitAnimations()
    //    banner.isHidden = true
    //
    //    adBannerViewHeight.constant = 0
    //    view.layoutIfNeeded()
    //}
    //
    //// Show the banner
    //func showBanner(_ banner: UIView) {
    //    adBannerViewHeight.constant = 50
    //    view.layoutIfNeeded()
    //
    //    UIView.beginAnimations("showBanner", context: nil)
    //    banner.frame = adBannerView.frame
    //    UIView.commitAnimations()
    //    banner.isHidden = false
    //}
    //
    //
    //
    //// AdMob banner available
    //func adViewDidReceiveAd(_ view: GADBannerView) {
    //    print("AdMob loaded!")
    //    showBanner(adMobBannerView)
    //}
    //
    //// NO AdMob banner available
    //func adView(_ view: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
    //    print("AdMob Can't load ads right now, they'll be available later \n\(error)")
    //    hideBanner(adMobBannerView)
    //}
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Helpers
    //fileprivate func setupPushNotifications() {
    //    // Associate the device with a user for Push Notifications
    //
    //    guard PFUser.current() != nil else {
    //        return
    //    }
    //
    //    let installation = PFInstallation.current()
    //    installation?["username"] = PFUser.current()!.username
    //    installation?["userID"] = PFUser.current()!.objectId!
    //
    //    installation?.saveInBackground(block: { (succ, error) in
    //        if error == nil {
    //            print("PUSH REGISTERED FOR: \(PFUser.current()!.username!)")
    //        }})
    //}
}



//extension String {
//    func capitalizingFirstLetter() -> String {
//        return prefix(1).capitalized + dropFirst()
//    }
//
//    mutating func capitalizeFirstLetter() {
//        self = self.capitalizingFirstLetter()
//    }
//}


extension Home: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        var cObj = PFObject(className: CATEGORIES_CLASS_NAME)
        cObj = categoriesArray[indexPath.row]
        
        cell.catLabel.text = "\(cObj[CATEGORIES_CATEGORY]!)".uppercased()
        
        let imageFile = cObj[CATEGORIES_IMAGE] as? PFFile
        imageFile?.getDataInBackground(block: {
            (data, error) in
            if error == nil, let imageData = data
            {
                cell.catImage.image = UIImage(data: imageData)
            }
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
     //TAP ON A CELL -> SHOW ADS
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var cObj = PFObject(className: CATEGORIES_CLASS_NAME)
        cObj = categoriesArray[indexPath.row]
        
        //selectedHomeCategoryID = "\(cObj[CATEGORIES_HOME_ID]!)"
        selectedCategory = "\(cObj[CATEGORIES_CATEGORY]!)"
        selectedSubCategory = "All"
        
        //let aVC = storyboard?.instantiateViewController(withIdentifier: "AdsList") as! AdsList
        let aVC = storyboard?.instantiateViewController(withIdentifier: "HomeSubCategory") as! HomeSubCategory
        navigationController?.pushViewController(aVC, animated: true)
    }
    
}

