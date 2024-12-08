import Foundation

let folderPath = ("~/Desktop/" as NSString).expandingTildeInPath
let folderURL = URL(fileURLWithPath: folderPath)

if let enumerator = FileManager.default.enumerator(at: folderURL, includingPropertiesForKeys: nil) {
    for case let fileURL as URL in enumerator {

        // if DS_Store file, print
        if fileURL.lastPathComponent == ".DS_Store" {
            print("DS_Store file: \(fileURL.path)")
        }
        else {
            continue
        }
    }
}
