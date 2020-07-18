//
//  ContentView.swift
//  TestCBIssue
//
//  Created by Chris Marshall on 7/17/20.
//  Copyright © 2020 Little Green Viper Software Development LLC. All rights reserved.
//

import SwiftUI
import CoreBluetooth

var testInstance: TestCBIssue!

func printPeripheral(_ peripheral: CBPeripheral) {
    print("Discovered \"\(peripheral.name ?? "NO NAME!")\"")
}

class TestCBIssue: NSObject, CBCentralManagerDelegate {
    var central: CBCentralManager!
    let callBackHook: (_: CBPeripheral) -> Void
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            central.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        callBackHook(peripheral)
    }
    
    init(callBackHook: @escaping (_: CBPeripheral) -> Void) {
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
