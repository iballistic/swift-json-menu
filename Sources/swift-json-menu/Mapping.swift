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
/*
 {
 "storyboard": [
 {
     "name": "foodmenu",
     "comment": "Food menu",
     "title": "Food menu"
 },
 "section": [
 {
 "name": "breakfast",
 "order" : 10,
 "header": "Breakfast",
 "footer": ""
 },
 "cells": [{
     "format": "",
     "key": "tea",
     "title": "Tea flavor",
     "celltype": "CellString",
     "placeholder": "Enter Tea flavors",
     "values": [{
     "value": "orange pekoe",
     "type": "default"
    }],
 }],
 "mapping": [
     {
     "storyboard": "foodmenu",
     "section": "breakfast",
     "cell": "tea",
     "readonly": false,
     "order": 0
 }]
 */

import Foundation


public struct Mapping : Hashable{
    
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
