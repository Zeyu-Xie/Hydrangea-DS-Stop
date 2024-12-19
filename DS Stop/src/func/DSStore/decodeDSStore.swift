//
//  decodeDSStore.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//

import Foundation

func decodeDSStore(filePath: String?) -> (String,String) {
    
    if filePath == nil {
        return ("Error: The file path is nil.", "")
    }
    
    let process = Process()
    if let exeFilePath = Bundle.main.path(
        forResource: "decodeDSStore",
        ofType: ""
    ) {
        process.executableURL = URL(fileURLWithPath: exeFilePath)
    } else {
        return ("Error: Failed to locate executive file extractDSStore.", "")
    }
    
    process.arguments = [filePath!]
    let outputPipe = Pipe()
    process.standardOutput = outputPipe
    process.standardError = outputPipe

    do {
        try process.run()
        process.waitUntilExit()
        let data = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)
        if output == nil {
            return ("Error: The executive file returns nil.", "")
        }
        return ("Success", output!)
    } catch {
        return ("Error: Failed to run the executive file extractDSStore.", "")
    }
}

func _decodeJsonData(jsonString: String) -> (String, Dictionary<String, Any>) {
    if let jsonData = jsonString.data(using: .utf8) {
        do {
            if let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                return ("Success", dictionary)
            }
        } catch {
            return ("Error: \(error.localizedDescription)", [:])
        }
    }
    return ("Error: Failed to transform the string from python.", [:])
}
