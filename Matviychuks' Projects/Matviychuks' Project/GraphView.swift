//
//  GraphView.swift
//  Matviychuks' Project
//
//  Created by Andrey Matviychuk on 25.04.2021.
//

import Foundation
import UIKit

class GraphView: UIView {
    override func draw(_ rect: CGRect) {
        let center1 = (x: bounds.width/2, y: bounds.height/2)
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: center1.y))
        path.addLine(to: CGPoint(x: bounds.width, y: center1.y))
        path.close()
        path.move(to: CGPoint(x: center1.x, y: 0))
        path.addLine(to: CGPoint(x: center1.x, y: bounds.height))
        path.close()
        path.move(to: CGPoint(x: center1.x - 10, y: 10))
        path.addLine(to: CGPoint(x: center1.x, y: 0))
        path.move(to: CGPoint(x: center1.x, y: 0))
        path.addLine(to: CGPoint(x: center1.x + 10, y: 10))
        path.close()
        path.move(to: CGPoint(x: bounds.width - 10, y: center1.y - 10))
        path.addLine(to: CGPoint(x: bounds.width, y: center1.y))
        path.move(to: CGPoint(x:bounds.width, y: center1.y))
        path.addLine(to: CGPoint(x: bounds.width - 10, y: center1.y + 10))
        path.close()
        path.move(to: CGPoint(x: center1.x + center1.x/5, y: center1.y - 10))
        path.addLine(to: CGPoint(x: center1.x + center1.x/5, y: center1.y + 10))
        path.close()
        path.move(to: CGPoint(x: center1.x - 10, y: center1.y - center1.y/5))
        path.addLine(to: CGPoint(x: center1.x + 10, y: center1.y - center1.y/5))
        path.close()
        var color = UIColor.black
        color.setStroke()
        path.stroke()
        path.lineWidth = 1
        
        let path2 = UIBezierPath()
        let quarter = center1.x/5;
        
        for i in stride (from: -5, to: 5, by: 0.01){
            let value = i*i
            path2.addLine(to: CGPoint(x: center1.x + quarter * CGFloat(i), y: center1.y - quarter * CGFloat(value)))
            path2.move(to: CGPoint(x: center1.x + quarter * CGFloat(i), y: center1.y - quarter * CGFloat(value)))
        }
        
        path2.close()
        color = UIColor.blue
        color.setStroke()
        path2.stroke()
        path2.lineWidth = 1
    }
    
 
}

