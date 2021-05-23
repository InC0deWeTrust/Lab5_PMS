//
//  MyCollectionVewCell.swift
//  Matviychuks' Project
//
//  Created by Andrey Matviychuk on 23.05.2021.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    @IBOutlet var myImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func configure(image: UIImage?) {
        myImageView.backgroundColor = .gray
        myImageView.image = image
    }
}

