//
//  ThumbnilVC.swift
//  LelojiKeyboard
//
//  Created by Ankleshwar on 16/04/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit


let stickerPackIconSize: CGFloat = 30.0
let stickerPackSpacing: CGFloat = 7.0

protocol ThumbnilVCDelegate: class {
    func didSelectPack(at packIndex: Int)
}


class ThumbnilVC: UIView {
    
    var dataSource: StickerDataSource?
    var arrayThumbnil = NSMutableArray()
    var collectionView: UICollectionView!
    weak var delegate: ThumbnilVCDelegate?
    var selectedPackIndex: Int = 0
    var emojiPanel: EmojiPanel!
    var isKeyboard:Bool!
    var iconSize: CGSize {
        set(newSize) {
            _iconSize = newSize
            collectionView.reloadData()
        }
        get {
            return _iconSize
        }
    }
    var _iconSize = CGSize(width: stickerPackIconSize, height: stickerPackIconSize)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = iconSize
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = stickerPackSpacing
        flowLayout.minimumLineSpacing = stickerPackSpacing
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        collectionView.delegate = self as UICollectionViewDelegate
        collectionView.dataSource = self as UICollectionViewDataSource
        collectionView.frame = self.bounds
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        let nib = UINib(nibName: StickerPackIcon.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: StickerPackIcon.identifier)
        self.addSubview(collectionView)
    }
    func scrollTo() {
        self.collectionView?.scrollToItem(at: IndexPath(row: self.selectedPackIndex, section: 0), at: .right, animated: true)
        
    }
    
    func reloadCollection(arrData:NSMutableArray) {
//        self.emojiPanel = panel
        self.arrayThumbnil = arrData
        self.collectionView.reloadData()
    }
    
    func configeEmojiPanel(panel:EmojiPanel){
        self.emojiPanel = panel
    }

}
extension ThumbnilVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        
       
            return self.arrayThumbnil.count
      
     
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerPackIcon.identifier, for: indexPath) as! StickerPackIcon
        
        let objCate = self.arrayThumbnil[indexPath.row] as! LLCategory
        let imgName = objCate.icon
    
        cell.configure(packname: imgName!, isSelected: (indexPath.item == self.selectedPackIndex))
        return cell
    }
}

extension ThumbnilVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(self.emojiPanel.selectedPackIndex)
        
        let objCate = self.arrayThumbnil[indexPath.row] as! LLCategory
        
        if (self.emojiPanel.selectedPackIndex != indexPath.item) {
            let index = NSIndexPath(item: self.selectedPackIndex, section: 0)
            if let previousCell = collectionView.cellForItem(at: index as IndexPath) as? StickerPackIcon{
                previousCell.setPackSelected(false)
            }
            self.emojiPanel.selectedPackIndex = indexPath.item
            self.selectedPackIndex = indexPath.item
            self.collectionView.reloadData()
            delegate?.didSelectPack(at: indexPath.item)
            self.emojiPanel.reloadCollection(arrData: objCate.stickers)
        }
        
        
        
        
    }
}

extension ThumbnilVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return iconSize
    }
}
