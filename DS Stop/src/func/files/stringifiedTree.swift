import Foundation

// Return a stringified tree of files
func StringifiedTree(path: String) -> String {
    return _stringifyTree(tree: _listTree(path: path))
}
