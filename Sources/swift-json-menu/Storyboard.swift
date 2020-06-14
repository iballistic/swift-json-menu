//
//  Storyboard.swift
//  swift-json-menu
//
//  Created by Telman Rustam on 2017-07-03.
//  Copyright © 2017 Telman Rustam. All rights reserved.
//

import Foundation

@objcMembers public class Storyboard : NSObject{
    var name : String?
    var title : String?
    
    init(name: String, description: String?){
        self.name = name
        self.title = description
    }
}

extension Storyboard{
    convenience init(json: [String: Any]){
        let name = json["name"] as? String
        let description = json["title"] as? String
        self.init(name: name!, description: description)
    }
}
