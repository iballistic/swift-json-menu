//
//  AppUILocalization.swift
//  swift-json-menu
//
//  Created by Telman Rustam on 2016-12-15.
//  Copyright © 2016 Telman Rustam. All rights reserved.
//

import Foundation

public struct AppUILocalization {
    
    //MARK: Localization for int and double type of cells
    
    /// <#Description#>
    /// - Parameters:
    ///   - cellConfig: cell config defined in the json menu config file
    ///   - unit: destination unit format to convert to
    /// - Returns: text to be used in the place holder of a text field
    public static func placeHolder(cellConfig: TableCell, unit: ValueUnit?) -> String?{
               
        guard var placeHolder = cellConfig.placeholder else{
            return nil
        }
        
        guard  let cellType = cellConfig.celltype else {
            return placeHolder
        }
        
        if cellType != .CellInt && cellType != .CellDouble{
            return placeHolder
        }
        
        if let minval = cellConfig.minval, let maxval = cellConfig.maxval{
            placeHolder = "From \(minval) To \(maxval)"
        }
        
        guard let toUnit = unit else {
            return placeHolder
        }
        
        //at this point integer type conversion is not supported
        if cellConfig.celltype! == .CellInt{
            if let minval = cellConfig.minval, let maxval = cellConfig.maxval{
                placeHolder = "From \(minval) To \(maxval)"
            }
        }
        if cellConfig.celltype! == .CellDouble{
            if let minvalCon = cellConfig.minvalConverted(to: toUnit.name!), let maxvalCon = cellConfig.maxvalConverted(to: toUnit.name!){
                placeHolder = "From \(minvalCon) To \(maxvalCon)"
            }
        }
        
        return placeHolder
    }
    
    
    /// <#Description#>
    /// - Parameters:
    ///   - cellConfig: cell config defined in the json menu config file
    ///   - unit: destination unit format to convert to
    /// - Returns: text value to be used in text field title etc.
    public static func title(cellConfig: TableCell, unit: ValueUnit?) -> String?{
        guard var title = cellConfig.title else{
            return nil
        }
        if let toUnit = unit {
            title = "\(title) (\(toUnit.symbol!))"
            return title
        }else if let defaultUnit = cellConfig.defaultUnit{
            //use default symboc
            title = "\(title) (\(defaultUnit.symbol!))"
            return title
        }
        
        return title

    }
    
    
    /// <#Description#>
    /// - Parameter value: a double value in string format to convert
    /// - Parameter cellConfig: cell config defined in the json menu config file
    /// - Parameter unit: destination unit format to convert to
    /// - Returns: a string value of the converted valueto be used for displaying UI
    public static func textValueToDisplay(value: String, cellConfig: TableCell, unit: ValueUnit?) -> String?{
        var newValue : String?
        
        
        if cellConfig.celltype! != .CellDouble{
            return value
        }
        
        guard let properValue = Double(value) else{
            return value
        }
        
        guard let toUnit = unit else {
            newValue = String(format: cellConfig.format!, properValue)
            //Remove trailing zero
            newValue = String(Double(newValue!)!)
            return newValue
        }
        
        //if the destionation unit is set but it is the same as system unit
        // there is no need to convert back and forth
        if toUnit.name! == (cellConfig.defaultUnit?.name)!{
            newValue = String(format: cellConfig.format!, properValue)
            //Remove trailing zero
            newValue = String(Double(newValue!)!)
            return newValue
        }
        
        let result = cellConfig.convertValue(value: properValue, fromUnit: (cellConfig.defaultUnit?.name)!, toUnit: toUnit.name!)
        newValue = String(format: cellConfig.format!, Double(result!))
        //Remove trailing zero
        newValue = String(Double(newValue!)!)
        return newValue
    }
    
    
    /// <#Description#>
    /// - Parameters:
    ///   - value: a string number
    ///   - cellConfig: cell config defined in the json menu config file
    ///   - unit: destination unit format to convert to
    /// - Returns: a string value of the converted valueto be used for storing in coredata, dictionary etc
    public static func textValueToSave(value: String, cellConfig: TableCell, unit: ValueUnit?) -> String?{
        var newValue : String?
        
        //at this point we only support double types only
        if cellConfig.celltype! != .CellDouble{
            return value
        }
        
        guard let properValue = Double(value) else{
            return value
        }
        
        guard let toUnit = unit else {
            newValue = String(format: cellConfig.format!, properValue)
            //Remove trailing zero
            newValue = String(Double(newValue!)!)
            return newValue
        }
        
        
        //if the destination unit is set but it is the same as system unit
        // there is no need to convert back and forth
        if toUnit.name! == (cellConfig.defaultUnit?.name)!{
            newValue = String(format: cellConfig.format!, properValue)
            //Remove trailing zero
            newValue = String(Double(newValue!)!)
            return newValue
        }
        
        let result = cellConfig.convertValue(value: properValue, fromUnit: toUnit.name! , toUnit: (cellConfig.defaultUnit?.name)!)
        newValue = String(format: cellConfig.format!, Double(result!))
        //Remove trailing zero
        newValue = String(Double(newValue!)!)
        return newValue

    }
    
//    public func isInRange<T : Comparable>(start: T, end: T, val: T) ->Bool {
//        let range: Range<T> = start ..< end
//        return range.contains(val)
//    }
//    
    public static func isInRange<T:Comparable>(start: T?, end: T?, val: T?) ->Bool {
        if let startVal = start, let endVal = end, let current = val{
            
            if current >= startVal && current <= endVal{
                return true
            }
        }
        
        return false
    }
}





