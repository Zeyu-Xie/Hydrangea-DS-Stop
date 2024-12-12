import Foundation

func _stringifyTree(tree: Dictionary<String, Any>, indent: Int = 0) -> String {
    var output = ""
    let sortedTree = tree.sorted { $0.key < $1.key }
    for (key, value) in sortedTree {
        if value is String {
            output += String(repeating: " ", count: indent) + "  " + key + "\n"
        } else if value is Dictionary<String, Any> {
            output += String(repeating: " ", count: indent) + "- " + key + "\n"
            output += _stringifyTree(
                tree: value as! Dictionary<String,
                Any>,
                indent: indent + 2
            )
        }
    }
    return output
}
