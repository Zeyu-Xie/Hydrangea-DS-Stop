import Cocoa

func requestAppleEventsPermission() {
    let targetBundleID = "com.apple.finder" // 替换为你需要与之交互的应用的 Bundle ID
    let appleEventDescriptor = NSAppleEventDescriptor(bundleIdentifier: targetBundleID)
    
    let event = NSAppleEventDescriptor(
        eventClass: AEEventClass(kCoreEventClass),
        eventID: AEEventID(kAEOpenDocuments),
        targetDescriptor: appleEventDescriptor,
        returnID: AEReturnID(kAutoGenerateReturnID),
        transactionID: AETransactionID(kAnyTransactionID)
    )
    
    var error: NSDictionary? = nil
    let appleScript = NSAppleScript(source: event.stringValue ?? "")
    appleScript?.executeAndReturnError(&error)
    
    if let error = error {
        print("Apple Events permission request failed: \(error)")
    } else {
        print("Apple Events permission requested successfully.")
    }
}
