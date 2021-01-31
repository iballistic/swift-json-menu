import XCTest
@testable import swift_json_menu

final class swift_json_menuTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(swift_json_menu().text, "Swift Json Menu")
    }
    
    func testStringToDouble(){
        
        let stringValue1 = "5,2"
        let stringValue2 = "5.2"
        if let value1 = stringValue1.doubleValue{
            print(value1)
            
        }else{
            XCTFail()
        }
        
        if let value2 = stringValue2.doubleValue{
            print(value2)
        }else
        {
            XCTFail()
        }
        
    }
    
    func testJsonMenuFromString(){
        let content : String = #"""
        {
            "storyboard": [
                {
                    "name": "foodmenu",
                    "comment": "Food menu",
                    "title": "Food menu"
                }
            ],
            "section": [
                {
                    "name": "breakfast",
                    "order" : 10,
                    "header": "Breakfast",
                    "footer": ""
                },
                {
                    "name": "lunch",
                    "order" : 10,
                    "header": "Lunch",
                    "footer": ""
                },
                {
                    "name": "dinner",
                    "order" : 30,
                    "header": "Dinner",
                    "footer": ""
                }
            ],
            "cells": [
                {
                    "format": "",
                    "key": "tea",
                    "title": "Tea flavor",
                    "celltype": "CellString",
                    "placeholder": "Enter Tea flavors",
                    "values": [{
                        "value": "orange pekoe",
                        "type": "default"
                    }]
                },
                {
                    "format": "",
                    "key": "juice",
                    "title": "Juice",
                    "celltype": "CellString",
                    "placeholder": "Juice kind",
                    "values": [{
                        "value": "orange",
                        "type": "default"
                    }]
                }
            ],
            "mapping": [
                {
                    "storyboard": "foodmenu",
                    "section": "breakfast",
                    "cell": "tea",
                    "readonly": false,
                    "order": 0
                }
            ]
        }


        """#
        
//        do{
//            let jsonMenu = try JSonMenu(jsonString: content, encoding: .utf8)
//            
//            XCTAssertEqual(jsonMenu.Storyboards!.count, 1)
//            XCTAssertEqual(jsonMenu.Sections!.count, 3)
//            XCTAssertEqual(jsonMenu.Cells!.count, 2)
////            XCTAssertEqual(jsonMenu.!.count, 2)
//            
//        }catch{
//            print("Error: \(error)")
//        }
//        
        
        
    }
    
    func testTableSection(){
        let section = TableSection(name: "Name1", header: "Header1", footer: "Footer1", order: 10)
        
        XCTAssertEqual ("Name1", section.name)
        
        
    }
    
    func testMenuItemObjectCreation(){
        let menuItem = TableCell()
        menuItem.key = "name"
        menuItem.title = "Enter a name"
        
        //var values =  [ItemValue]()
        //var values: Array<ItemValue> = Array()
        var values: [CellValue] = []
        values.append(CellValue(value: "168", requirement: ValueRequirement(rawValue: "optional")))
        values.append(CellValue(value: "165", requirement: ValueRequirement.optional))
        values.append(CellValue(value: "167", requirement: ValueRequirement.optional))
        //lets add another default value to see if we can confuse the system.
        values.append(CellValue(value: "165", requirement: ValueRequirement(rawValue: "default")))
        //set values
        menuItem.values = values
        
        var valueUnit: [ValueUnit] = []
        valueUnit.append(ValueUnit(name: "grain", option: ConversionOption(rawValue: "default"), symbol: "gr" ))
        valueUnit.append(ValueUnit(name: "grams", option: ConversionOption.optional, symbol: "g" ))
        
        menuItem.unit = valueUnit
        
        
        
        print("values")
        for item in menuItem.values!{
            print(item.value ?? "")
        }
        
        //__exp10(-12.0/10)
        
        
        
        print("default value \(String(describing: menuItem.defaultValue?.value))")
        
        print("sorted  value \(String(describing: menuItem.sortedValue?.first?.value))")
        
        
        //convert values
        //        print(menuItem.defaultConverter)
        
        let convertedValue = menuItem.convertedValue(fromUnit: (menuItem.defaultUnit?.name)!, toUnit: "grams")
        
        print("converted values")
        
        for citem in convertedValue!{
            print(citem.value ?? "")
        }
        
        
        
    }
    
    static var allTests = [
        ("testMenuItemObjectCreation", testMenuItemObjectCreation),
        ("testStringToDouble", testStringToDouble)
    ]
}
