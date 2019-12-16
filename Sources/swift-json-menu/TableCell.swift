//
//  MenuItem.swift
//  JSonMenu
//
//  Created by Telman Rustam on 2017-06-18.
//  Copyright © 2017 Telman Rustam. All rights reserved.
//

import Foundation
//import SwiftHelper

public enum MenuItemType : String{
    case CellString, CellSegue, CellDouble, CellInt, CellLargeString, CellPhoto
    
    init() {
        self = .CellString
    }
}

public enum ConversionOption : String{
    case `default`, optional
    
    init() {
        self = .optional
    }
}

public enum ConversionProvider : String{
    case UnitMassConverter
    case UnitTemperatureConverter
    case UnitSpeedConverter
    case UnitLengthConverter
    case UnitPressureConverter
}

@objcMembers public class TableCell : NSObject{
    
    public var maxchar : NSNumber?
    public var format: String?
    public var key: String
    public var title: String?
    public var celltype : MenuItemType?
    public var placeholder : String?
    public var values : [CellValue]?
    public var unit : [ValueUnit]?
    public var minval : String?
    public var maxval : String?
    public var rowheight : NSNumber?
    
    
    public override init(){
        self.maxchar = 0
        self.celltype = MenuItemType.CellString
        self.key = "Unnamed"
    }
    lazy var provider  = [
        //mass
        "kilograms" : ConversionProvider.UnitMassConverter,
        "grams" : ConversionProvider.UnitMassConverter,
        "decigrams" : ConversionProvider.UnitMassConverter,
        "milligrams" : ConversionProvider.UnitMassConverter,
        "micrograms" : ConversionProvider.UnitMassConverter,
        "nanograms" : ConversionProvider.UnitMassConverter,
        "picograms" : ConversionProvider.UnitMassConverter,
        "ounces" : ConversionProvider.UnitMassConverter,
        "pounds" : ConversionProvider.UnitMassConverter,
        "stones" : ConversionProvider.UnitMassConverter,
        "metricTons" : ConversionProvider.UnitMassConverter,
        "shortTons" : ConversionProvider.UnitMassConverter,
        "carats" : ConversionProvider.UnitMassConverter,
        "ouncesTroy" : ConversionProvider.UnitMassConverter,
        "slugs" : ConversionProvider.UnitMassConverter,
        "grain" : ConversionProvider.UnitMassConverter,
        
        //speed
        "metersPerSecond" : ConversionProvider.UnitSpeedConverter,
        "footPerSecond" : ConversionProvider.UnitSpeedConverter,
        "kilometersPerHour": ConversionProvider.UnitSpeedConverter,
        "milesPerHour" : ConversionProvider.UnitSpeedConverter,
        "knots" : ConversionProvider.UnitSpeedConverter,
        //temprature
        "kelvin": ConversionProvider.UnitTemperatureConverter,
        "celsius": ConversionProvider.UnitTemperatureConverter,
        "fahrenheit": ConversionProvider.UnitTemperatureConverter,
        
        //Length provide
        "megameters" :  ConversionProvider.UnitLengthConverter,
        "kilometers" :  ConversionProvider.UnitLengthConverter,
        "meters" :  ConversionProvider.UnitLengthConverter,
        "centimeters" :  ConversionProvider.UnitLengthConverter,
        "millimeters" :  ConversionProvider.UnitLengthConverter,
        "micrometers" :  ConversionProvider.UnitLengthConverter,
        "nanometers" :  ConversionProvider.UnitLengthConverter,
        "picometers" :  ConversionProvider.UnitLengthConverter,
        "inches" :  ConversionProvider.UnitLengthConverter,
        "feet" :  ConversionProvider.UnitLengthConverter,
        "yards" :  ConversionProvider.UnitLengthConverter,
        "miles" :  ConversionProvider.UnitLengthConverter,
        
        //pressure
        
        "inchesOfMercury":  ConversionProvider.UnitPressureConverter,
        "bars":  ConversionProvider.UnitPressureConverter,
        "millibars":  ConversionProvider.UnitPressureConverter,
        "millimetersOfMercury":  ConversionProvider.UnitPressureConverter,
        "poundsForcePerSquareInch":  ConversionProvider.UnitPressureConverter,
        "kilopascals": ConversionProvider.UnitPressureConverter,
        "hectopascals": ConversionProvider.UnitPressureConverter,
        
    ]
    
    public var defaultUnit : ValueUnit?{
        
        //we want to filter "default" value first instead of just returing a value of the first element.
        let temp = self.unit?.filter({(item : ValueUnit) -> Bool in
            return (item.option == ConversionOption.default)
        })
        
        //even it is a filtered result, we still want to return first default value. There should be only first default value
        return temp?.first
    }
    
    public func getUnit(byName: String) ->ValueUnit?{
        
        //we want to filter "default" value first instead of just returing a value of the first element.
        let temp = self.unit?.filter({(item : ValueUnit) -> Bool in
            return (item.name?.lowercased() == byName.lowercased())
        })
        
        //even it is a filtered result, we still want to return first default value. There should be only first default value
        return temp?.first
    }
    
    public var defaultValue : CellValue?{
        
        //we want to filter "default" value first instead of just returing a value of the first element.
        let temp = self.values?.filter({(item : CellValue) -> Bool in
            return (item.requirement == ValueRequirement.default)
        })
        
        //even it is a filtered result, we still want to return first default value. There should be only first default value
        return temp?.first ?? nil
    }
    
    public func defaultValueConverted(to: String) -> CellValue?{
        
        if var convertedCellValue = self.defaultValue{
            
            
            if let temp = self.convertValue(value: Double(convertedCellValue.value!)!, fromUnit: (self.defaultUnit?.name)!, toUnit: to){
            convertedCellValue.value = String(format: self.format!, temp)
            return convertedCellValue
        }
    }
    return nil
}

public func minvalConverted(to: String) ->String?{
    
    if let value = self.minval{
        if let temp = self.convertValue(value: Double(value)!, fromUnit: (self.defaultUnit?.name)!, toUnit: to){
            return String(format: self.format!, temp)
        }
    }
    return nil
    
}

public func maxvalConverted(to: String) ->String?{
    if let value = self.maxval{
        if let temp = self.convertValue(value: Double(value)!, fromUnit: (self.defaultUnit?.name)!, toUnit: to){
            return String(format: self.format!, temp)
        }
    }
    return nil
}

public var sortedValue : [CellValue]?{
    
    let sorted = values?.sorted(by: {(first: CellValue, second: CellValue) -> Bool
        in return (first.value! < second.value!)
    })
    return sorted
}

public func convertedValue(fromUnit: String, toUnit: String)->[CellValue]?{
    var cValue = [CellValue]()
    for value in self.values!{
        var newValue = value
        newValue.value = "\(String(describing: self.convertValue(value: Double(value.value!)!, fromUnit: fromUnit, toUnit: toUnit)))"
        cValue.append(newValue)
    }
    return cValue
}

////MARK: convertValue converts values from unit to another
public func convertValue(value: Double, fromUnit: String, toUnit: String)->Double?{

    guard self.provider.keys.contains(fromUnit) else{
        return nil
    }

    guard self.provider.keys.contains(toUnit) else{
        return nil
    }

    let from = provider[fromUnit]!
    let to = provider[toUnit]!
    if to != from{
        return nil
    }
    let converterClass = NSClassFromString("swift-json-menu.\(from.rawValue)") as! NSObject.Type
    let converter = converterClass.init() as! IConverter
    return converter.convert(value: value, fromUnit: fromUnit, toUnit: toUnit)
}
}


extension TableCell{
    
    
    convenience init(json: [String: Any]?) {
        
        
        self.init()
        
        guard let config = json else{
            return
        }
        //initialize value array
        self.values = []
        self.setValue(config["key"] as? String, forKey: "key")
        self.setValue(config["title"] as? String, forKey: "title")
        self.setValue(config["maxchar"] as? NSInteger, forKey: "maxchar")
        self.setValue(config["placeholder"] as? String, forKey: "placeholder")
        self.setValue(config["format"] as? String, forKey: "format")
        self.setValue(config["minval"] as? String, forKey: "minval")
        self.setValue(config["maxval"] as? String, forKey: "maxval")
        self.setValue(config["rowheight"] as? NSInteger, forKey: "rowheight")
        
        
        if let cellType = config["celltype"] as? String {
            self.celltype = MenuItemType(rawValue: cellType)
            //self.setValue(MenuItemType(rawValue: cellType), forKey: "celltype")
        }
        
        if let valueJson = config["values"] as? [Any]{
            for value in valueJson {
                let itemValue = CellValue(json: (value as? [String:Any])!)
                self.values?.insert(itemValue, at: 0)
            }
        }
        
        //initialize unit array
        self.unit = []
        if let unitJson = config["converter"] as? [Any]{
            for value in unitJson {
                let itemUnit = ValueUnit(json: (value as? [String:Any])!)
                self.unit?.insert(itemUnit, at: 0)
            }
        }
        
    }
}
