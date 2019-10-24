//
//  FirstViewController.swift
//  where
//
//  Created by Leprohon cedric on 23/10/2019.
//  Copyright © 2019 Elite. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var lblTitle : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblTitle.text = NSLocalizedString("title_text", comment: "")
    }


}

