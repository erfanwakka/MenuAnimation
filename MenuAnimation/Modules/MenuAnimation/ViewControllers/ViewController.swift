//
//  ViewController.swift
//  MenuAnimation
//
//  Created by erfan on 12/12/1398 AP.
//  Copyright © 1398 Erfan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: IBOutlets
    
    @IBOutlet weak var plusContainer: UIView!
    
    var placeButton = UIButton()
    var activityButton = UIButton()
    var storyButton = UIButton()
    
    //MARK: IBActions
    
    @IBAction func didTapOnPlussButton(_ sender: UIButton) {
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
    //MARK: Vars
    
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
        setupButton(button: storyButton, title: "Story", backgroundColor: #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1))
        setupButton(button: activityButton, title: "Activity", backgroundColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1))
        setupButton(button: placeButton, title: "Place", backgroundColor: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1))
        view.bringSubviewToFront(plusContainer)
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
