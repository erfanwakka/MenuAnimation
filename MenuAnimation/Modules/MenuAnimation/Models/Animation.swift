//
//  Animation.swift
//  MenuAnimation
//
//  Created by erfan on 12/12/1398 AP.
//  Copyright © 1398 Erfan. All rights reserved.
//

import UIKit


enum AnimationIn {
    enum delay: TimeInterval {
        typealias RawValue = TimeInterval
        case story = 0.5
        case activity = 0.25
        case place = 0
    }
    enum yPosition: CGFloat {
        case story = 200
        case activity = 250
        case place = 300
    }
}
enum AnimationOut {
    enum delay: TimeInterval {
        typealias RawValue = TimeInterval
        case story = 0
        case activity = 0.25
        case place = 0.5
    }
    enum yPosition: CGFloat {
        case story = 200
        case activity = 250
        case place = 300
    }
}
