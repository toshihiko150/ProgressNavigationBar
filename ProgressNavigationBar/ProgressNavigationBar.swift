//
//  ProgressNavigationBar.swift
//  ProgressNav
//
//  Created by Naoki Hiroshima on 2/3/16.
//  Copyright © 2016 WTF. All rights reserved.
//

import UIKit

class ProgressNavigationBar: UINavigationBar {
    dynamic var trackTintColor: UIColor {  // UI_APPEARANCE_SELECTOR
        didSet { setNeedsDisplay() }
    }

    dynamic var progressTintColor: UIColor {  // UI_APPEARANCE_SELECTOR
        didSet { setNeedsDisplay() }
    }

    var progressHeight: CGFloat {
        didSet { setNeedsLayout(); setNeedsDisplay() }
    }

    var progress: Float {
        didSet { progress = max(0, min(1, progress)); setNeedsDisplay() }
    }

    private var progressLayer: CAShapeLayer

    required init?(coder aDecoder: NSCoder) {
        progressLayer = CAShapeLayer()
        trackTintColor = UIColor.clear
        progressTintColor = UIColor.systemBlue
        progress = 0
        progressHeight = 1.0

        super.init(coder: aDecoder)
        layer.addSublayer(progressLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var rect = bounds
        rect.origin.y = rect.height - progressHeight
        rect.size.height = progressHeight
        progressLayer.frame = rect

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: rect.height / 2))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
        progressLayer.path = path.cgPath
    }

    override func setNeedsDisplay() {
        if progress == 0 {
            progressLayer.isHidden = true
            progressLayer.strokeEnd = 0
        } else {
            progressLayer.isHidden = false
            progressLayer.strokeEnd = CGFloat(progress)
            progressLayer.backgroundColor = trackTintColor.cgColor
            progressLayer.strokeColor = progressTintColor.cgColor
            progressLayer.lineWidth = progressHeight
        }

        super.setNeedsDisplay()
    }
}
