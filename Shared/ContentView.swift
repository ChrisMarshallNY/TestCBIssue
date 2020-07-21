//
//  ContentView.swift
//  TestCBIssue
//
//  Created by Chris Marshall on 7/17/20.
//  Copyright © 2020 Little Green Viper Software Development LLC. All rights reserved.
//

import SwiftUI
import CoreBluetooth

/**
 What we do, is create a simple cache of structs that contain strong references to captured Peripherals.
 
 This is populated by the Central Manager Delegate callback.
 
 After five seconds, we dump the list to the console, and terminate the scanning.
 */

/// The type for each element of the cache. It keeps evertything sent to the callback.
struct PeripheralItem {
    let peripheral: CBPeripheral
    let advertisementData: [String: Any]
    let signalStrength: Int
}

/// This makes sure we don't already have it. If not, we add it to our cache.
func addPeripheral(_ peripheral: CBPeripheral, _ advertisementData: [String : Any], _ rssi: Int) {
    if !cache.contains(where: {$0.peripheral.identifier.uuidString == peripheral.identifier.uuidString} ) {
        cache.append(PeripheralItem(peripheral: peripheral, advertisementData: advertisementData, signalStrength: rssi))
    }
}

/// This is a timer callback that dumps the cache to the console.
func printPeripherals(_: Timer) {
    testInstance = nil
    print("----\nPeripheral List:")
    cache.forEach {
        if let name = $0.peripheral.name {
            print("Discovered Peripheral (\($0.peripheral.identifier.uuidString)) Named \"\(name)\"")
        } else {
            print("Discovered Peripheral (\($0.peripheral.identifier.uuidString)) With Nil Name")
        }
        print("\tPeripheral: \(String(describing: $0.peripheral))")
        print("\tAdvertisement Data: \(String(describing: $0.advertisementData))")
        print("\tSignal Strength: \($0.signalStrength)dBm\n")
    }
    print("----\n")
}

/// This is a simple class that holds a central manager, and also acts as its delegate.
class TestCBIssue: NSObject, CBCentralManagerDelegate {
    var central: CBCentralManager!
    let callBackHook: CallBackHookType
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            central.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    /// This is the delegate callback.
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        callBackHook(peripheral, advertisementData, RSSI.intValue)
    }
    
    /// We initialize it with a pointer to the function we'll use to populate the cache.
    init(callBackHook: @escaping CallBackHookType) {
        self.callBackHook = callBackHook
        super.init()
        central = CBCentralManager(delegate: self, queue: nil)
    }
}

typealias CallBackHookType = (_: CBPeripheral, _: [String : Any], _: Int) -> Void

var testInstance: TestCBIssue!
var cache: [PeripheralItem] = []

struct ContentView: View {
    var body: some View {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: printPeripherals)
        testInstance = TestCBIssue(callBackHook: addPeripheral)
        return Text("Look at the console log!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
