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
 
 
 
 
