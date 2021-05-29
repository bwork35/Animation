//
//  LikesViewController.swift
//  FBStream
//
//  Created by Bryan Workman on 5/29/21.
//

import UIKit

class LikesViewController: UIViewController {

    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(generateHeart(touch:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func generateHeart(touch: UITapGestureRecognizer) {
        let touchPoint = touch.location(in: self.view)
        
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        imageView.tintColor = #colorLiteral(red: 1, green: 0.4930331707, blue: 0.4602769017, alpha: 1)
        imageView.frame = CGRect(x: 200, y: 0, width: 40, height: 40)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customVerticalPath(touchPoint: touchPoint).cgPath
        animation.duration = 2
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = true
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        imageView.layer.add(animation, forKey: nil)
        
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseIn, animations: { imageView.alpha = 0.0 }, completion: nil)
    
        view.addSubview(imageView)
    }

    func customVerticalPath(touchPoint: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
    
        let pathLength = 400
        let curveLength = pathLength / 4
        
        path.move(to: touchPoint)
        
        let endpoint = CGPoint(x: touchPoint.x, y: touchPoint.y - CGFloat(pathLength))
        
        let cp1 = CGPoint(x: touchPoint.x - 50, y: touchPoint.y - CGFloat(curveLength))
        let cp2 = CGPoint(x: touchPoint.x + 50, y: touchPoint.y - CGFloat(3 * curveLength))
        
        path.addCurve(to: endpoint, controlPoint1: cp1, controlPoint2: cp2)
        
        return path
    }

} //End of class

