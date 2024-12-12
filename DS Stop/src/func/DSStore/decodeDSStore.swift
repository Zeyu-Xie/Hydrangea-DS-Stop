import Foundation

func decodeDSStore(DSFilePath: String) -> String? {
    
    let process = Process()
    if let filePath = Bundle.main.path(
        forResource: "extractDSStore",
        ofType: ""
    ) {
        process.executableURL = URL(fileURLWithPath: filePath)
    } else {
        return nil
    }
    
    process.arguments = [DSFilePath]
    let outputPipe = Pipe()
    process.standardOutput = outputPipe
    process.standardError = outputPipe

    do {
        try process.run()
        process.waitUntilExit()
    
        let data = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)
        return output
    } catch {
        return nil
    }
}
