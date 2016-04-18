//
//  HNService.swift
//  qanta
//
//  Created by Chuck Man on 18/04/2016.
//  Copyright © 2016 Chuck Man. All rights reserved.
//

import Foundation

protocol HNServiceDelegate: NSObjectProtocol {
    func retrievedTopStories(inRange: NSRange, items: [NSNumber: AnyObject])
}

class HNService: NSObject {
    
    let client: HNClient = HNClient()
    var topStoryIds: [NSNumber] = [NSNumber]()
    var topStories: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
    
    var delegate: HNServiceDelegate?
    
    override init()
    {
        super.init()
        
        setup()
        
        // Fetch top stories on init, then load the top 10 posts
        loadTopStoryIds()
    }
    
    func setup()
    {
        //
    }
    
    private func loadTopStoryIds()
    {
        client.getTopStoryIds { (ids) in
            
            // Save post ids in memory
            self.topStoryIds.appendContentsOf(ids)
            
            // Load first 10 posts
            self.loadTopStory(NSRange(location: 0, length: 10))
        }
    }
    
    func loadTopStory(range: NSRange)
    {        
        let ids = [NSNumber](topStoryIds[range.location..<range.length])
    
        client.getTopStoryIds(ids, progress:
            { (completed, total, items) in
                //
            })
            { (items) in
                
                for (key, item) in items
                {
                    self.topStories[key.stringValue] = item
                }
                
                // Tell delegate we have got some data
                self.delegate?.retrievedTopStories(range, items: items)
            }
    }
    
}