//
//  ContentView.swift
//  TestCBIssue
//
//  Created by Chris Marshall on 7/17/20.
//  Copyright © 2020 Little Green Viper Software Development LLC. All rights reserved.
//

import SwiftUI
import CoreBluetooth

typealias CallBackHookType = (_: CBPeripheral, _: [String : Any], _: Int) -> Void

var testInstance: TestCBIssue!

func printPeripheral(_ peripheral: CBPeripheral, _ advertisementData: [String : Any], _ rssi: Int) {
    if let name = peripheral.name {
        print("Discovered Peripheral (\(peripheral.identifier.uuidString)) Named \"\(name)\"")
    } else {
        print("Discovered Peripheral (\(peripheral.identifier.uuidString)) With Nil Name")
    }
    print("\tPeripheral: \(String(describing: peripheral))")
    print("\tAdvertisement Data: \(String(describing: advertisementData))")
    print("\tSignal Strength: \(rssi)dBm\n")
}

class TestCBIssue: NSObject, CBCentralManagerDelegate {
    var central: CBCentralManager!
    let callBackHook: CallBackHookType
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            central.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        callBackHook(peripheral, advertisementData, RSSI.intValue)
    }
    
    init(callBackHook: @escaping CallBackHookType) {
        self.callBackHook = callBackHook
        super.init()
        central = CBCentralManager(delegate: self, queue: nil)
    }
}

struct ContentView: View {
    var body: some View {
        testInstance = TestCBIssue(callBackHook: printPeripheral)
        return Text("Look at the console log!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
