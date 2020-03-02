//
//  PlusButton.swift
//  MenuAnimation
//
//  Created by erfan on 12/12/1398 AP.
//  Copyright © 1398 Erfan. All rights reserved.
//

import UIKit

class PlusButton: UIButton {

    //MARK: Vars
    
    private let lineWidth: CGFloat = 3.0
    private var plusWidth: CGFloat {
        return bounds.width / 2
    }
    private lazy var halfPlusWidth = plusWidth / 2
    private var plusCenter: CGFloat {
      return bounds.width / 2
    }
    
    //MARK: Overrides
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawPlus(in: rect)
    }
    
    //MARK: Functions

    fileprivate func drawPlus(in rect: CGRect) {

        let plusPath = UIBezierPath()
        plusPath.lineWidth = lineWidth

        plusPath.move(to: CGPoint(x: plusCenter - halfPlusWidth, y: plusCenter))
        plusPath.addLine(to: CGPoint(x: plusCenter + halfPlusWidth, y: plusCenter))
        
        plusPath.move(to: CGPoint(x: plusCenter, y: plusCenter - halfPlusWidth))
        plusPath.addLine(to: CGPoint(x: plusCenter, y: plusCenter + halfPlusWidth))
        
        UIColor.black.setStroke()
        plusPath.stroke()
        
    }
}
