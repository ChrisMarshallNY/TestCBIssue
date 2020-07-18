# STRANGE CORE BLUETOOTH ISSUE

This project contains about the simplest comparison I can make for testing this.

[This is the GitHub repo for this project](https://github.com/ChrisMarshallNY/TestCBIssue)

## THE ISSUE

When a MacOS app gets the [centralManager(_ central: CBCentralManager, didDiscover: CBPeripheral, advertisementData: [String : Any], rssi: NSNumber)](https://developer.apple.com/documentation/corebluetooth/cbcentralmanagerdelegate/1518937-centralmanager) callback, it delivers different data on the Mac, than on iOS.

The code is **EXACTLY** the same between them. I use a simple shared SwiftUI view to instantiate a dirt-simple CentralManager, and display discovered devices.

On iOS, I get the names of the devices.

On the Mac, I fail to get most of the names.

iOS console log:

    Discovered "Soulcatcher"
    Discovered "Croaker"
    Discovered "One-Eye"
    Discovered "[TV]Living Room TV"
    Discovered "Soulcatcher"
    Discovered "NO NAME!"
    Discovered "Desk"
    Discovered "NO NAME!"
    Discovered "Lady"
    Discovered "Eve Light Switch 60"
    Discovered "NO NAME!"
    Discovered "Tom-Tom"
    Discovered "The Limper"
    Discovered "TV"
    Discovered "NO NAME!"
    Discovered "NO NAME!"

Mac console log:

    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "Eve"
    Discovered "Eve Light Switch 60CC"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "Eve"
    Discovered "Eve Light Switch 60CC"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
    Discovered "NO NAME!"
