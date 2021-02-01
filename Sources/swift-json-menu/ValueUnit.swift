//
//  ValueUnit.swift
//  swift-json-menu
//
//  Created by Telman Rustam on 2017-06-18.
//  Copyright © 2017 Telman Rustam. All rights reserved.
//

import Foundation

/// Value unit configuration of a cell
@objcMembers public class ValueUnit : NSObject {
    
    public var name: String?
    public var symbol: String?
    public var option: ConversionOption?
    
    public init(name: String?, option: ConversionOption?, symbol: String?) {
        self.name = name
        self.option = option
        self.symbol = symbol
    }

}

extension ValueUnit{
    public convenience init(json: [String: Any]){
        let name = json["name"] as! String
        let option = json["type"] as! String
        let symbol = json["symbol"] as! String
        self.init(name: name,option: ConversionOption(rawValue: option), symbol: symbol)

    }
}


