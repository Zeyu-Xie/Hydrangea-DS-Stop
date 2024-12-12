import Foundation
import SwiftUI

func refreshDSStore(folderPath: inout String?) -> String {
    let originalValue: String? = folderPath
    folderPath = nil
    folderPath = originalValue
    return "Success"
}
