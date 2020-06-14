//
//  CellValue.swift
//  swift-json-menu
//
//  Created by Telman Rustam on 2017-06-18.
//  Copyright © 2017 Telman Rustam. All rights reserved.
//

import Foundation

public enum ValueRequirement : String{
    case `default`, optional
}

public struct CellValue {
    public var value : String?
    public var requirement : ValueRequirement?
    init(value: String?, requirement: ValueRequirement?) {
        self.value = value
        self.requirement = requirement
    }
}

extension CellValue{
    init(json: [String: Any]){
        let value = json["value"] as! String
        let requirement = json["type"] as! String
        self.init(value: value,requirement: ValueRequirement.init(rawValue: requirement))
    }
}
