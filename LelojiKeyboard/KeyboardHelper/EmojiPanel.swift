

import UIKit
import Kingfisher
import RealmSwift

let stickerIconSize: CGFloat = 35.0
let stickerSpacing: CGFloat = 5.0

protocol EmojiPanelDelegate: class {
    func didSelect(image: UIImage!)
    func didSelectGIF(imagename: String!)
    
}

class EmojiPanel: UIView {
   
    weak var delegate: EmojiPanelDelegate?
    var collectionView: UICollectionView!
    var arrEmojiPanel: List<StickerData>!
    var arrSelectedEmoji = [String]()
    var selectedPackIndex: Int = 0
    var isEmoji: Bool!
    var iconSize: CGSize {
        set(newSize) {
            _iconSize = newSize
            collectionView.reloadData()
        }
        get {
            return _iconSize
        }
    }
    var _iconSize = CGSize(width: stickerIconSize, height: stickerIconSize)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = iconSize
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = stickerSpacing
        flowLayout.minimumLineSpacing = stickerSpacing
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = self.bounds
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor.clear
        let nib = UINib(nibName: StickerIcon.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: StickerIcon.identifier)
        collectionView.scrollIndicatorInsets   = UIEdgeInsetsMake(0, 0, 0, -3.0)
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 3.0)
        self.addSubview(collectionView)
    }
    

    
    func reloadCollection(arrData:List<StickerData>) {
        
        self.arrEmojiPanel = arrData
        collectionView.reloadData()
    }
    
    func insertOrUpdate(stk: StickerData) {
        do {
            let realm = try Realm()
            try! realm.write({
                
                let newObj = UseStickers()
                newObj.id = stk.id
                newObj.image = stk.image
                newObj.name = stk.name
                newObj.category = stk.category
                realm.add(newObj)
                
                
                
            })
            
        }catch{
            print("Error to initialising realm \(error)")
        }
        
        
        
    }
    
    
}

extension EmojiPanel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

         return self.arrEmojiPanel.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerIcon.identifier, for: indexPath) as! StickerIcon
        let objeSticker = self.arrEmojiPanel[indexPath.row]
        let imgName = objeSticker.image
        cell.configure(for:imgName,inPack:indexPath.row,emoji:isEmoji)
        return cell
    }
}

extension EmojiPanel: UICollectionViewDelegate { 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView.cellForItem(at: indexPath) as? StickerIcon) != nil {
            let objeSticker = self.arrEmojiPanel[indexPath.row]
            let imgName = objeSticker.image
            let url = URL(string: (imgName))
            self.insertOrUpdate(stk: objeSticker)
            if isEmoji == true {
                KingfisherManager.shared.retrieveImage(with: url!, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                    self.delegate?.didSelect(image: image)
                    self.arrSelectedEmoji.append(objeSticker.id)
                })
               

            }else{

                
                
                delegate?.didSelectGIF(imagename: "a31.gif")
            }

        }
    }
}

extension EmojiPanel : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return iconSize
    }
}
