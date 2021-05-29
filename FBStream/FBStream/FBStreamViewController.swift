//
//  ViewController.swift
//  FBStream
//
//  Created by Bryan Workman on 5/27/21.
//

import UIKit

class FBStreamViewController: UIViewController {

    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Shows path
        //let curvedView = CurvedView(frame: view.frame)
        //view.addSubview(curvedView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    //MARK: - Helper Methods
    @objc func handleTap() {
        (0...10).forEach { (_) in
            generateAnimatedView()
        }
    }
    
    fileprivate func generateAnimatedView() {
        let heart = UIImage(systemName: "heart.fill")
        let thumbsUp = UIImage(systemName: "hand.thumbsup.fill")
        
        let image = drand48() > 0.5 ?  heart : thumbsUp
        let imageView = UIImageView(image: image)
        
        if imageView.image == heart {  imageView.tintColor = #colorLiteral(red: 1, green: 0.3376869559, blue: 0.3504690528, alpha: 1)
        } else {
            imageView.tintColor = #colorLiteral(red: 0.3184264898, green: 0.4928000569, blue: 1, alpha: 1)
        }
            
        let dimension = 20 + drand48() * 10
        imageView.frame = CGRect(x: 0, y: 100, width: dimension, height: dimension)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath().cgPath
        animation.duration = 2 + drand48() * 2
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        imageView.layer.add(animation, forKey: nil)
        
        view.addSubview(imageView)
    }
    
} //End of class

func customPath() -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 200))

    let endpoint = CGPoint(x: 410, y: 200)
    
    let randomYShift = 200 + drand48() * 300
    let cp1 = CGPoint(x: 100, y: 100 - randomYShift)
    let cp2 = CGPoint(x: 200, y: 300 + randomYShift)
    
    path.addCurve(to: endpoint, controlPoint1: cp1, controlPoint2: cp2)
    return path
}

class CurvedView: UIView {
    
    override func draw(_ rect: CGRect) {
        let path = customPath()
        path.lineWidth = 3
        path.stroke()
    }
    
} //End of class
