//
//  Storyboard.swift
//  swift-json-menu
//
//  Created by Telman Rustam on 2017-07-03.
//  Copyright © 2017 Telman Rustam. All rights reserved.
//

import Foundation

@objcMembers public class Storyboard : NSObject{
    public var name : String?
    public var title : String?
    
    public init(name: String, description: String?){
        self.name = name
        self.title = description
    }
}

extension Storyboard{
    public convenience init(json: [String: Any]){
        let name = json["name"] as? String
        let description = json["title"] as? String
        self.init(name: name!, description: description)
    }
}
