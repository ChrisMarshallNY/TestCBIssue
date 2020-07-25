![Icon](icon.png)

# STRANGE CORE BLUETOOTH ISSUE

This project contains about the simplest comparison I can make for testing this.

[This is the GitHub repo for this project](https://github.com/ChrisMarshallNY/TestCBIssue)

## THE ISSUE

When a MacOS app gets the [centralManager(_ central: CBCentralManager, didDiscover: CBPeripheral, advertisementData: [String : Any], rssi: NSNumber)](https://developer.apple.com/documentation/corebluetooth/cbcentralmanagerdelegate/1518937-centralmanager) callback, it delivers different data on the Mac, than on iOS, WatchOS or TVOS.

The code is **EXACTLY** the same between them. I use a simple shared SwiftUI view to instantiate a dirt-simple CentralManager, and display discovered devices.

On iOS, I get the names of the devices.

On the Mac, I fail to get most of the names.

On TVOS, I sometimes get the default manufacturer name, instead of the device name that I set.

Also, on the Mac, the "kCBScanOptionAppleFilterPuckType" is added to advertisement data, but is not available anywhere else.

Sample Mac console log:

    Discovered Peripheral (0AD4EE4D-F702-4C62-BA7A-4AB5054C1186) With Nil Name
    Peripheral: <CBPeripheral: 0x600003311e00, identifier = 0AD4EE4D-F702-4C62-BA7A-4AB5054C1186, name = (null), state = disconnected>
    Advertisement Data: ["kCBAdvDataChannel": 37, "kCBAdvDataTxPowerLevel": 12, "kCBAdvDataManufacturerData": <4c001006 111e9d2d 2cd5>, "kCBAdvDataAppleMfgData": {
    kCBScanOptionAppleFilterPuckType = 16;
    }, "kCBAdvDataIsConnectable": 1]
    Signal Strength: -45dBm

    Discovered Peripheral (1C709CC5-C106-48EF-8E87-E802CE4C5572) With Nil Name
    Peripheral: <CBPeripheral: 0x600003314c80, identifier = 1C709CC5-C106-48EF-8E87-E802CE4C5572, name = (null), state = disconnected>
    Advertisement Data: ["kCBAdvDataChannel": 37, "kCBAdvDataTxPowerLevel": 12, "kCBAdvDataAppleMfgData": {
    kCBScanOptionAppleFilterPuckType = 16;
    }, "kCBAdvDataManufacturerData": <4c001005 09144cad 8f>, "kCBAdvDataIsConnectable": 1]
    Signal Strength: -55dBm

    Discovered Peripheral (26BB7EFA-1055-40D8-9564-8768370AD033) With Nil Name
    Peripheral: <CBPeripheral: 0x600003305680, identifier = 26BB7EFA-1055-40D8-9564-8768370AD033, name = (null), state = disconnected>
    Advertisement Data: ["kCBAdvDataManufacturerData": <4c000906 0310c0a8 0418>, "kCBAdvDataIsConnectable": 0, "kCBAdvDataAppleMfgData": {
    kCBScanOptionAppleFilterPuckType = 9;
    }, "kCBAdvDataChannel": 37]
    Signal Strength: -55dBm

Sample iOS console log:

    Discovered Peripheral (453F3B1F-2E57-4F12-BA4C-4518295797DB) Named "Desk"
    Peripheral: <CBPeripheral: 0x281031900, identifier = 453F3B1F-2E57-4F12-BA4C-4518295797DB, name = Desk, state = disconnected>
    Advertisement Data: ["kCBAdvDataIsConnectable": 1, "kCBAdvDataRxSecondaryPHY": 0, "kCBAdvDataTimestamp": 617020468.3501019, "kCBAdvDataRxPrimaryPHY": 1, "kCBAdvDataTxPowerLevel": 12]
    Signal Strength: -53dBm

    Discovered Peripheral (8D8FB9C1-72C2-9177-E379-B5181D903D51) Named "Lady"
    Peripheral: <CBPeripheral: 0x28103c140, identifier = 8D8FB9C1-72C2-9177-E379-B5181D903D51, name = Lady, state = disconnected>
    Advertisement Data: ["kCBAdvDataIsConnectable": 1, "kCBAdvDataRxSecondaryPHY": 0, "kCBAdvDataTxPowerLevel": 12, "kCBAdvDataRxPrimaryPHY": 1, "kCBAdvDataTimestamp": 617020468.608742]
    Signal Strength: -46dBm

    Discovered Peripheral (0989D0B0-9F07-46C0-95A5-BE60CC2E2318) Named "Tom-Tom"
    Peripheral: <CBPeripheral: 0x281031540, identifier = 0989D0B0-9F07-46C0-95A5-BE60CC2E2318, name = Tom-Tom, state = disconnected>
    Advertisement Data: ["kCBAdvDataIsConnectable": 1, "kCBAdvDataRxSecondaryPHY": 0, "kCBAdvDataTxPowerLevel": 12, "kCBAdvDataTimestamp": 617020468.2814471, "kCBAdvDataRxPrimaryPHY": 1]
    Signal Strength: -42dBm

Sample TVOS console log:

    Discovered Peripheral (013FD658-4D24-2949-7CD4-D24E1E11E5B4) Named "Goblin"
    Peripheral: <CBPeripheral: 0x28188dcc0, identifier = 013FD658-4D24-2949-7CD4-D24E1E11E5B4, name = Goblin, state = disconnected>
    Advertisement Data: ["kCBAdvDataTxPowerLevel": 12, "kCBAdvDataTimestamp": 617020421.622254, "kCBAdvDataRxPrimaryPHY": 0, "kCBAdvDataRxSecondaryPHY": 0, "kCBAdvDataIsConnectable": 1]
    Signal Strength: -35dBm

    Discovered Peripheral (F1F2457B-5979-C190-AEEC-1EFA8A12564C) Named "Lady"
    Peripheral: <CBPeripheral: 0x28188db80, identifier = F1F2457B-5979-C190-AEEC-1EFA8A12564C, name = Lady, state = disconnected>
    Advertisement Data: ["kCBAdvDataTimestamp": 617020421.592942, "kCBAdvDataIsConnectable": 1, "kCBAdvDataRxSecondaryPHY": 0, "kCBAdvDataTxPowerLevel": 12, "kCBAdvDataRxPrimaryPHY": 0]
    Signal Strength: -39dBm

    Discovered Peripheral (59A8D3DF-AACC-477E-A9D0-DE066CCE4CC0) Named "iPad Mini 4"
    Peripheral: <CBPeripheral: 0x281889180, identifier = 59A8D3DF-AACC-477E-A9D0-DE066CCE4CC0, name = iPad Mini 4, state = disconnected>
    Advertisement Data: ["kCBAdvDataRxSecondaryPHY": 0, "kCBAdvDataTxPowerLevel": 12, "kCBAdvDataTimestamp": 617020421.519154, "kCBAdvDataRxPrimaryPHY": 0, "kCBAdvDataIsConnectable": 1]
    Signal Strength: -32dBm

Sample WatchOS Console Log:

    Discovered Peripheral (6FF706B4-DC6C-C078-0806-D2D218D798DF) Named "Goblin"
    Peripheral: <CBPeripheral: 0x146c5b40, identifier = 6FF706B4-DC6C-C078-0806-D2D218D798DF, name = Goblin, state = disconnected>
    Advertisement Data: ["kCBAdvDataRxPrimaryPHY": 0, "kCBAdvDataTimestamp": 617021658.142233, "kCBAdvDataIsConnectable": 0, "kCBAdvDataRxSecondaryPHY": 0]
    Signal Strength: -53dBm

    Discovered Peripheral (857DF2B2-1332-91B3-79EA-9CC8BCCFCB1F) Named "Lady"
    Peripheral: <CBPeripheral: 0x146c8450, identifier = 857DF2B2-1332-91B3-79EA-9CC8BCCFCB1F, name = Lady, state = disconnected>
    Advertisement Data: ["kCBAdvDataIsConnectable": 0, "kCBAdvDataRxPrimaryPHY": 0, "kCBAdvDataTimestamp": 617021657.925077, "kCBAdvDataRxSecondaryPHY": 0]
    Signal Strength: -54dBm

    Discovered Peripheral (898FF664-2E7D-3F1B-0093-E7C9F6FB9219) Named "Tom-Tom"
    Peripheral: <CBPeripheral: 0x146beea0, identifier = 898FF664-2E7D-3F1B-0093-E7C9F6FB9219, name = Tom-Tom, state = disconnected>
    Advertisement Data: ["kCBAdvDataIsConnectable": 0, "kCBAdvDataRxPrimaryPHY": 0, "kCBAdvDataRxSecondaryPHY": 0, "kCBAdvDataTimestamp": 617021657.716563]
    Signal Strength: -67dBm
