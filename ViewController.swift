
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
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 32.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "MenuHeaderCell") as! MenuHeaderViewCell
        return headerCell
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
        // Deselects the row
        tableView.deselectRow(at: indexPath,
                              animated: true)
    }
}

extension ViewController: UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        
        print("ddffddfd \(scrollView.contentOffset.y)")
        
        if scrollView.contentOffset.y > 0 && imageContainerViewHeightConstraint.constant == 223
        {
            return
        }
        
        if scrollView.contentOffset.y > 0
        {
            
            var sd = imageContainerViewHeightConstraint.constant + abs(scrollView.contentOffset.y)
            
            
            if(sd < 223 )
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
            
        }
      
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

class ViewController: UIViewController
{
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var dataTableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!

    fileprivate var initialContainerImageViewHeight: CGFloat = 0.0
    
    
    public var menuInfo = [MenuInfo]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
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
