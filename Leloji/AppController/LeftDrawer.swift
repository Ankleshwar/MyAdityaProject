



import UIKit



class LeftDrawer: BaseViewController{



    var arrValue: Array<Dictionary<String,Any>>?
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        arrValue = setDataWithLocalJson("LeftDrawer") as NSArray as? Array<Dictionary<String, Any>>
        
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
      tableView.separatorStyle = .none
        
 
    }

    
    @IBOutlet weak var clickToBack: UIButton!
    
    @IBAction func clickMenuOff(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
  
}


extension LeftDrawer: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        cell.textLabel?.text = arrValue?[indexPath.row]["name"] as? String
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.backgroundColor = UIColor.clear
        cell.separatorInset = .zero
    
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.arrValue?.count)!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
             let menuVC = HomeVC(nibName: "HomeVC", bundle: nil)
                self.setController(vc: menuVC)
        
        
        }else if indexPath.row == 1 {
            
            let menuVC = SubscriptionVC(nibName: "SubscriptionVC", bundle: nil)
            self.setController(vc: menuVC)
            
            
            
        }else if indexPath.row == 2 {
            
            let menuVC = ReferAfriendVC(nibName: "ReferAfriendVC", bundle: nil)
            self.setController(vc: menuVC)
            
            
            
        }
        else if indexPath.row == 3 {
            
            let menuVC = SuggestionVC(nibName: "SuggestionVC", bundle: nil)
            self.setController(vc: menuVC)
            
            
            
        }
            
            
        else if indexPath.row == 4 {
            
            let menuVC = RateUs(nibName: "RateUs", bundle: nil)
            self.setController(vc: menuVC)
            
            
            
        }
            
        else if indexPath.row == 5 {
          
                let menuVC = ProfileVC(nibName: "ProfileVC", bundle: nil)
                self.setController(vc: menuVC)
                
                
            
        }
        else if indexPath.row == 6{
            self.logOutUser()
            let delegate =  UIApplication.shared.delegate as! AppDelegate
            delegate.setRootController()
            
        }
    }
    
    func setController(vc:UIViewController){
        self.present(vc as UIViewController,
                     animated: true,
                     completion: nil)
    }
    
    
}

