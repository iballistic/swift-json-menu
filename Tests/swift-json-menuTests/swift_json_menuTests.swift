import XCTest
@testable import swift_json_menu

final class swift_json_menuTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(swift_json_menu().text, "Hello, World!")
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
    ]
}
