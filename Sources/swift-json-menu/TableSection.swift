//
//  TableSection.swift
//  swift-json-menu
//
//  Created by Telman Rustam on 2017-07-03.
//  Copyright © 2017 Telman Rustam. All rights reserved.
//

import Foundation


@objcMembers public class TableSection : NSObject{
    
    public var name : String
    public var header : String?
    public var footer : String?
    public var order: NSInteger?
    
    init(name: String, header: String?, footer: String?, order: NSInteger?){
        
        self.name = name
        self.header = header
        self.footer = footer
        self.order = order
    }
}

extension TableSection{
    convenience init(json: [String: Any]){
        let name = json["name"] as? String
        let header = json["header"] as? String
        let footer = json["footer"] as? String
        let order = json["order"] as? NSInteger
        self.init(name: name!, header: header, footer: footer, order: order)
        
    }
}
