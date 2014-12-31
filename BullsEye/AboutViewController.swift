//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Matt Reilly on 12/30/14.
//  Copyright (c) 2014 Fountain and Fairchild LLC. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let htmlFile = NSBundle.mainBundle().pathForResource("BullsEye",
            ofType: "html") {
                let htmlData = NSData(contentsOfFile: htmlFile)
                let baseURL =
                    NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath)
                webView.loadData(htmlData, MIMEType: "text/html",
                    textEncodingName: "UTF-8", baseURL: baseURL)
        }
    }
}
