//
//  OERadarView.swift
//  OERadarView
//
//  Created by Or Elmaliah on 24/05/2016.
//  Copyright © 2016 Or Elmaliah. All rights reserved.
//

import UIKit

public class OERadarView: UIView {
    
    private var centerPoint: CGPoint {
        return CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        // Big Circle
        let circleSize = min(self.bounds.width, self.bounds.height)
        let circlePath = UIBezierPath.circlePathWithCenter(self.centerPoint, diameter: circleSize - 2, borderWidth: 1)
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.CGPath
        circleShape.fillColor = UIColor.redColor().colorWithAlphaComponent(0.35).CGColor
        circleShape.strokeColor = UIColor.redColor().CGColor
        self.layer.addSublayer(circleShape)
        
        // Center point circle
        let centerPointPath = UIBezierPath.circlePathWithCenter(self.centerPoint, diameter: 4, borderWidth: 0)
        let pointShape = CAShapeLayer()
        pointShape.path = centerPointPath.CGPath
        pointShape.fillColor = UIColor.redColor().CGColor
        circleShape.addSublayer(pointShape)
        
        // Line radius
        let linePath = UIBezierPath()
        let frame = CGRect(x: self.centerPoint.x-circleSize/2, y: 0, width: circleSize, height: circleSize)
        linePath.moveToPoint(CGPoint(x: circleSize/2, y: circleSize/2))
        linePath.addLineToPoint(CGPoint(x: circleSize/2, y: 0))
        
        let lineShape = CAShapeLayer()
        lineShape.frame = frame
        lineShape.path = linePath.CGPath
        lineShape.strokeColor = UIColor.redColor().CGColor
        lineShape.fillColor = UIColor.redColor().CGColor
        lineShape.lineWidth = 1
        circleShape.addSublayer(lineShape)
        
        let circleAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        circleAnimation.fromValue = NSNumber(double: 0)
        circleAnimation.toValue = NSNumber(double: 2*M_PI)
        circleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        circleAnimation.duration = 2
        circleAnimation.repeatCount = Float.infinity
        circleAnimation.removedOnCompletion = false
        lineShape.addAnimation(circleAnimation, forKey: nil)
    }

}

extension UIBezierPath {
    class func circlePathWithCenter(center: CGPoint, diameter: CGFloat, borderWidth: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(arcCenter: center, radius: diameter/2, startAngle: 0, endAngle: 2*CGFloat(M_PI), clockwise: true)
        path.lineWidth = borderWidth
        return path
    }
}