//
//  Mapping.swift
//  JSonMenu
//
//  Created by Telman Rustam on 2017-07-03.
//  Copyright © 2017 Telman Rustam. All rights reserved.
//

import Foundation


public struct Mapping{
    
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

extension Mapping{
    public init(json: [String: Any]){
        let storyboard = json["storyboard"] as? String
        let section = json["section"] as? String
        let cell = json["cell"] as? String
        let order = json["order"] as? Int
        let readonly = json["readonly"] as? Bool
        self.init(storyboard: storyboard!, section: section, cell: cell, order: order, readonly: readonly)
    }
}


public struct MappingView{
    public var storyboard : Storyboard?
    public var section : TableSection?
    public var cell : TableCell?
    public var order: NSInteger?
    public var readonly : Bool?
    public init(storyboard: Storyboard, section: TableSection, cell: TableCell, order: NSInteger?, readonly: Bool?){
        self.storyboard = storyboard
        self.section = section
        self.cell = cell
        self.order = order
        self.readonly = readonly
    }
}
