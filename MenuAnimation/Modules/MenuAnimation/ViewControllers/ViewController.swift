//
//  ViewController.swift
//  MenuAnimation
//
//  Created by erfan on 12/12/1398 AP.
//  Copyright © 1398 Erfan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Vars -
    
    private var placeButton = UIButton()
    private var activityButton = UIButton()
    private var storyButton = UIButton()
    private lazy var plusButton: PlusButton = {
        let plusButton = PlusButton()
        let plusWidth: CGFloat = 60
        plusButton.frame = CGRect(x: view.center.x - plusWidth / 2, y: view.center.y - plusWidth / 2, width: plusWidth, height: plusWidth)
        plusButton.addTarget(self, action: #selector(didTapOnPlussButton(_:)), for: .touchUpInside)
        return plusButton
    }()
    
    private var isAnimating = false
    private var animated = false
    private var dispatchGroup = DispatchGroup()
    
    //MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: Functions
    
    fileprivate func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.4980392157, green: 0.2705882353, blue: 0.6, alpha: 1)
        
        setupButton(button: storyButton, title: "Story", backgroundColor: #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1))
        setupButton(button: activityButton, title: "Activity", backgroundColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1))
        setupButton(button: placeButton, title: "Place", backgroundColor: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1))
        
        drawCircles()
        
        view.addSubview(plusButton)
    }
    fileprivate func setupButton(button: UIButton, title: String, backgroundColor: UIColor) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = Constants.cornerRadius
        button.titleLabel?.alpha = 0
        button.alpha = 1
        button.frame = CGRect(x: view.bounds.midX - Constants.buttonHeight / 2  , y: view.bounds.midY - Constants.buttonHeight / 2, width: Constants.buttonHeight, height: Constants.buttonHeight)
        view.addSubview(button)
    }

}
//MARK: - Animate plus button -
extension ViewController {
    fileprivate func animateButton(button: UIButton) {
        UIView.animate(withDuration: 0.1) {
            if button.transform.isIdentity {
                button.transform = button.transform.rotated(by: .pi / 4)
            } else {
                button.transform = CGAffineTransform.identity
            }
        }
    }
}
//MARK: - Animation -
extension ViewController {
    
    fileprivate func animateIn() {
        animateIn(view: placeButton,
                  duration: Constants.animationDuration,
                  delay: AnimationIn.delay.place.rawValue,
                  yPosition: AnimationIn.yPosition.place.rawValue)
        animateIn(view: activityButton,
                  duration: Constants.animationDuration,
                  delay: AnimationIn.delay.activity.rawValue,
                  yPosition: AnimationIn.yPosition.activity.rawValue)
        animateIn(view: storyButton,
                  duration: Constants.animationDuration,
                  delay: AnimationIn.delay.story.rawValue,
                  yPosition: AnimationIn.yPosition.story.rawValue)
    }
    fileprivate func animateOut() {
        animateOut(view: storyButton,
                   duration: Constants.animationDuration,
                   delay: AnimationOut.delay.story.rawValue,
                   yPosition: AnimationOut.yPosition.story.rawValue)
        animateOut(view: activityButton,
                   duration: Constants.animationDuration,
                   delay: AnimationOut.delay.activity.rawValue,
                   yPosition: AnimationOut.yPosition.activity.rawValue)
        animateOut(view: placeButton,
                   duration: Constants.animationDuration,
                   delay: AnimationOut.delay.place.rawValue,
                   yPosition: AnimationOut.yPosition.place.rawValue)
    }
    fileprivate func animateIn(view: UIView, duration: TimeInterval, delay: TimeInterval, yPosition: CGFloat) {
        dispatchGroup.enter()
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 35, options: .curveEaseIn, animations: {
            view.frame.origin.y += yPosition
        }) { (_) in
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 1, animations: {
                view.frame.size.width += Constants.buttonWidth
                view.frame.origin.x -= Constants.buttonWidth / 2
                (view as? UIButton)?.titleLabel?.alpha = 1
            }) { (_) in
                self.dispatchGroup.leave()
            }
        }
    }
    fileprivate func animateOut(view: UIView, duration: TimeInterval, delay: TimeInterval, yPosition: CGFloat) {
        dispatchGroup.enter()
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, animations: {
            view.frame.size.width -= Constants.buttonWidth
            view.frame.origin.x += Constants.buttonWidth / 2
            (view as? UIButton)?.titleLabel?.alpha = 0
        }) { (_) in
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 35, options: .curveEaseIn, animations: {
                view.frame.origin.y -= yPosition
            }) { (_) in
                self.dispatchGroup.leave()
            }
        }
    }
}
extension ViewController {
    fileprivate func drawCircle(center: CGPoint, radius: CGFloat, fillColor: UIColor) {
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        let circle = CAShapeLayer()
        circle.path = circlePath.cgPath
        circle.fillColor = fillColor.cgColor
        view.layer.addSublayer(circle)
    }
    fileprivate func drawCircles() {
        drawCircle(center: view.center, radius: 60, fillColor: .darkGray)
        drawCircle(center: view.center, radius: 40, fillColor: .white)
    }
}
extension ViewController {
    @objc fileprivate func didTapOnPlussButton(_ sender: UIButton) {
        if isAnimating { return }
        isAnimating = true
        animateButton(button: sender)
        if animated {
           animateOut()
        } else {
            animateIn()
        }
        animated = !animated
        dispatchGroup.notify(queue: .main) {
            self.isAnimating = false
        }
    }
}
