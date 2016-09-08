//
//  ArcDrawing.swift
//  DysonBot
//
//  Created by Paul Beattie on 08/09/2016.
//  Copyright © 2016 GJAM. All rights reserved.
//

import Foundation
import UIKit

class arcDrawing {
    var mainViewCopy : UIView!
    
//    var backLeftSensorView: UIView!
    var frontLeftSensorView: UIView!
//    var backRightSensorView: UIView!
//    var frontRightSensorView: UIView!

    
    func arcDrawing(mainView:UIView) -> Void {
        mainViewCopy = mainView
        
        frontLeftSensorView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        frontLeftSensorView.backgroundColor = UIColor.red
        mainViewCopy.addSubview(frontLeftSensorView)

    }
    
    func drawArc(position:Position, range:Int) -> Void {
        switch position {
        case .frontLeft:
            drawFrontLeft(range: range, view: frontLeftSensorView)
        case .frontRight:
                drawFrontRight(range: range)
        case .backLeft:
                drawBackLeft(range: range)
        case .backRight:
                drawBackRight(range: range)
        }
    }
    
    func drawFrontLeft(range:Int, view:UIView) -> Void {
        
        view.frame = CGRect(x: Int(view.frame.origin.x), y: Int(view.frame.origin.y), width: range, height: range)
        
//        return path2
        
    }
    
    func drawFrontRight(range:Int) -> Void {
//        return UIBezierPath()
    }

    func drawBackLeft(range:Int) -> Void {
//        return UIBezierPath()
    }

    func drawBackRight(range:Int) -> Void {
//        return UIBezierPath()
    }

    func draw() {
    }
}
