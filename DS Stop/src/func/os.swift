import Foundation

func restartFinder() {
    let script = """
        tell application "Finder"
            quit
        end tell
        delay 1
        tell application "Finder"
            activate
        end tell
        """
        
    let process = Process()
    process.launchPath = "/usr/bin/osascript"
    process.arguments = ["-e", script]
    process.launch()
}
