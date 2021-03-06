//
//  Mapping.swift
//  swift-json-menu
//
//  Created by Telman Rustam on 2017-07-03.
//  Copyright © 2017 Telman Rustam. All rights reserved.
//
// Mapping is defined in the Json file to build a relation between
//
//


import Foundation


@objcMembers public class RelationalMapping : NSObject{
    
    public var storyboard : String?
    public var section : String?
    public var cell : String?
    public var order: NSInteger?
    public var readonly : Bool?
    
    public init(storyboard: String, section: String?, cell: String?, order: NSInteger?, readonly: Bool?){
        
        self.storyboard = storyboard
        self.section = section
        self.cell = cell
        self.order = order
        self.readonly = readonly
    }
}

extension RelationalMapping{
    public convenience init(json: [String: Any]){
        let storyboard = json["storyboard"] as? String
        let section = json["section"] as? String
        let cell = json["cell"] as? String
        let order = json["order"] as? Int
        let readonly = json["readonly"] as? Bool
        self.init(storyboard: storyboard!, section: section, cell: cell, order: order, readonly: readonly)
    }
}
