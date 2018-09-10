

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
         let url = URL(string: (self.strImg))
        if isPackSelected {
           // stickerImage.image = UIImage(named: self.strImg)
            stickerImage.kf.setImage(with: url)
        } else {
           // stickerImage.image = UIImage(named: self.strImg)
            stickerImage.kf.setImage(with: url)
        }
    }
}
