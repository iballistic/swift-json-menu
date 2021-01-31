//
//  RelationalView.swift
//  
//
//  Created by Telman Rustam on 2021-01-31.
//

import Foundation


public struct RelationalView : Hashable{
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
