

import UIKit


class StickerPackIcon: UICollectionViewCell {
    static let identifier = "StickerPackIcon"
    
    @IBOutlet weak var stickerImage: UIImageView!
    fileprivate var strImg : String = ""
    
    var isPackSelected: Bool = false
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.stickerImage.image = nil
    }
    
    func configure(packname:String, isSelected: Bool) {
        self.strImg = packname
        self.isPackSelected = isSelected
        updateIcon()
    }
    
    func setPackSelected(_ newValue: Bool = true) {
        isPackSelected = newValue
        updateIcon()
    }
    
    private func updateIcon() {
        if isPackSelected {
            stickerImage.image = UIImage(named: self.strImg)
        } else {
            stickerImage.image = UIImage(named: self.strImg)
        }
    }
}
