

import UIKit
import Kingfisher

class StickerIcon: UICollectionViewCell {
    static let identifier = "StickerIcon"
    
    @IBOutlet weak var stickerImage: UIImageView!


    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.stickerImage.image = nil
    }
	
    func configure(for sticker: String, inPack pack:Int,emoji:Bool) {
       
        let url = URL(string: (sticker))
 
		
        if emoji == true {
            //self.stickerImage.image = UIImage(named: sticker)
            stickerImage.kf.setImage(with: url)
        }
        else{
           
            
             self.stickerImage.image = UIImage.gifImageWithName(sticker)
        }

	}
}
