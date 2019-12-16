//
//  JSonMenuController.swift
//  JSonMenu
//
//  Created by Telman Rustam on 2017-07-03.
//  Copyright © 2017 Telman Rustam. All rights reserved.
//

import Foundation

//https://developer.apple.com/swift/blog/?id=37
//https://developer.apple.com/swift/blog/?id=37

public class JSonMenu : NSObject{
    
    var storyboard : [Storyboard]?
    var section : [TableSection]?
    var cell : [TableCell]?
    var mapping : [Mapping]?
    var view : [MappingView]?
    
    
    public init(storyboard: [Storyboard]?, section: [TableSection]?, cell: [TableCell]?, mapping: [Mapping]?){
        
        self.storyboard = storyboard
        self.section = section
        self.cell = cell
        self.mapping = mapping
    }
    
    public override init() {
        
    }
    
    public func Section(forStoryboard: String) ->[TableSection]?{
        
        let filtered = self.view?.filter({ (map: MappingView) -> Bool in
            return (map.storyboard?.name?.lowercased() == forStoryboard.lowercased())
        })
        
        let sorted = filtered?.sorted(by: { (item1 : MappingView, item2: MappingView) -> Bool in
            return ((item1.section?.order!)! > (item2.section?.order!)!)
        })
        
        var items : [TableSection] = []
        for item in sorted! {
            
            let exists = items.filter({ (section: TableSection) -> Bool in
                return (section.name.lowercased() == item.section?.name.lowercased())
            })
            
            if exists.count == 0{
                items.insert(item.section!, at: 0)
            }
            
        }
        return items
        

    }
    
    public func View(forStoryboard: String, forSection: String) ->[MappingView]?{
        
        let filtered = self.view?.filter({ (map: MappingView) -> Bool in
            return (map.storyboard?.name?.lowercased() == forStoryboard.lowercased() && map.section?.name.lowercased() == forSection.lowercased())
        })
        
        
        let sorted = filtered?.sorted(by: { (item1 : MappingView, item2: MappingView) -> Bool in
            return (item1.order! < item2.order!)
        })
        
        return sorted
    }
    
    public func View(forStoryboard: String) ->[MappingView]?{
        
        let filtered = self.view?.filter({ (map: MappingView) -> Bool in
            return (map.storyboard?.name?.lowercased() == forStoryboard.lowercased())
        })
        
        
        let sorted = filtered?.sorted(by: { (item1 : MappingView, item2: MappingView) -> Bool in
            return (item1.order! < item2.order!)
        })
        
        return sorted
    }
    
    
    public func Cell(byKey: String) -> TableCell? {
        
        guard let cells = self.cell else{
            return nil
        }
        
        let filtered = cells.filter { (cell: TableCell) -> Bool in
            return cell.key == byKey
        }
        
        return filtered.first
    }
}

extension JSonMenu{
   public convenience init(json: [String: Any]){
        self.init()
        guard let storyboards = json["storyboard"] as? [Any] else{
            return
        }
        
        guard let sections = json["section"] as? [Any] else{
            return
        }
        guard let cells = json["cells"] as? [Any] else{
            return
        }
        guard let mappings = json["mapping"] as? [Any] else{
            return
        }
        
        //parse storyboards
        self.storyboard = []
        for storyboardItem in storyboards{
            let boardObj = Storyboard(json: (storyboardItem as? [String:Any])!)
            self.storyboard?.insert(boardObj, at: 0)
        }
        
        
        //parse sections
        self.section = []
        for sectionItem in sections{
            let sectionObj = TableSection(json: (sectionItem as? [String:Any])!)
            self.section?.insert(sectionObj, at: 0)
        }
        
        //parse table cell
        self.cell = []
        for cellItem in cells{
            let cellObj = TableCell(json: (cellItem as? [String:Any])!)
            self.cell?.insert(cellObj, at: 0)
        }
        
        //parse mapping
        self.mapping = []
        for mapItem in mappings{
            let cellObj = Mapping(json: (mapItem as? [String:Any])!)
            self.mapping?.insert(cellObj, at: 0)
        }
        
        //create a relational view
        self.view = []
        for map in self.mapping!{
            let filteredStoryboard = self.storyboard?.filter({ (item: Storyboard) -> Bool in
                return (map.storyboard?.lowercased() == item.name?.lowercased())
            })
            
            let filteredSection = self.section?.filter({ (item: TableSection) -> Bool in
                return (map.section?.lowercased() == item.name.lowercased())
            })
            
            let filteredCell = self.cell?.filter({ (item: TableCell) -> Bool in
                return (map.cell?.lowercased() == item.key.lowercased())
            })
            if let storyboardItem = filteredStoryboard?.first, let sectionItem = filteredSection?.first, let cellItem = filteredCell?.first{
                let relationalMap = MappingView(storyboard: storyboardItem , section: sectionItem, cell: cellItem, order: map.order , readonly: map.readonly)
                self.view?.insert(relationalMap, at: 0)
            }
            
        }
        
    }
}
