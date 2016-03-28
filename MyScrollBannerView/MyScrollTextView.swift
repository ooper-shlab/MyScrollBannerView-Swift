//
//  MyScrollTextView.swift
//  MyScrollBannerView
//
//  Created by OOPer in cooperation with shlab.jp, on 2016/3/27.
//  Copyright © 2016 OOPer (NAGATA, Atsuyuki). All rights reserved. See LICENSE.txt .
//

import UIKit

class MyScrollTextView: UIScrollView {
    
    var animationPixelsPerSecond: CGFloat = 60
    var animationInterval: NSTimeInterval = 0.016
    
    private var label: UILabel?
    
    private var animationTimer: NSTimer?
    
    deinit {
        animationTimer?.invalidate()
    }
    
    var text: String? {
        get {
            return label?.text
        }
        set {
            if( label == nil ) {
                label = UILabel(frame: CGRect(origin: CGPointZero, size: self.frame.size))
                label!.backgroundColor = self.backgroundColor
                self.addSubview(label!)
            }
            guard let label = label else {fatalError()}
            label.text = newValue
            let fitSize = label.sizeThatFits(CGSizeMake(9999, self.frame.height))
            label.frame = CGRectMake(0, 0, fitSize.width, self.frame.height)
            self.contentSize = label.frame.size
            self.contentOffset = CGPoint(x: 0, y: 0)
            self.showsVerticalScrollIndicator = false
            self.showsHorizontalScrollIndicator = false
        }
    }
    
    func startAnimatingLabel() {
        animationTimer?.invalidate()
        animationTimer = nil

        animationTimer = NSTimer.scheduledTimerWithTimeInterval(animationInterval, target: self, selector: #selector(moveLabel), userInfo: nil, repeats: true)
    }
    
    func stopAnimatingLabel() {
        animationTimer?.invalidate()
        animationTimer = nil
    }
    
    @objc private func moveLabel(timer: NSTimer) {
        var offsetX = self.contentOffset.x
        offsetX += animationPixelsPerSecond * CGFloat(animationInterval)
        if offsetX > label?.frame.width ?? 0 {
            offsetX = -self.frame.width
        }
        self.contentOffset = CGPoint(x: offsetX, y: 0)
    }
}