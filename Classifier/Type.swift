/*-------------------------------
 
 - Classifier -
 
 @author thfrknyldz
 Created by CarbonCode Technology @2019
 All Rights reserved
 
 -------------------------------*/

import UIKit


class Type: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var typeTableView: UITableView!
    
    
    
    
    /* Variables */
    var typeArr = ["All",
                    "Sell",
                    "Rent",
                    "Exchange",
                    "Gift",
                    ]
    
    var selectedType = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.backgroundColor = MAIN_COLOR
    }
    
    
    
    
    // MARK: - TABLEVIEW DELEGATES
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "\(typeArr[indexPath.row])"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
    // MARK: - CELL TAPPED
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedType = "\(typeArr[indexPath.row])"
        type = selectedType
        dismiss(animated: true, completion: nil)
    }
    
    
 
    //@IBAction func doneButt(_ sender: Any) {
    //    if selectedType != "" {
    //        type = selectedType
    //        dismiss(animated: true, completion: nil)
    //    } else {
    //        simpleAlert("Bir filtre seçmelisiniz!")
    //    }
    //}
    

    
    
    @IBAction func cancelButt(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

