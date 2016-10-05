## Adapter Pattern in Swift
  * This pattern is oftens used when dealing with framework,libraries, APIs to easily adapt the old and exsting interface to new 
  requirement of a program. 
  * The adapter pattern converts the interface of the another existing class into an interface waited by the existing client
  to allow them work together.
  * You can integrate components for which you normally can't modify the source code and things that often appear with the use 
  of a framework.
  * **Note that:** You should advoid using this pattern if you have the source code to access to the component.
  
## Implement
 **Scenario:** The sales director of your company want to produce a universal battery charge for mobile phones. This charge
 can delivery up to 10 volts as output. As the CIO of the company, a member of your development team presents you a first 
 prototype of the charger.
 
 * The ChargeableProtocol interface is a simple protocol that define the signatures of the *charge* method:
 
 ```swift
 protocol ChargeableProtocol
 {
    func charge(volts:Double)
 }
 ```
 
 * We define a PhonePrototype class that can be charged using the ChargeableProtocol protocol:
 
 ```swift
 class PhonePrototype:ChargeableProtocol
 {
    func charge(volts: Double) 
    {
        print("Chargin our PhonePrototype")
        print("Current voltage \(volts)")
    }
}
 ```
 
 * Next, we create the *Charge* class that using to plugin for your phone:
 
 ```swift
 class Charger{
    var phone : ChargeableProtocol!
    let volts = 10.0
    
    func plugChargeMobile(phone:ChargeableProtocol){
        self.phone = phone
        phone.charge(volts: volts)
    }
  }
 ```
 The implementation of preceding code is quit simple
    * Our charger contains a reference to a phone. The phone must conform to ChargeableProtocol. Of course, our universal 
  charger will only comunicate with this interface.
    * We have a method where you can plug our phone.
    * We assign the phone to our reference and call the charge method of your phone.
  
 * Your mobile phone will work fine with all mobile phone charger that implement with ChargeableProtocol but not with
 mobile phones available on the market. That is the problem. Indeed, each mobile phone manufacturer has its owner interface
 to charge its owns products.
## Implement of adaptee:
 * **Adaptees: This contains the component that we must adapt. You can consider this one if you don't have the source code. Remember that you should not use the adapter pattern if you own the source code. **
 * It's suppose that we have others mobile phone manufacturer: Pear and SamSing mobile phone. If we want to sell the battery phone for them, Our charger have to work with their mobile phone. 
    * What would we do with the phones that already sold that not implemented ChargeableProtocol?
    We must adapt our charger, depending on the manufacturer.
 
 * These two classes represent our objects that need to be adapted, two mobile phone need different voltage to be charged : 
    * The first one is SamSingMobilePhone class that has a 
    *chargeBattery* method. This is the method that used by the original charger to charge the SamSing mobile phone
 
 ```swift
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
 ```
 
   * The second one is the PearMobilePhone class that allow to the original charger to charge the battery for Pear mobile phone
   
   ```swift
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
   ```
   
   **Note: in real life, you don't have the source of SamSing and Pear mobile phone. You'll only work with the known interface**
   
## Implementation of the adapter
  * **Adapter: This contains our adapters depending on the mobile phones that we must change**
  
  * The SamSing adapter class: we can code new adapter that will be able to work with SamSing mobile phone
  
  ```swift
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
  ```
  We create new SamSingAdapter class that implement *ChargeableProtocol*. We need to provide the *charge* method that take the voltage as an argument
  
  * The Pear adapter class: we will proceed in the same way as the SamSingAdapter class but with Pear mobile phone.
  
  ```swift
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
  ```
 ## Usage: 
 We have our universal charger, two adapter, and two mobile phones to test our charge 
 ```swift
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
 ```
 
 
 
