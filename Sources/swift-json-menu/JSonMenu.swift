//
//  JSonMenu.swift
//  swift-json-menu
//
//  Created by Telman Rustam on 2017-07-03.
//  Copyright © 2017 Telman Rustam. All rights reserved.
//

import Foundation

//https://developer.apple.com/swift/blog/?id=37
//https://developer.apple.com/swift/blog/?id=37

public class JSonMenu : NSObject{
    
    private var storyboard : [Storyboard]?
    private var section : [TableSection]?
    private var cell : [TableCell]?
    private var mapping : [RelationalMapping]?
    private var view : [RelationalView]?
    
    
    public init(storyboard: [Storyboard]?, section: [TableSection]?, cell: [TableCell]?, mapping: [RelationalMapping]?){
        
        self.storyboard = storyboard
        self.section = section
        self.cell = cell
        self.mapping = mapping
    }
    
    public override init() {
        
    }
    
    public func Section(forStoryboard: String) ->[TableSection]?{
        
        let filtered = self.view?.filter({ (map: RelationalView) -> Bool in
            return (map.storyboard?.name?.lowercased() == forStoryboard.lowercased())
        })
        
        let sorted = filtered?.sorted(by: { (item1 : RelationalView, item2: RelationalView) -> Bool in
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
    
    public func View(forStoryboard: String, forSection: String) ->[RelationalView]?{
        
        let filtered = self.view?.filter({ (map: RelationalView) -> Bool in
            return (map.storyboard?.name?.lowercased() == forStoryboard.lowercased() && map.section?.name.lowercased() == forSection.lowercased())
        })
        
        
        let sorted = filtered?.sorted(by: { (item1 : RelationalView, item2: RelationalView) -> Bool in
            return (item1.order! < item2.order!)
        })
        
        return sorted
    }
    
    public func View(forStoryboard: String) ->[RelationalView]?{
        
        let filtered = self.view?.filter({ (map: RelationalView) -> Bool in
            return (map.storyboard?.name?.lowercased() == forStoryboard.lowercased())
        })
        
        
        let sorted = filtered?.sorted(by: { (item1 : RelationalView, item2: RelationalView) -> Bool in
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
    public convenience init(collection: [String: Any]){
        
        self.init()
        
        guard let storyboardItems = collection["storyboard"] as? [Any] else{
            return
        }
        
        guard let sectionItems = collection["section"] as? [Any] else{
            return
        }
        guard let cellItems = collection["cells"] as? [Any] else{
            return
        }
        guard let mapItems = collection["mapping"] as? [Any] else{
            return
        }
        
        //parse storyboards
        self.storyboard = []
        for storyboardItem in storyboardItems{
            let boardObj = Storyboard(json: (storyboardItem as? [String:Any])!)
            self.storyboard?.insert(boardObj, at: 0)
        }
        
        
        //parse sections
        self.section = []
        for sectionItem in sectionItems{
            let sectionObj = TableSection(json: (sectionItem as? [String:Any])!)
            self.section?.insert(sectionObj, at: 0)
        }
        
        //parse table cell
        self.cell = []
        for cellItem in cellItems{
            let cellObj = TableCell(json: (cellItem as? [String:Any])!)
            self.cell?.insert(cellObj, at: 0)
        }
        
        //parse mapping
        self.mapping = []
        for mapItem in mapItems{
            let cellObj = RelationalMapping(json: (mapItem as? [String:Any])!)
            self.mapping?.insert(cellObj, at: 0)
        }
        
        //create a relational view
        self.view = []
        for map in self.mapping!{
            // mapping must use a valid story board
            let filteredStoryboard = self.storyboard?.filter({ (item: Storyboard) -> Bool in
                return (map.storyboard?.lowercased() == item.name?.lowercased())
            })
            // mapping must use a valid section
            let filteredSection = self.section?.filter({ (item: TableSection) -> Bool in
                return (map.section?.lowercased() == item.name.lowercased())
            })
            // mapping must use a valid cell config
            let filteredCell = self.cell?.filter({ (item: TableCell) -> Bool in
                return (map.cell?.lowercased() == item.key.lowercased())
            })
            // now we can try to build relational view
            if let storyboardItem = filteredStoryboard?.first, let sectionItem = filteredSection?.first, let cellItem = filteredCell?.first{
                let relationalMap = RelationalView(storyboard: storyboardItem , section: sectionItem, cell: cellItem, order: map.order , readonly: map.readonly)
                self.view?.insert(relationalMap, at: 0)
            }
            
        }
        
    }
}

extension JSonMenu{
    public convenience init(jsonString : String, encoding : String.Encoding) throws{
        
        do{
            let data = jsonString.data(using: encoding)
            let collection = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any] //NSMutableDictionary
            self.init(collection: collection)
            return
        }
        
        
        catch{
            throw JSonMenuError.JsonParseError(error: "\(error)")
            self.init()
        }
        
        
    }
}

extension JSonMenu{
    public convenience init(jsonFilePath : String) throws{
        
        do{
            let content = try? String.init(contentsOfFile: jsonFilePath)
            if let jsonString = content{
                try self.init(jsonString: jsonString, encoding: .utf8)
                return
            }
            
        }
        catch{
            throw JSonMenuError.FileParseError(error: "\(error)")
        }
        
        self.init()
    }
}


extension JSonMenu {
    
    public var Sections:  [TableSection]? {
        get {
            return self.section
        }
    }
    
    public var Storyboards: [Storyboard]? {
        get {
            return self.storyboard
        }
    }
    
    public var Cells : [TableCell]? {
        get {
            return self.cell
        }
    }
    
    public var Mappings : [RelationalMapping]? {
        get {
            return self.mapping
        }
    }
    
}


