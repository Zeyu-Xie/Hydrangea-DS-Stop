import Foundation

func decodeDSStore(filePath: String?) -> (String, String) {
    
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
        decodeJsonData(jsonString: output!)
        if output == nil {
            return ("Error: The executive file returns nil.", "")
        }
        else {
            return ("Success", output!)
        }
    } catch {
        return ("Error: Failed to run the executive file extractDSStore.", "")
    }
}

func decodeJsonData(jsonString: String) {
    if let jsonData = jsonString.data(using: .utf8) {
        do {
            // 使用 JSONSerialization 解析
            if let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                print("解析成功: \(dictionary)")
            }
        } catch {
            print("解析失败: \(error.localizedDescription)")
        }
    } else {
        print("字符串转换为 Data 失败")
    }
}
