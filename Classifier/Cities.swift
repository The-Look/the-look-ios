/*-------------------------------
 
 - Classifier -
 
 @author thfrknyldz
 Created by CarbonCode Technology @2019
 All Rights reserved
 
 -------------------------------*/

import UIKit
import Parse




class Cities: UIViewController,
UITableViewDelegate,
UITableViewDataSource {
   
    
    /*Views*/
    @IBOutlet weak var cityTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    
    /*Variables*/
    var cities = [String]()
    var selCity = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.backgroundColor = MAIN_COLOR
        
        cities.removeAll()
        cities.append("All")
        
        // Call query
        queryCities()
        
    }
    
    func queryCities() {
        
        let query = PFQuery (className: CITIES_CLASS_NAME)
        query.findObjectsInBackground { (objects, error) in
            if error == nil{
                
                for i in 0..<objects!.count {
                    var cObj = PFObject (className: CITIES_CLASS_NAME)
                    cObj = objects![i]
                    
                    self.cities.append("\(cObj[CITIES_CITY]!)")
                }
                
                self.hideHUD()
                self.cityTableView.reloadData()
                
            } else {
                self.simpleAlert("\(error!.localizedDescription)")
                self.hideHUD()
        }}
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(cities[indexPath.row])"
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selCity = "\(cities[indexPath.row])"
        selectedCity = selCity
        dismiss(animated: true, completion: nil)
    }
    
    //@IBAction func doneButt(_ sender: Any) {
    //
    //    if selCity != ""{
    //        selectedCity = selCity
    //        dismiss(animated: true, completion: nil)
    //    } else {
    //        simpleAlert("Bir şehir seçmelisinz!")
    //    }
    //
    //}
    
    
    @IBAction func cancelButt(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
