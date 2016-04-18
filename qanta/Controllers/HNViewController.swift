//
//  HNViewController.swift
//  qanta
//
//  Created by Chuck Man on 18/04/2016.
//  Copyright © 2016 Chuck Man. All rights reserved.
//

import UIKit
import SnapKit

class HNViewController: BaseViewController {

    let hnService = HNService()
    
    var tableView = UITableView()
    var data: [String: AnyObject]?
    
    override func setup()
    {
        super.setup()
        
        // Set up table list
        self.setupTableView()

        // Set Hacker news service delegate
        self.hnService.delegate = self
    }
    
    
    func setupTableView()
    {
        tableView = UITableView()
        
        // Data source is an extension
        tableView.dataSource = self
        
        // Register basic tablet view cell
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // Layout (Snapkit)
        view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    // MARK - Controller Life cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Hacker News"
    }
}

extension HNViewController: HNServiceDelegate {
    
    func retrievedTopStories(inRange: NSRange, items: [NSNumber : AnyObject])
    {
        // Reload table view on rete.
        self.tableView.reloadData()
    }
}

extension HNViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableview: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return hnService.topStories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let key  = Array(hnService.topStories.keys)[indexPath.row] as String
        let dict = hnService.topStories[key]! as AnyObject
        
        if let title = dict["title"] as? String
        {
            cell.textLabel?.text = title
        }

        return cell
    }
}