

import UIKit


class StickerIcon: UICollectionViewCell {
    static let identifier = "StickerIcon"
    
    @IBOutlet weak var stickerImage: UIImageView!


    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.stickerImage.image = nil
    }
	
    func configure(for sticker: String, inPack pack:Int,emoji:Bool) {
       
        
		
        if emoji == true {
            self.stickerImage.image = UIImage(named: sticker)
        }
        else{
           
            
             self.stickerImage.image = UIImage.gifImageWithName(sticker)
        }

	}
}
