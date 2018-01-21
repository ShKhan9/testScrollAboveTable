
import UIKit

class TableViewCell: UITableViewCell
{
    @IBOutlet var foodNameLabel: UILabel!
    @IBOutlet var foodPriceLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        // Set cell background color to be transparent as it cannot be achieved via storyboard
        backgroundColor = UIColor.clear
    }
}
