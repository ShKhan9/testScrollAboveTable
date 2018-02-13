
import UIKit

extension ViewController: UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menuInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Dequeue the cell to load data
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell",
                                                 for: indexPath) as! TableViewCell
        
        cell.foodNameLabel.text = menuInfo[indexPath.row].foodName
        cell.foodPriceLabel.text = menuInfo[indexPath.row].foodPrice
        
        cell.contentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.contentView.layer.shadowOpacity = 1.0
        cell.contentView.layer.shadowRadius = 0.0
        cell.contentView.layer.masksToBounds = false
        cell.contentView.layer.cornerRadius = 4.0
        
        let longPressGesture: UILongPressGestureRecognizer = {
            let gesture = UILongPressGestureRecognizer()
            gesture.addTarget(self, action: #selector(self.handleLongPressGetureForRow(v:)))
            gesture.delaysTouchesBegan = false
            gesture.cancelsTouchesInView = false
            gesture.numberOfTouchesRequired = 1
            gesture.minimumPressDuration = 0.2
            return gesture
        }()
        cell.addGestureRecognizer(longPressGesture)
        cell.tag = indexPath.row
        
        return cell
    }
    @objc func handleLongPressGetureForRow(v: UILongPressGestureRecognizer )
  {
      print("saghsaghghsgfsgsaghghsaghsaghghsaghashgsasa")
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        //let headerCell = tableView.dequeueReusableCell(withIdentifier: "MenuHeaderCell") as! MenuHeaderViewCell
        
        let vc =  UIView()
        vc.backgroundColor = self.colorqw
        return vc
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 34.0
    }
}

extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! TableViewCell
        UIView.transition(with: selectedCell, duration: 0.6, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
        // Deselects the row
        tableView.deselectRow(at: indexPath,
                              animated: true)
    }
    
    
    @available(iOS 11, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, bool) in
            print("Delete")
            bool(false)
        }
        action.image =  #imageLiteral(resourceName: "canPlus")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    
    }
}

extension ViewController: UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        return
        print("ddffddfd \(scrollView.contentOffset.y)")
        
        
        if scrollView.contentOffset.y >= 20*32 && scrollView.contentOffset.y <= (20*32) + 34
        {
            
            print("OKKIKKKKKKKkOKKIKKKKKKKk OKKIKKKKKKKkOKKIKKKKKKKkOKKIKKKKKKKkOKKIKKKKKKKk")
            
            var df = dataTableView.headerView(forSection: 0)
            
            df?.backgroundColor = UIColor.blue
            
            df?.setNeedsDisplay()
            
            dataTableView.reloadData()
        }
        
        
        
        
        
       /* if scrollView.contentOffset.y > 0 && imageContainerViewHeightConstraint.constant == 223
        {
            return
        }
        
        if scrollView.contentOffset.y > 0
        {
            
            var sd = imageContainerViewHeightConstraint.constant + abs(scrollView.contentOffset.y)
            
            
            if(sd < 233 )
            {
                
                print("path111    1")
                
                  self.dataTableView.contentOffset = CGPoint.init(x: 0, y: 0  )
                
                return
                    
                
            }
            else
            {
                 print("path111    2")
                 imageContainerViewHeightConstraint.constant -= abs(scrollView.contentOffset.y)
            }
           
             print("path11111    3")
            view.layoutIfNeeded()
            
             self.dataTableView.contentOffset = CGPoint.init(x: 0, y: 0  )
            return
        }
       
        
         print("path11111   4")
        
     
        
        
        if scrollView.contentOffset.y < 0 && imageContainerViewHeightConstraint.constant >= initialContainerImageViewHeight * 2
        {
            self.dataTableView.contentOffset = CGPoint.init(x: 0, y: 0  )
            
            //self.dataTableView.bounces = false
            
            return
        }
        else
        {
            imageContainerViewHeightConstraint.constant += abs(scrollView.contentOffset.y)
            
             view.layoutIfNeeded()
            
        } */
      
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        resetContainerViewSize()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        resetContainerViewSize()
    }
}

struct MenuInfo
{
    var foodName: String?
    var foodPrice: String?
    
    // Initialize default data
    init()
    {
        foodName = "Food"
        foodPrice = "See Vendor"
    }
}

@objc class ViewController: UIViewController
{
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var dataTableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    var colorqw:UIColor!
    fileprivate var initialContainerImageViewHeight: CGFloat = 0.0
    
    
    public var menuInfo = [MenuInfo]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        let userData : [String:Any] = [
            
            "email" : "qwwwwww" ,
            "hasBeenLoggedIn" : false
            
        ]
        
        UserDefaults.standard.set(userData, forKey: "userData")
        
        
        
        var rr  = UserDefaults.standard.dictionary(forKey: "userData")
        
        print("sdfggdfgdfsgdsgds\(rr)")
        
        rr?["hasBeenLoggedIn"] = true
        
        
            UserDefaults.standard.set(rr, forKey: "userData")
        
        var ff  = UserDefaults.standard.dictionary(forKey: "userData") as! [String:Any]
        
        print("qqqwwww     sdfggdfgdfsgdsgds\(ff)")
       //  print("after sdfggdfgdfsgdsgds\(rr)")
        colorqw = UIColor.red;
        
        
        self.dataTableView.estimatedSectionHeaderHeight = 20.0
        self.dataTableView.contentInset = UIEdgeInsetsMake(-32.0, 0.0, 0.0, 0.0)
        
        for i in 0...20
        {
            
            menuInfo.append(MenuInfo.init())
            
        }

        backgroundImageView.image = #imageLiteral(resourceName: "default_background")
        imageView.image = #imageLiteral(resourceName: "greeneggcompany")
        imageView.clipsToBounds = true
        initialContainerImageViewHeight = imageContainerView.frame.size.height
        
        dataTableView.tableFooterView = UIView()
        
        dataTableView.dataSource = self
        dataTableView.delegate = self
    }

    func resetContainerViewSize()
    {
        imageContainerViewHeightConstraint.constant = 223
        
        UIView.animate(withDuration: 0.7,
                       delay: 0.0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
                        self.view.layoutIfNeeded()
                        
                         self.dataTableView.bounces = true
                    }, completion: nil)
    }
}
