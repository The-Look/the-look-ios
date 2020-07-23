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

// MARK: - SUBCATEGORY CELL
class SubCategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var subcatImage: UIImageView!
    @IBOutlet weak var subcatLabel: UILabel!
}

// MARK: - HOME CONTROLLER
class HomeSubCategory: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var subcategoriesCollView: UICollectionView!
    
    @IBOutlet weak var appNameLabel: UILabel!
    
    /* Variables */
    var subcategoriesArray: [PFObject] = []
    var cellSize = CGSize()
    var string: String?
    //var substringchat: String?
    //var substringlike: String?
    //var substringcomment: String?
    //var substringfeedback: String?
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        IQKeyboardManager.shared.enable = false
        
        appNameLabel.text = APP_NAME.uppercased()

        // Set cells size
        let cellSizeConst = homecellWidth
        cellSize = CGSize(width: cellSizeConst, height: cellSizeConst/2.35)
        
        // Set header background color
        headerView.backgroundColor = MAIN_COLOR
        
        // Init ad banners
        //initAdMobBanner()
        
        // Call query
        querySubCategories()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //searchPlaceholderLabel.isHidden = !searchTextField.text!.isEmpty
        
        //changeTabBar(hidden: false, animated: true)
        
        
        
        //setupPushNotifications()
    }

    
    // MARK: - QUERY CATEGORIRS
    func querySubCategories() {
        //showHUD("Please Wait...")
        
        let query = PFQuery(className: SUBCATEGORIES_CLASS_NAME).whereKey(SUBCATEGORIES_TOPCATEGORY, equalTo: selectedCategory)
        query.order(byAscending: "createdAt")
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                //self.categoriesArray.insert(objects![0], at: 0)
                //self.categoriesArray.insert(objects![1], at: 1)
                //self.categoriesArray.insert(objects![4], at: 2)
                self.subcategoriesArray = objects!
                self.hideHUD()
                self.subcategoriesCollView.reloadData()
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
    
    @IBAction func backButt(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    ////Helpers
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


extension HomeSubCategory: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subcategoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryCell", for: indexPath) as! SubCategoryCell
        
        var cObj = PFObject(className: SUBCATEGORIES_CLASS_NAME)
        cObj = subcategoriesArray[indexPath.row]
        
        cell.subcatLabel.text = "\(cObj[SUBCATEGORIES_SUBCATEGORY]!)".uppercased()
        
        let imageFile = cObj[SUBCATEGORIES_IMAGE] as? PFFile
        imageFile?.getDataInBackground(block: {
            (data, error) in
            if error == nil, let imageData = data
            {
                cell.subcatImage.image = UIImage(data: imageData)
            }
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    //TAP ON A CELL -> SHOW ADS
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var cObj = PFObject(className: SUBCATEGORIES_CLASS_NAME)
        cObj = subcategoriesArray[indexPath.row]
        
        //selectedHomeCategoryID = "\(cObj[CATEGORIES_HOME_ID]!)"
        selectedSubCategory = "\(cObj[SUBCATEGORIES_SUBCATEGORY]!)"
        //selectedSubCategory = "All"
        
        let aVC = storyboard?.instantiateViewController(withIdentifier: "AdsList") as! AdsList
        navigationController?.pushViewController(aVC, animated: true)
    }
    
}
