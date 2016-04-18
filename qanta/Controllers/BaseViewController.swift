//
//  ViewController.swift
//  qanta
//
//  Created by Chuck Man on 18/04/2016.
//  Copyright © 2016 Chuck Man. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init()
    {
        self.init(nibName: nil, bundle: nil)
        self.setup()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup()
    {
        
    }
}

