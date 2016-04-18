//
//  HNClient.swift
//  qanta
//
//  Created by Chuck Man on 18/04/2016.
//  Copyright © 2016 Chuck Man. All rights reserved.
//

import Foundation
import Alamofire

// Hacker news endpoints
enum HNEndPoint: String
{
    case base        = "https://hacker-news.firebaseio.com"
    case version     = "/v0"
    case topStories  = "/topstories.json?print=pretty"
    case askStories  = "/askstories.json?print=pretty"
    case showStories = "/showstories.json?print=pretty"
    case jobStories  = "/jobstories.json?print=pretty"
    
    static func item(id: String) -> String {
        return base.rawValue + version.rawValue + "/item/\(id).json?print=pretty"
    }
    
    var string: String {
        return base.rawValue + version.rawValue + "/\(self.rawValue)"
    }
}

// This class uses Alamofire to retrieve data using Hacker News API
class HNClient: NSObject {
    
    func getTopStoryIds(completion: (ids: [NSNumber]) -> Void)
    {
        Alamofire.request(.GET, HNEndPoint.topStories.string).responseJSON { (response) in
            
            if let JSON = response.result.value
            {
                completion(ids: JSON as! [NSNumber])
            }
        }
    }
    
    func getTopStoryIds(ids: [NSNumber],
                        progress: (completed: Int, total: Int, items: [NSNumber: AnyObject]) -> Void,
                        completion: (items: [NSNumber: AnyObject]) -> Void)
    {
        let total     = ids.count
        var completed = 0
        var failed    = 0
        
        var items     = [NSNumber: AnyObject]()
        
        for id in ids
        {
            Alamofire.request(.GET, HNEndPoint.item(id.stringValue)).responseJSON { (response) in
                
                if let JSON = response.result.value
                {
                    items[id] = JSON as! NSDictionary
                    
                    completed = completed + 1
                }
                else
                {
                    failed = failed + 1
                }
                
                
                if failed + completed == total
                {
                    completion(items: items)
                }
                else
                {
                    progress(completed: completed, total: total, items: items)
                }
            }
        }
    }
    
    func getTopStoryId(id: String, completion: (NSDictionary) -> Void)
    {
        Alamofire.request(.GET, HNEndPoint.item(id)).responseJSON { (response) in
            
            if let JSON = response.result.value
            {
                completion(JSON as! NSDictionary)
            }
        }
    }
}
