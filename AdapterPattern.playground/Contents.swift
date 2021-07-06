//: Playground - noun: a place where people can play

import UIKit
import Foundation

protocol ChargeableProtocol{
    func charge(volts:Double)
}

class PhonePrototype:ChargeableProtocol{
    func charge(volts: Double) {
        print("Chargin our PhonePrototype")
        print("Current voltage \(volts)")
    }
}

class Charger{
    var phone : ChargeableProtocol!
    let volts = 10.0
    
    func plugChargeMobile(phone:ChargeableProtocol){
        self.phone = phone
        phone.charge(volts: volts)
    }
}

class SamSingMobilePhone{
    enum VoltageError : Error {
        case TooHigh
        case TooLow
    }
    
    func chargeBattery(volts:Double) throws{
        if volts > 10 {throw VoltageError.TooHigh}
        if volts < 10 {throw VoltageError.TooLow}
        
        print("SamSing Mobile Phone is charging")
        print("Current voltage \(volts)")
    }
}


class PearMobilePhone{
    enum PearVoltageError : Error{
        case NoPower
        case TooLow
        case TooHight
    }
    
    func charge(volts:Double) throws{
        guard volts > 0 else{
            throw PearVoltageError.NoPower
        }
        
        if volts > 5.5 {throw PearVoltageError.TooHight}
        if volts < 5.5 {throw PearVoltageError.TooLow}
        
        print("Pear Mobile Phone is charging")
        print("Current voltage \(volts)")
    }
}

class SamSingAdapter:ChargeableProtocol{
    var samSingPhone : SamSingMobilePhone
    
    init(phone:SamSingMobilePhone){
        samSingPhone = phone
    }
    
    func charge(volts: Double) {
        do {
            print("Adapter started")
            _ = try samSingPhone.chargeBattery(volts: volts)
            print("Adapter ended")
        }catch SamSingMobilePhone.VoltageError.TooHigh{
            print("Voltage is too high")
        }catch SamSingMobilePhone.VoltageError.TooLow{
            print("Voltage is too low")
        }catch{
            print("an error occured")
        }
    }
}

class PearAdapter: ChargeableProtocol {
    var pearMobilePhone:PearMobilePhone!
    init(phone: PearMobilePhone){
        pearMobilePhone = phone
    }
    func charge(volts: Double) {
        do {
            print("Adapter started")
            _ = try pearMobilePhone.charge(volts: 5.5)
            print("Adapter ended")
        }catch PearMobilePhone.PearVoltageError.TooHight{
            print("Voltage is too high")
        }catch PearMobilePhone.PearVoltageError.TooLow{
            print("Voltage is too low")
        }catch{
            print("an error occured")
        }
    }
}


// Create our Charger
let charger = Charger()
let pearPhone = PearMobilePhone()
let pearAdapter = PearAdapter(phone : pearPhone)
charger.plugChargeMobile(phone: pearAdapter)


let samSingPhone = SamSingMobilePhone()
let samSingAdapter = SamSingAdapter(phone: samSingPhone)
charger.plugChargeMobile(phone:samSingAdapter)

let phone = PhonePrototype()
let phoneAdapter = Charger()
phoneAdapter.plugChargeMobile(phone: phone)



