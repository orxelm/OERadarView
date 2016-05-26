//
//  OERadarView.swift
//  OERadarView
//
//  Created by Or Elmaliah on 24/05/2016.
//  Copyright © 2016 Or Elmaliah. All rights reserved.
//

import UIKit

@IBDesignable
public class OERadarView: UIView {
    
    /// The circle's fill color
    @IBInspectable
    public var circleFillColor: UIColor = .redColor() {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// The circle's border (stroke) color
    @IBInspectable
    public var circleBorderColor: UIColor = .redColor() {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// The center point color
    @IBInspectable
    public var centerPointColor: UIColor = .redColor() {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// The radius line color
    @IBInspectable
    public var radiusLineColor: UIColor = .redColor() {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    private var circleShape: CAShapeLayer?
    private var radiusLineShape: CAShapeLayer?
    private var centerPoint: CGPoint {
        return CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
    }
    
    // MARK: - UIView
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        // Big Circle
        let circleSize = min(self.bounds.width, self.bounds.height)
        let borderWidth: CGFloat = 1
        let circlePath = UIBezierPath.circlePathWithCenter(self.centerPoint, diameter: circleSize - 2*borderWidth, borderWidth: borderWidth)
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.CGPath
        circleShape.fillColor = self.circleFillColor.colorWithAlphaComponent(0.35).CGColor
        circleShape.strokeColor = self.circleBorderColor.CGColor
        self.layer.addSublayer(circleShape)
        self.circleShape = circleShape
        
        // Center point circle
        let centerPointPath = UIBezierPath.circlePathWithCenter(self.centerPoint, diameter: 4, borderWidth: 0)
        let pointShape = CAShapeLayer()
        pointShape.path = centerPointPath.CGPath
        pointShape.fillColor = self.centerPointColor.CGColor
        circleShape.addSublayer(pointShape)
        
        // Radius line
        let linePath = UIBezierPath()
        linePath.moveToPoint(CGPoint(x: circleSize/2, y: circleSize/2))
        linePath.addLineToPoint(CGPoint(x: circleSize/2, y: 0))
        
        let radiusLineShape = CAShapeLayer()
        radiusLineShape.frame = CGRect(x: self.centerPoint.x-circleSize/2, y: 0, width: circleSize, height: circleSize)
        radiusLineShape.path = linePath.CGPath
        radiusLineShape.strokeColor = self.radiusLineColor.CGColor
        radiusLineShape.lineWidth = 1
        circleShape.addSublayer(radiusLineShape)
        self.radiusLineShape = radiusLineShape
        
        // Radius line animation
        let circleAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        circleAnimation.fromValue = NSNumber(double: 0)
        circleAnimation.toValue = NSNumber(double: 2*M_PI)
        circleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        circleAnimation.duration = 2
        circleAnimation.repeatCount = Float.infinity
        circleAnimation.removedOnCompletion = false
        radiusLineShape.addAnimation(circleAnimation, forKey: nil)
        
        self.showRandomDotShape()
    }
    
    private func showRandomDotShape() {
        if let radiusLineShape = self.radiusLineShape, circleShape = self.circleShape, circleShapePath = circleShape.path {
            
            var dotPoint = CGPointZero
            let circleBezierPath = UIBezierPath(CGPath: circleShapePath)
            while !circleBezierPath.containsPoint(dotPoint) {
                let dotX = CGFloat.random(radiusLineShape.frame.minX, radiusLineShape.frame.maxX)
                let dotY = CGFloat.random(radiusLineShape.frame.minY, radiusLineShape.frame.maxY)
                dotPoint = CGPoint(x: dotX, y: dotY)
            }
            
            let dotPath = UIBezierPath.circlePathWithCenter(dotPoint, diameter: 5, borderWidth: 0)
            let dotShape = CAShapeLayer()
            dotShape.frame = CGRect(x: dotPoint.x-2.5, y: dotPoint.y-2.5, width: 5, height: 5)
            dotShape.path = dotPath.CGPath
            dotShape.fillColor = self.centerPointColor.CGColor
            dotShape.borderColor = UIColor.greenColor().CGColor
            dotShape.borderWidth = 5
            circleShape.addSublayer(dotShape)
            
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                dotShape.removeFromSuperlayer()
                self.showRandomDotShape()
            }
            
            let alphaAnimation = CABasicAnimation(keyPath: "opacity")
            alphaAnimation.fromValue = 1
            alphaAnimation.toValue = 0
            
            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.fromValue = NSNumber(double: 1)
            scaleAnimation.toValue = NSNumber(double: 2)
            
            let animation = CAAnimationGroup()
            animation.animations = [alphaAnimation, scaleAnimation]
            animation.duration = 2.0
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            animation.removedOnCompletion = false
            
            dotShape.addAnimation(animation, forKey: nil)
            dotShape.opacity = 0
            CATransaction.commit()
        }
    }
}

extension UIBezierPath {
    class func circlePathWithCenter(center: CGPoint, diameter: CGFloat, borderWidth: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(arcCenter: center, radius: diameter/2, startAngle: 0, endAngle: 2*CGFloat(M_PI), clockwise: true)
        path.lineWidth = borderWidth
        return path
    }
}

extension CGFloat {
    static func random(lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }
}