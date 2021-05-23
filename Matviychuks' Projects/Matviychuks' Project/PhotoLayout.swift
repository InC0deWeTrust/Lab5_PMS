//
//  PhotoLayout.swift
//  Matviychuks' Project
//
//  Created by Andrey Matviychuk on 23.05.2021.
//

import UIKit

protocol PhotoLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}


class PhotoLayout: UICollectionViewLayout {
    weak var delegate: PhotoLayoutDelegate?
    
    private let cellPadding: CGFloat = 1
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    override func invalidateLayout() {
        super.invalidateLayout()
        contentHeight = 0
        cache = []
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else {
            return
        }
        
    
        var yOffset:CGFloat = 0
        
      
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            var frame:CGRect?
            let photoHeight = delegate?.collectionView(collectionView,heightForPhotoAtIndexPath: indexPath) ?? 180
            let height = cellPadding * 2 + photoHeight - 2
            
            if ((indexPath[1] + 1) % 10 == 1 || (indexPath[1] + 1) % 10 == 2) {
                frame = CGRect(x: 0, y: yOffset, width: height, height: height)
                yOffset += (indexPath[1] + 1) % 10 == 1 ? height : -height
            }else if((indexPath[1] + 1) % 10 == 3){
                frame = CGRect(x: contentWidth/4, y: yOffset, width: height, height: height)
            }else if ((indexPath[1] + 1) % 10 == 4 || (indexPath[1] + 1) % 10 == 5) {
                frame = CGRect(x: contentWidth/4*3, y: yOffset, width: height, height: height)
                yOffset += height
            }else if((indexPath[1] + 1) % 10 == 6){
                frame = CGRect(x: 0, y: yOffset, width: height, height: height)
            }else if ((indexPath[1] + 1) % 10 == 7 || (indexPath[1] + 1) % 10 == 8) {
                frame = CGRect(x: contentWidth/2, y: yOffset, width: height, height: height)
                yOffset += (indexPath[1] + 1) % 10 == 7 ? height : -height
            }else{
                frame = CGRect(x: contentWidth/4*3, y: yOffset, width: height, height: height)
                yOffset += height
            }
                              
            
            let insetFrame = frame!.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame!.maxY)
        }
    
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}