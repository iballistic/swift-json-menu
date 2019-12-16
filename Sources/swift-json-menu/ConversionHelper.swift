//
//  ConversionWrapper.swift
//  JSonMenu
//
//  Created by Telman Rustam on 2017-06-24.
//  Copyright © 2017 Telman Rustam. All rights reserved.
//

import Foundation

public extension UnitMass{
 @objc static var grain : UnitMass{
        //1kg is 15432.3584 grain
        //6.4799e-5
        return UnitMass(symbol: "gr",converter: UnitConverterLinear(coefficient: 6.4799e-5))
    }
}


public extension UnitSpeed{
@objc static var footPerSecond : UnitSpeed{
        return UnitSpeed(symbol: "ft/s",converter: UnitConverterLinear(coefficient: 0.3048))
    }
}

@objcMembers
public class IConverter : NSObject{
    public func convert(value: Double, fromUnit: String, toUnit: String)->Double?{
        return nil
    }
}

@objcMembers
public class UnitMassConverter : IConverter{
    //need to look into the following
    //https://www.sitepoint.com/using-measurementformatter/
    //https://stackoverflow.com/questions/41313204/how-to-format-a-swift-3-nsmeasurement-string-to-at-most-2-decimal-places-after-c
    //https://stackoverflow.com/questions/29613994/how-to-represent-magnitude-for-mass-in-swift/29616986
    public override func convert(value: Double, fromUnit: String, toUnit: String) -> Double?{
        let base = Measurement(value: value, unit: UnitMass.value(forKey: fromUnit) as! UnitMass )
        let converted = base.converted(to: UnitMass.value(forKey: toUnit) as! UnitMass)
        return converted.value
    }
}
@objcMembers
public class UnitSpeedConverter : IConverter{
    public override func convert(value: Double, fromUnit: String, toUnit: String) -> Double?{
        let base = Measurement(value: value, unit: UnitSpeed.value(forKey: fromUnit) as! UnitSpeed )
        let converted = base.converted(to: UnitSpeed.value(forKey: toUnit) as! UnitSpeed)
        return converted.value
    }
}
@objcMembers
public class UnitTemperatureConverter : IConverter{
    public override func convert(value: Double, fromUnit: String, toUnit: String) -> Double?{
        let base = Measurement(value: value, unit: UnitTemperature.value(forKey: fromUnit) as! UnitTemperature )
        let converted = base.converted(to: UnitTemperature.value(forKey: toUnit) as! UnitTemperature)
        return converted.value
    }
}
@objcMembers
public class UnitLengthConverter : IConverter{
    public override func convert(value: Double, fromUnit: String, toUnit: String) -> Double?{
        let base = Measurement(value: value, unit: UnitLength.value(forKey: fromUnit) as! UnitLength )
        let converted = base.converted(to: UnitLength.value(forKey: toUnit) as! UnitLength)
        return converted.value
    }
}
@objcMembers
public class UnitPressureConverter : IConverter{
    public override func convert(value: Double, fromUnit: String, toUnit: String) -> Double?{
        let base = Measurement(value: value, unit: UnitPressure.value(forKey: fromUnit) as! UnitPressure )
        let converted = base.converted(to: UnitPressure.value(forKey: toUnit) as! UnitPressure)
        return converted.value

    }
}


