
import UIKit

class MenuHeaderViewCell: UITableViewCell
{
    @IBOutlet weak var menuLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        menuLabel.text = "🌮 Food Menu 🌭"
    }
}
