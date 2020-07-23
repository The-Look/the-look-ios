/*-------------------------------
 
 - Classifier -
 
 @author thfrknyldz
 Created by CarbonCode Technology @2019
 All Rights reserved
 
 -------------------------------*/

import UIKit
import Parse



class Subcategories: UIViewController,
    UITableViewDelegate,
    UITableViewDataSource
{
    
    /* Views */
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var subcatTableView: UITableView!
    
    
    /* Variables */
    var subCategories = [String]()
    var selSubCateg = ""
    
    var subCatArr = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.backgroundColor = MAIN_COLOR
        
        subCategories.removeAll()
        subCategories.append("All")
        
        
        // Call query
        queryCategories()
    }
    
    
    // MARK: - QUERY CATEGORIES
    func queryCategories() {
        showHUD("Please wait")
        
        //let query = PFQuery(className: SUBCATEGORIES_CLASS_NAME)
        let query = PFQuery(className: SUBCATEGORIES_CLASS_NAME).whereKey(SUBCATEGORIES_TOPCATEGORY, equalTo: selectedCategory)
        var cObj = PFObject(className: SUBCATEGORIES_CLASS_NAME)

        //topCategoryPointer.fetchIfNeededInBackground(block: { (object, error) in
        //if error == nil {
        
        query.findObjectsInBackground { (objects, error) in
            if error == nil {


                for i in 0..<objects!.count {
                    cObj = objects![i]
                    
                    //let topCategory = cObj[SUBCATEGORIES_TOPCATEGORY] as! String
                    //print(topCategory)
                    //for i in 0..<cObj.count where topCategory.isEqual(selectedCategory) {
                    //if topCategory == selectedCategory{
                    //cObj = objects![i]
                    
                    //where topCategoryPointer.isEqual(selectedCategory)
                    //self.subCategories.append("\(cObj[SUBCATEGORIES_SUBCATEGORY]!)")
                    
                    //topCategoryPointer.isEqual(selectedCategory)
                    
                    self.subCategories.append("\(cObj[SUBCATEGORIES_SUBCATEGORY]!)")
                    //}
                    //}
                }
                
                self.hideHUD()
                self.subcatTableView.reloadData()
                
            } else {
                self.simpleAlert("\(error!.localizedDescription)")
                self.hideHUD()
            }}
            
        //    }
    //
        //})
        
    }
    
    
    
    // MARK: - TABLEVIEW DELEGATES
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "\(subCategories[indexPath.row])"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
    // MARK: - CELL TAPPED -> SELECT A CATEGORY
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selSubCateg = "\(subCategories[indexPath.row])"
        selectedSubCategory = selSubCateg
        //let aVC = storyboard?.instantiateViewController(withIdentifier: "SubCategories") as! SubCategories
        //present(aVC, animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
        
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
        //self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
        //self.presentingViewController?.dismiss(animated: true, completion: {
        //    let secondPresentingVC = self.presentingViewController?.presentingViewController;
        //    secondPresentingVC?.dismiss(animated: true, completion: {});
        //
        //});
        

    }
    
    @IBAction func cancelButt(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


