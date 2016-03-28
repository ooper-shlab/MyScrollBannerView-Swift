//
//  ViewController.swift
//  MyScrollBannerView
//
//  Created by OOPer in cooperation with shlab.jp, on 2016/3/27.
//  Copyright © 2016 OOPer (NAGATA, Atsuyuki). All rights reserved. See LICENSE.txt .
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var myScrollTextView: MyScrollTextView!
    
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let text = "How to create scrolling banner in <iOS> with Swift?"
        myScrollTextView.text = text
        myScrollTextView.startAnimatingLabel()
        
        let html = "<marquee>\(text.escapeHTML)</marquee>"
        webView.loadHTMLString(html, baseURL: nil)
    }
}

extension String {
    var escapeHTML: String {
        struct My {
            static let regex = try! OOPRegularExpression(pattern: "[<>&'\"]", options: []) {
                matchedString, offset in
                let mapping: [String: String] = [
                    "<": "&lt;", ">": "&gt;", "&": "&amp;", "'": "&apos;", "\"": "&quot;"
                ]
                return mapping[matchedString]!
            }
        }
        return My.regex.stringByReplacingMatchesInString(self)
    }
}